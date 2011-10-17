#= require models/model

class Classifieds.User extends Classifieds.Model
  @storageKey: 'users'
  @persist Batman.RailsStorage
  @encode 'id', 'first_name', 'last_name', 'email'

  @accessor 'name', -> "#{@get 'first_name'} #{@get 'last_name'}"
