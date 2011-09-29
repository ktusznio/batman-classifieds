class RemoveFromAdIndexJob < Struct.new(:id)
  def perform
    ad = Ad.find(id)
    index = SearchIndex.new
    
    begin
      logger.info "[RemoveFromAdIndexJob] Removing ad #{ad.id}"
      index.delete(ad)
    rescue => e
      logger.info "[RemoveFromAdIndexJob] Removal from ad index failed for ad #{ad.id}: #{e.message}"
    end
  end
  
  private
  def logger
    Rails.logger
  end
end