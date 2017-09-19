class Component
  constructor: (el) ->
    @el = el
    @$el = $(el)
    @initialize()
    @bindUI()
    @bindListeners()

  initialize: ->
    #template method

  bindUI: ->
    #template method

  bindListeners: ->
    #template method

window.App = {}
window.App.Components =
  Base: Component
