class SearchIndex
  SALE_TYPE = {
    'fixed' => 0,
    'free'  => 1,
    'trade' => 2
  }

  STATE = {
    "draft"  => 0,
    "active" => 1,
    "closed" => 2
  }

  class Results

    def initialize(result_set)
      @result_set = result_set
    end

    def ids
      @ids ||= @result_set['results'].map{|result| result['docid']}
    end
  end

  def initialize
    @client = IndexTank::Client.new(ENV['INDEXTANK_API_URL'])
  end

  def index
    @index ||= @client.indexes('idx')
  end

  def search(query)
    Results.new(index.search(query))
  end

  def add(ad)
    index.document(ad.id).add(convert_to_document(ad), :variables => extract_variables(ad))
  end

  def delete(ad)
    index.document(ad.id).delete
  end

  def import_all
    documents = Ad.active.collect do |ad|
      { :docid => ad.id, :fields => convert_to_document(ad), :variables => extract_variables(ad) }
    end
    index.batch_insert(documents)
  end

  def drop
    index.delete
  end

  def create
    index.add :public_search => true
  end

  private
  def sanitizer
    @sanitizer ||= HTML::WhiteListSanitizer.new
  end

  def strip_tags(text)
    sanitizer.sanitize(text, :tags => [])
  end

  def convert_to_document(ad)
    {
      :title => ad.title,
      :description => ad.description,
      :text => strip_tags("#{ad.title} #{ad.description}"),
      :timestamp => ad.created_at.to_i
    }
  end

  def extract_variables(ad)
    {
      0 => ad.price.to_f,
      1 => SALE_TYPE[ad.sale_type],
      2 => STATE[ad.state]
    }
  end

end
