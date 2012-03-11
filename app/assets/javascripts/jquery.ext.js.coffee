$.fn.setVisible = (visible)->
  $(this)[if visible then 'show' else 'hide']()

$.fn.fadeOutAndRemove = ->
  $(this).fadeOut('slow', ->
    $(this).remove()
  )

$.fn.blinkAndShow = ->
  $(this).fadeOut('fast').fadeIn('slow')
