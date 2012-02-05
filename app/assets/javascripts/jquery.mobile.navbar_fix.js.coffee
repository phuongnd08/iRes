$(document).bind("pagechange", (event, data) ->
  data.toPage.find("[data-role=header] a[href$='##{data.toPage.attr('id')}']").addClass("ui-btn-active")
  data.toPage.find("[data-role=header] a:not([href$='##{data.toPage.attr('id')}'])").removeClass("ui-btn-active")
)
