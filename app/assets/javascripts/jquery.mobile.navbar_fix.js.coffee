$(document).bind("pagechange", (event, data) ->
  data.toPage.find("[data-role=header] a[href='##{data.toPage.attr('id')}']").addClass("ui-btn-active")
)
