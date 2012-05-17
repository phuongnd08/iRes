$.rails.allowAction = (element) ->
  message = element.data("confirm")
  if message
    answer = false
    if $.rails.fire(element, "confirm")
      buttons = {}
      buttons[I18n.t("buttons.confirm.yes")] =
        click: ->
          orig = $.rails.allowAction
          $.rails.allowAction = -> true
          element.trigger('click')
          $.rails.allowAction = orig

      buttons[I18n.t("buttons.confirm.no")] =
        click: ->
        theme: "c"

      $(document).simpledialog2
        mode: "button"
        headerText: message
        headerClose: true
        buttons: buttons
    false
  else
    true

# hack around a mysterious error of jQuery Mobile on Android that cause all link hrefs to reset to #
rails = $.rails
$.rails.handleRemote = (element) ->
  method = undefined
  url = undefined
  data = undefined
  crossDomain = element.data("cross-domain") or null
  dataType = element.data("type") or ($.ajaxSettings and $.ajaxSettings.dataType)
  options = undefined
  if rails.fire(element, "ajax:before")
    if element.is("form")
      method = element.attr("method")
      url = element.attr("action")
      data = element.serializeArray()
      button = element.data("ujs:submit-button")
      if button
        data.push button
        element.data "ujs:submit-button", null
    else if element.is(rails.inputChangeSelector)
      method = element.data("method")
      url = element.data("url")
      data = element.serialize()
      data = data + "&" + element.data("params")  if element.data("params")
    else
      method = element.data("method")
      url = element.data("href") || element.attr("href")
      data = element.data("params") || { timestamp: (new Date()).getTime() }
    options =
      type: method or "GET"
      data: data
      dataType: dataType
      crossDomain: crossDomain
      beforeSend: (xhr, settings) ->
        xhr.setRequestHeader "accept", "*/*;q=0.5, " + settings.accepts.script  if settings.dataType is `undefined`
        rails.fire element, "ajax:beforeSend", [ xhr, settings ]

      success: (data, status, xhr) ->
        element.trigger "ajax:success", [ data, status, xhr ]

      complete: (xhr, status) ->
        element.trigger "ajax:complete", [ xhr, status ]

      error: (xhr, status, error) ->
        element.trigger "ajax:error", [ xhr, status, error ]

    options.url = url  if url
    rails.ajax options
  else
    false
