class AddToAdIndexJob < Struct.new(:id)
  def perform
    ad = Ad.find(id)
    index = SearchIndex.new
    
    begin
      logger.info "[AddToAdIndexJob] Indexing ad #{ad.id}"
      index.add(ad)
    rescue => e
      logger.info "[AddToAdIndexJob] Search indexing failed for ad #{ad.id}: #{e.message}"
    end
  end
  
  private
  def logger
    Rails.logger
  end
end