$.fn.formatListItem = ->
  $(this).find('.ui-li-count').addClass 'ui-btn-up-' + $(this).attr('data-count-theme')
