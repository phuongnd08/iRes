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
    this.fadeIn().delay(3000).fadeOut('slow')
  handlers.hide = =>
    this.stop(true).hide()
    $('body').off('showToast', handlers.hide)
    delete handlers.show
    delete handlers.hide

  $('body').on('showToast', handlers.hide)
  handlers.show()

toastContainer = null

$.toast = (title, msg) ->
  if !toastContainer
    toastContainer = $('<div><h1 class="title"></h1><div class="msg"></div><div>').appendTo('body')
  toastContainer.find('.title').text(title)
  toastContainer.find('.msg').text(msg)
  toastContainer.toast()
