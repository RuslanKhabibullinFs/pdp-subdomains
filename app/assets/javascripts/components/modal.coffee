class App.Components.Modal extends App.Components.Base
  config:
    content: ".js-modal-content"
 
  bindUI: ->
    @ui =
      content: @$el.find(@config.content)
 
  bindListeners: ->
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
