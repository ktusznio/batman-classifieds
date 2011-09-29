class Message
  extend ActiveModel::Naming
  include ActiveModel::Serializers::JSON
  include ActiveModel::Validations

  attr_accessor :body, :ad_id
  validates :body, :presence => true

  def initialize(attributes = {})
    attributes.each do |k, v|
      if respond_to?("#{k}=")
        send("#{k}=", v)
      else
        raise(ActiveRecord::UnknownAttributeError, "unknown attribute: #{k}")
      end
    end
  end

  def deliver(fromWho)
    AdMailer.contact(fromWho, Ad.find(ad_id), @body).deliver
  end

  def attributes
    {'body' => body, 'ad_id' => ad_id}
  end
end
