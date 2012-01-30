class @Waiter
  @setCurrentTableNumber = (tableNo) ->
    @currentTableNo = tableNo
  @initializeOrderPage = (page) ->
    page.find("[data-role=header] h1").
      text(I18n.t("order.for_table", { no: @currentTableNo}))
