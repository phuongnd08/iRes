$.rails.allowAction = (element) ->
  message = element.data("confirm")
  if message
    answer = false
    callback = undefined
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
