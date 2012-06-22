TOAST_SHOW_TIME = 3000
$.fn.toast = ->
  this.addClass('ui-toast')
  $('body').trigger('showToast') # hide all active toasts
  handlers = {}
  handlers.show = =>
    bw = $('body').width()
    bh = $('body').height()

    top = (bh*3/4) - this.height()/2
    left = bw/2 - this.width()/2

    this.css('top', top+'px')
    this.css('left', left+'px')
    this.fadeIn().delay(TOAST_SHOW_TIME).fadeOut('slow', -> handlers.remove())
  handlers.remove = =>
    this.stop(true).remove()
    $('body').off('showToast', handlers.remove)
    delete handlers.show
    delete handlers.remove

  $('body').on('showToast', handlers.remove)
  handlers.show()
  this.on 'click', handlers.remove

$.toast = (title, msg) ->
  container = $('<div><h1 class="title"></h1><div class="msg"></div><div>').appendTo('body')
  container.find('.title').text(title)
  container.find('.msg').text(msg)
  container.toast()
