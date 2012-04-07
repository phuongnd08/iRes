describe "Waiter", ->
  describe "order", ->
    beforeEach ->
      Waiter.orderingPage = null
      Waiter.orderedPage = null
      Waiter.orderedItems = []
      loadFixtures("order")
      $('#order_page').page()

    afterEach ->
      $('#order_page').remove()

    describe "adding item", ->
      beforeEach ->
        $('#ordered_page').page()

      afterEach ->
        $('#ordered_page').remove()

      it "puts item in ordered list", ->
        Waiter.addItem(1, "Drink1", 15000)
        expect($('#ordered li:first')).toExist()
        expect($('#ordered li:first a:first span:first').text()).toEqual("Drink1")

      it "reupdates number of items indicator", ->
        Waiter.addItem(1, "Drink1", 15000)
        expect($('#order_page .item_counter')).toHaveText('1')
        Waiter.addItem(2, "Drink2", 20000)
        expect($('#order_page .item_counter')).toHaveText('2')

      it "reupdates total price of items indicator", ->
        Waiter.addItem(1, "Drink1", 15000)
        expect($('#order_page .total_price_counter')).toHaveText('15000')
        Waiter.addItem(2, "Drink2", 20000)
        expect($('#order_page .total_price_counter')).toHaveText('35000')
