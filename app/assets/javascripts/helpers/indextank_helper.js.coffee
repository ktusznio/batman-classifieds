#= require jquery.indextank.ize.js
#= require jquery.indextank.autocomplete.js

Batman.mixins.indexTank =
  initialize: ->
    form = this
    $(document).ready ->
      $(form).indextank_Ize("http://fg41.api.indextank.com", 'idx')
      $("input[type='text']:first", form).indextank_Autocomplete()
