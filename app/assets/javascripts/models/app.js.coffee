window.Classifieds = class Classifieds extends Batman.App

  @navLinks: [
    {href: "#!/ads/all", text: "All Listings"},
    {href: "#!/ads/free", text: "Free"},
    {href: "#!/ads/trade", text: "Trade"},
    {href: "#!/ads/previous", text: "Previous Listings"}
  ]

  @root 'ads#all'
  @route '/ads/:id', 'ads#show', resource: 'ads', action: 'show'
  @route '/ads/:id/edit', 'ads#edit', resource: 'ads', action: 'edit'
  @route '/ads/new', 'ads#new', resource: 'ads', action: 'new'
  @route('/search', 'ads#search', {resource: 'ads', action: 'search'})

  @availableLocales: ['en', 'pr', 'fr']

  @on 'run', ->
    user = new Classifieds.User()
    user.url = '/sessions/current'
    user.load (err) -> throw err if err
    @set 'currentUser', user

  @on 'ready', ->
    console.log "Classifieds ready for use."

  @flash: Batman()
  @flash.accessor
    get: (k) -> @[k]
    set: (k, v) ->
      @[k] = v
      if v isnt ''
        setTimeout =>
          @set(k, '')
        , 2000
      v

  @flashSuccess: (message) -> @set 'flash.success', message
  @flashError: (message) ->  @set 'flash.error', message
