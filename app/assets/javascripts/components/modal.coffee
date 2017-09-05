App.Components ||= {}

class App.Components.Modal
  config:
    content: ".js-modal-content"

  constructor: (@$el) ->
    @_bindUi()
    @_bindEvents()
 
  _bindUi: ->
    @ui =
      content: @$el.find(@config.content)
 
  _bindEvents: ->
    $(document).on("app:modal:notify", @_showNotification)
    $(document).on("app:modal:error", @_showError)
  
  _showNotification: (_event, modalContent) =>
    @ui.content.text(modalContent)
    @$el.modal("show")

  _showError: (_event, errors) =>
    errors = ("#{attribute} - #{message}" for attribute, message of errors) if typeof errors is "object"
    @ui.content.text(errors)
    @$el.modal("show")

$ ->
  new App.Components.Modal($(el)) for el in $(".js-modal")
