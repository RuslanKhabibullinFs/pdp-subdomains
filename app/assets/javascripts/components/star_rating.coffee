App.Components ||= {}

class App.Components.StarRating
  config:
    starsCount: 5
    input: "js-rating-:post-id"
    ratingUrl: "/posts/:post-id/rating.json"
    checkedStarComponent: "js-star js-checked-star"
    halfCheckedStarComponent: "js-star js-half-checked-star"
    uncheckedStarComponent: "js-star js-unchecked-star"

  constructor: (@$el) ->
    @_initializeData()
    @_initializeStars()
    @_bindUI()
    @_bindListeners()

  _initializeData: ->
    @currentPostId = @$el.data("post-id")
    @currentRating = @$el.data("rating") || 0
    @isDisabled = @$el.data("disabled")

  _initializeStars: ->
    for index in [@config.starsCount..1]
      @$el.append @_generateInput(index)
      @$el.append @_generateLabel(index)

  _bindUI: ->
    @ui =
      radioButtons: @$el.find "input[type='radio']"

  _bindListeners: ->
    @ui.radioButtons.on "change", @_updateRating

  _updateRating: (e) =>
    @_sendUpdateRequest(e.currentTarget.value)
    @_updateFilledStars(e.target)
  
  _sendUpdateRequest: (currentRating) =>
    $.ajax
      type: "POST"
      url: @config.ratingUrl.replace ":post-id", @currentPostId
      data:
        rating:
          rating: currentRating
      success:  @_onSuccess
      error: @_onFailure

  _onSuccess: =>
    @ui.radioButtons.attr("disabled", true)
    $(document).trigger("app:rating:change", [@currentPostId, "Thanks for your feedback"])

  _onFailure: (XMLHttpRequest) ->
    errors = $.parseJSON(XMLHttpRequest.responseText).errors
    $(document).trigger("app:rating:error", errors)

  _updateFilledStars: (element) =>
    @$el.children()
      .removeClass("#{@config.checkedStarComponent} #{@config.halfcheckedStarComponent}")
      .addClass(@config.uncheckedStarComponent)
    $(element)
      .nextAll()
      .removeClass(@config.uncheckedStarComponent)
      .addClass(@config.checkedStarComponent)

  _generateInput: (value) =>
    input = document.createElement("input")
    input.setAttribute "id", @_uniqueInputId(value)
    input.setAttribute "class", "js-star"
    input.setAttribute "type", "radio"
    input.setAttribute "name", "rating"
    input.setAttribute "value", value
    input.setAttribute "disabled", "disabled" if @isDisabled
    input

  _generateLabel: (value) =>
    label = document.createElement("label")
    label.setAttribute "for", @_uniqueInputId(value)
    if @currentRating != 0 and value <= @currentRating
      label.setAttribute "class", @config.checkedStarComponent
    else
      label.setAttribute "class", @_fillStarByRating(value - @currentRating)
    label

  _fillStarByRating: (rating) =>
    return @config.uncheckedStarComponent if rating > 0.76
    if rating < 0.26
      @config.checkedStarComponent
    else
      @config.halfCheckedStarComponent

  _uniqueInputId: (value) =>
    firstPartId = @config.input.replace ":post-id", @currentPostId
    "#{firstPartId}-#{value}"

$ ->
  new App.Components.StarRating($(el)) for el in $(".js-star-ratings")
