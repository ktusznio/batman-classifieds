class Classifieds.AdsController extends Batman.Controller
  messageSendSuccess: null
  searchQueryError: false

  ads: null
  adsByUser: Classifieds.Ad.get('all').indexedBy('user_id')

  @accessor 'otherAds', ->
    userId = @get('ad.user_id')
    Classifieds.Ad.get('loaded.indexedBy.user_id').get(userId)

  index: (params) ->
    Classifieds.Ad.load (err) -> throw err if err

    switch params.filter
      when 'free', 'trade'
        @set 'ads', Classifieds.Ad.get('all').indexedBy('sale_type').get(params.filter)
      when 'previous'
        @set 'ads', Classifieds.Ad.get('all').indexedBy('active').get(false)
      else
        @set 'ads', Classifieds.Ad.get('all')

  show: (params) ->
    @set 'ad', Classifieds.Ad.find parseInt(params.id, 10), (err) ->
      throw err if err
    @set 'otherAd', Classifieds.Ad.get('all')
    @render source: 'ads/show.html'
    $('html, body').stop().animate(
      scrollTop: 0
    , 600,'easeInOutExpo')

  new: (params) ->
    @set 'ad', new Classifieds.Ad()
    @form = @render()

  create: (params) =>
    $('input', @form.get('node')).attr('disabled', true)
    $('form', @form.get('node')).spin()
    @get('ad').save (err) =>
      $('form', @form.get('node')).spin(false) # cancels spinner
      $('input', @form.get('node')).attr('disabled', false)

      if err
        throw err unless err instanceof Batman.ErrorsSet
      else
        Classifieds.flashSuccess "Ad #{@get('ad.title')} created successfully!"
        @redirect '/ads'

  edit: (params) ->
    @set 'ad', Classifieds.Ad.find parseInt(params.id, 10), (err) ->
      throw err if err
    @form = @render()

  update: ->
    $('input', @form.get('node')).attr('disabled', true)
    $('form', @form.get('node')).spin()
    @get('ad').save (err) =>
      $('form', @form.get('node')).spin(false) # cancels spinner
      $('input', @form.get('node')).attr('disabled', false)

      if err
        throw err unless err instanceof Batman.ErrorsSet
      else
        Classifieds.flashSuccess "Ad #{@get('ad.title')} updated successfully!"
        @redirect '/ads'

  submitSearch: (form) =>
    @redirect "/search?q=#{@get('searchQuery')}"

  search: (params) ->
    if params.q && (params.q = params.q.replace(/^\s+|\s+$/g,"")).length > 0
      @set 'searchQueryError', false
      @set 'searchQuery', params.q
      @set 'searchAds', null

      Classifieds.Ad.load {url: "/ads/search.json?q=#{params.q}"}, (error, records) =>
        throw error if error
        @set 'searchAds', records
    else
      @set 'searchQueryError', true

  sendMessage: () ->
    message = @get('ad.message')
    message.sendToOwner (err, message) =>
      if err
        throw err unless err instanceof Batman.ErrorsSet
      else
        @set('messageSendSuccess', "Your message about ad #{@get 'ad.title'} has been sent!")
        setTimeout =>
          @set('messageSendSuccess', null)
        , 3000

        ad = @get('ad')
        ad.set('message', ad.buildMessage())

