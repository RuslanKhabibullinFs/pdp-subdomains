class Component
  constructor: (el) ->
    @el = el
    @$el = $(el)
    @initialize()
    @bindings()

  initialize: ->
    #template method

  bindings: ->
    #template method

window.App = {}
window.App.Components =
  Base: Component
