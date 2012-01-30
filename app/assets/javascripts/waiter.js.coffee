class @Waiter
  @setCurrentTableNumber = (tableNo) ->
    @currentTableNo = tableNo
    @refreshOrderPage()

  @initializeOrderPage = (page) ->
    @orderPage = page
    @refreshOrderPage()

  @refreshOrderPage = ->
    if @orderPage
      @orderPage.find("[data-role=header] h1").
        text(I18n.t("order.for_table", { no: @currentTableNo}))
