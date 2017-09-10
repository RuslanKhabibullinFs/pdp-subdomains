class App.Components.StarRating extends App.Components.Base
  config:
    starsCount: 5
    input: "js-rating-:post-id"
    ratingUrl: "/posts/:post-id/rating.json"
    checkedStar: "checked-star"
    halfCheckedStar: "half-checked-star"
    uncheckedStar: "unchecked-star"

  constructor: (@$el) ->
    @currentPostId = @$el.data("post-id")
    @currentRating = @$el.data("rating") || 0
    @isDisabled = @$el.data("disabled")
    @_initializeStars()
    @_bindUI()
    @_bindListeners()

  _initializeStars: ->
    @$el.append @_generateInput(index) for index in [@config.starsCount..1]

  _bindUI: ->
    @ui =
      radioButtons: @$el.find "input[type='radio']"

  _bindListeners: ->
    @ui.radioButtons.on "change", @_updateStars
    $(document).on("app:rating:fetch:success", @_redrawStars)
  
  _updateStars: (e) =>
    parent.$("body").append(JST["templates/spinner/spinner"])
    currentRating = e.currentTarget.value
    @_sendUpdateRequest(currentRating)

  _sendUpdateRequest: (rating)=>
    $.ajax
      type: "POST"
      url: @config.ratingUrl.replace ":post-id", @currentPostId
      data:
        rating:
          rating: rating
      success:  @_onSuccess
      error: @_onFailure

  _onSuccess: =>
    $(document).trigger("app:rating:fetch", @currentPostId)

  _onFailure: (XMLHttpRequest) ->
    parent.$(".spinner").remove()
    errors = $.parseJSON(XMLHttpRequest.responseText).errors
    $(document).trigger("app:modal:error", errors)

  _redrawStars: (_event, newRating) =>
    @currentRating = newRating
    @isDisabled = true

    @$el.empty()
    @_initializeStars()

    parent.$(".spinner").remove()
    $(document).trigger("app:modal:notify", "Thanks for your feedback")

  _generateInput: (value) =>
    JST["templates/star/input"](
      inputId: @_inputId(value), disabled: @isDisabled, value: value, labelClass: @_labelClass(value)
    )

  _labelClass: (value)=>
    if @currentRating != 0 and value <= @currentRating
      @config.checkedStar
    else
      @_fillStarByRating(value - @currentRating)

  _fillStarByRating: (rating) =>
    return @config.uncheckedStar if rating > 0.76
    if rating < 0.26
      @config.checkedStar
    else
      @config.halfCheckedStar

  _inputId: (value) =>
    firstPartId = @config.input.replace ":post-id", @currentPostId
    "#{firstPartId}-#{value}"

$ ->
  if $(".js-star-ratings").length
    new App.Components.StarRating($(el)) for el in $(".js-star-ratings")
