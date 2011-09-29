#= require models/model

class Classifieds.Message extends Classifieds.Model
  @storageKey: 'messages'
  @encode "body", "ad_id"
  @persist Batman.RailsStorage
  @validate 'body', {presence: true}

  sendToOwner: (callback) -> @save(callback)
