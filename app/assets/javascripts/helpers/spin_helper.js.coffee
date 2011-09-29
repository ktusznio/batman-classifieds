#= require 'spin'

defaultOpts =
  lines: 12
  length: 24
  width: 8
  radius: 25
  color: "#000"
  speed: 1.3
  trail: 60
  shadow: true

jQuery.fn.spin = (passedOpts) ->
  opts = Batman.mixin {}, defaultOpts, passedOpts
  @each ->
    $this = jQuery(this)
    data = $this.data()
    if data.spinner
      data.spinner.stop()
      delete data.spinner
    data.spinner = new Spinner(jQuery.extend(color: $this.css("color"), opts)).spin(this) if passedOpts != false

  this
