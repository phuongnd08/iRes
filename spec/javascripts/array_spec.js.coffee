describe "array", ->
  describe "detect", ->
    describe "when matched item exists", ->
      it "returns matched item", ->
        x = [1, 2].detect (y)->
          y > 1
        expect(x).toEqual(2)

    describe "when matched item does not exist", ->
      it "returns null", ->
        x = [1, 2].detect (y)->
          y > 2
        expect(x).toBeNull()

  describe "contains", ->
    describe "when item exists inside array", ->
      it "returns true", ->
        expect([1, 2].contains(1)).toBeTruthy()

    describe "when item does not exist inside array", ->
      it "returns true", ->
        expect([1, 2].contains(3)).toBeFalsy()

    describe "when matched item does not exist", ->
      it "returns null", ->
        x = [1, 2].detect (y)->
          y > 2
        expect(x).toBeNull()

  describe "any", ->
    describe "when matched item exists", ->
      it "returns true", ->
        x = [1, 2].any (y)->
          y > 1
        expect(x).toBeTruthy()

    describe "when matched item does not exist", ->
      it "returns null", ->
        x = [1, 2].any (y)->
          y > 2
        expect(x).toBeFalsy()

  describe "remove", ->
    describe "when item exists inside array", ->
      it "removes the item from the array", ->
        arr = ['a', 'b', 'c']
        arr.remove 'b'
        expect(arr).toEqual(['a', 'c'])
    describe "when item does not exist inside array", ->
      it "throws exception", ->
        arr = ['a', 'b', 'c']
        expect(->
          arr.remove('d')
        ).toThrow()

  describe "inject", ->
    it "returns the aggregated result", ->
      arr = [1, 2, 3]
      expect(arr.inject(1, (res, element) -> res*element)).toEqual(6)
