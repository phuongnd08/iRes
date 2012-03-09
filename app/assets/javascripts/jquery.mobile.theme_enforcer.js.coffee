@formatListItem = (li)->
  $(li).find('.ui-li-count').addClass 'ui-btn-up-' + $(li).attr('data-count-theme')
