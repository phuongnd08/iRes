$.fn.forceCountSpanColor = ->
  this.each (index, element) ->
    countSpan = $(element).find('.ui-li-count')
    classes = countSpan.attr('class').split(' ').removeIf((clazz) -> /^ui\-btn\-up-/.test clazz)
    classes.push('ui-btn-up-' + $(element).attr('data-count-theme'))
    countSpan.attr 'class', classes.join(' ')
