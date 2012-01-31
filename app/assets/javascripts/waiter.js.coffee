class @Waiter
  @orderedItems = []
  @setCurrentTableNumber = (tableNo) ->
    @currentTableNo = tableNo
    @refreshOrderPages()

  @setOrderingPage = (page) ->
    @orderingPage = page
    page.page()
    @refreshOrderPages()

  @setOrderedPage = (page) ->
    @orderedPage = page
    page.page()
    @refreshOrderPages()

  @refreshOrderPages = ->
    for page in [@orderedPage, @orderingPage]
      if page
        page.find("[data-role=header] h1").
          text(I18n.t("order.for_table", { no: @currentTableNo}))

  @addItem = (id, name) ->
    @orderedItems.push
      id: id
      name: name
    @orderedPage.find('ul.items').append("<li data-item-id='#{id}'>#{name}</li>")
    @orderedPage.find('ul.items').listview("refresh")
    @updateCounter()

  @updateCounter = ->
    @orderedPage.find('.counter').text(@orderedItems.length)
    @orderingPage.find('.counter').text(@orderedItems.length)
