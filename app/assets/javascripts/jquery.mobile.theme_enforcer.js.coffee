$.fn.formatListItem = ->
  countSpan = $(this).find('.ui-li-count')
  classes = countSpan.attr('class').split(' ').removeIf((clazz) -> /^ui\-btn\-up-/.test clazz)
  classes.push('ui-btn-up-' + $(this).attr('data-count-theme'))
  countSpan.attr 'class', classes.join(' ')
