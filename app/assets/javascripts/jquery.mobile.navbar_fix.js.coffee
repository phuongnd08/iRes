$.fn.setHeaderInactive = ->
  $(this).removeClass("ui-btn-active")

$.fn.setHeaderActive = ->
  $(this).addClass("ui-btn-active")

$(document).bind("pagechange", (event, data) ->
  data.toPage.find("[data-role=header] a[href$='##{data.toPage.attr('id')}']").setHeaderActive()
  data.toPage.find("[data-role=header] a:not([href$='##{data.toPage.attr('id')}'])").setHeaderInactive()
)
