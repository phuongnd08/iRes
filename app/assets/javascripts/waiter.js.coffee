class @Waiter
  @setCurrentTableNumber = (tableNo) ->
    @currentTableNo = tableNo
    @refreshOrderPages()

  @initializeOrderingPage = (page) ->
    @orderingPage = page
    @refreshOrderPages()

  @initializeOrderedPage = (page) ->
    @orderedPage = page
    @refreshOrderPages()

  @refreshOrderPages = ->
    for page in [@orderedPage, @orderingPage]
      if page
        page.find("[data-role=header] h1").
          text(I18n.t("order.for_table", { no: @currentTableNo}))

  @addItem = (id, name) ->
    @orderedPage.find('ul.items').append("<li data-item-id='#{id}'>#{name}</li>")
    @orderedPage.find('ul.items').listview("refresh")
