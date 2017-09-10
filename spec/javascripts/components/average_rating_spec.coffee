describe "App.Components.AverageRating", ->
  beforeEach ->
    loadFixtures("average_rating.html")
    @$averageRatingElement = $(".js-average-rating")
    @component = new App.Components.AverageRating(@$averageRatingElement)

  afterEach ->
    @$averageRatingElement.remove()
    $(document).off()
  
  afterEach ->
    @$averageRatingElement.remove()

  describe "when rating:fetch triggered", ->
    beforeEach ->
      @fetchEvent = spyOnEvent(document, "app:rating:fetch")
      @fetchRatingSpy = spyOn(App.Components.AverageRating.prototype, "_updateAverageRating")

      component = new App.Components.AverageRating(@$averageRatingElement)
      $(document).trigger("app:rating:fetch")

    it "call #_updateAverageRating callback", ->
      expect(@fetchEvent).toHaveBeenTriggered()
      expect(@fetchRatingSpy).toHaveBeenCalled()

  describe "when fetch was success", ->
    beforeEach ->
      postResponse =
        "average_rating": 3.5

      spyOn($, "ajax").and.callFake (options) -> options.success(postResponse)
      @fetchSuccessEvent = spyOnEvent(document, "app:rating:fetch:success")
      $(document).trigger("app:rating:fetch")

      
    it "update average rating", ->
      expect(@fetchSuccessEvent).toHaveBeenTriggered()
      expect($(".js-rating-value").text()).toEqual("3.5")

  describe "when fetch was fail", ->
    beforeEach ->
      spyOn($, "ajax").and.callFake (options) -> options.error()
      @fetchErrorEvent = spyOnEvent(document, "app:modal:error")
      $(document).trigger("app:rating:fetch")

    it "notify about error", ->
      expect(@fetchErrorEvent).toHaveBeenTriggered()

    
