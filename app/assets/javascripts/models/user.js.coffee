#= require models/model

class Classifieds.User extends Classifieds.Model
  @storageKey: 'users'
  @persist Batman.RailsStorage
  @encode 'id', 'first_name', 'last_name', 'email'
