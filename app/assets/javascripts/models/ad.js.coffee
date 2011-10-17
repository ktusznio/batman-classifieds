#= require models/model

class Classifieds.Ad extends Classifieds.Model
  @storageKey: 'ads'
  adapter = @persist Batman.RailsStorage
  adapter.defaultOptions.formData = true # This is needed for the input type="file" serialization. See https://github.com/Shopify/batman/issues/183

  # Encoders / decoders
  @encode "created_at", "updated_at", "title", "sale_type", "description", "user_id", "best_offer", "images_attributes"

  @encode "user"
    encode: false
    decode: (json) ->
      u = new Classifieds.User
      u.fromJSON(json)
      u

  @encode "price"
    encode: (v) -> v
    decode: (str) -> parseInt(str, 10)

  @encode "created_at", "updated_at", Batman.Encoders.railsDate

  @encode 'images_attributes'
    encode: (images) ->
      obj = {}
      for file, i in images
        obj["#{i}"] = {image: file}
      obj
    decode: false

  @encode 'images'
    encode: false
    decode: (x) -> x

  # Valdidations
  @validate 'title', 'description', presence: true

  # Accessors
  @accessor 'message'
    get: -> @message ||= @buildMessage(); @message
    set: (k, v) -> @message = v; @message

  @accessor 'price'
    get: Batman.Model.defaultAccessor.get
    set: (k, v) ->
      v = if typeof v is 'string' then parseFloat(v) else v
      Batman.Model.defaultAccessor.set.call @, k, v
  buildMessage: -> new Classifieds.Message(ad_id: @get('id'))
