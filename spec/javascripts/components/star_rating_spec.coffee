describe "App.Components.StarRating", ->
  beforeEach ->
    loadFixtures("star_rating.html")
    @$ratingsElement = $(".js-star-ratings")
    @component = new App.Components.StarRating(@$ratingsElement)
  
  describe "#constructor", ->
    beforeEach ->
      @$uncheckedStar = $(".unchecked-star")
      @$checkedStar = $(".checked-star")

    it "initialize star inputs with right attributes", ->
      expect(@$uncheckedStar.length).toEqual(2)
      expect(@$checkedStar.length).toEqual(3)

  describe "click on .js-rating", ->
    it "add .spinner", ->
      $("label[for='js-rating-1-4']").click()
      expect($(".spinner")).toExist()

    describe "when request was success", ->
      beforeEach ->
        spyOn($, "ajax").and.callFake (options) -> options.success()
        @successEvent = spyOnEvent(document, "app:rating:fetch")
        $("label[for='js-rating-1-4']").click()

      it "trigger fetch rating events", ->
        expect(@successEvent).toHaveBeenTriggered()

    describe "when request was fail", ->
      beforeEach ->
        errorExample =
          responseText: '{"errors": "some error"}'
        spyOn($, "ajax").and.callFake (options) -> options.error(errorExample)
        @errorEvent = spyOnEvent(document, "app:modal:error")
        $("label[for='js-rating-1-4']").click()

      it "remove spinner", ->
        expect($(".spinner")).not.toExist()

      it "trigger error notification events", ->
        expect(@errorEvent).toHaveBeenTriggered()

  describe "rating successfully fetched event", ->
    beforeEach ->
      @modalEvent = spyOnEvent(document, "app:modal:notify")
      @redrawStarsSpy = spyOn(App.Components.StarRating.prototype, "_redrawStars")

      @component = new App.Components.StarRating(@$ratingsElement)
      $(document).trigger("app:rating:fetch:success", "2")

    it "call #redrawStars callback", ->
      expect(@modalEvent).toHaveBeenTriggered()
      expect(@redrawStarsSpy).toHaveBeenCalled()


  
