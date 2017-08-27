App.Components ||= {}

class App.Components.AverageRating
  config:
    valueClass: ".js-rating-value"
    postUrl: "/posts/:post-id.json"

  constructor: (@$el) ->
    @_bindUi()
    @_bindEvents()
 
  _bindUi: ->
    @ui =
      value: @$el.find(@config.valueClass)
 
  _bindEvents: ->
    $(document).on("app:rating:change", @_updateAverageRating)
  
  _updateAverageRating: (_event, postId) =>
    $.ajax
      type: "GET"
      url: @config.postUrl.replace ":post-id", postId
      success: @_onSuccess
      error: @_onFailure

  _onSuccess: (postObject) =>
    @ui.value.text(postObject["average_rating"])

  _onFailure: (_XMLHttpRequest, _textStatus, errorThrown) ->
    $(document).trigger("app:rating:error", errorThrown)

$ ->
  new App.Components.AverageRating($(el)) for el in $(".js-average-rating")
