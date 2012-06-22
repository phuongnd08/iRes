@Scroller =
  refresh: (element) ->
    setTimeout (->
      $(element).data("scroller").refresh()
    ), 0

  setUp: (element, options) ->
    element = $(element)
    options = options or {}
    iScrollOptions =
      vScroll: true
      hScroll: false
      vScrollbar: false
      hScrollbar: false

    if options.pullTrackingEnabled
      @enhanceForPullTracking element
      iScrollOptions = $.extend(iScrollOptions, @getPullEnabledTrackingOptions(element, options))

    if element.data('scroller')
      element.data('scroller').destroy()
    else
      element.data('scroller', new iScroll(element[0], iScrollOptions))

  enhanceForPullTracking: (element) ->
    innerElement = element.find("*:first")
    pullDownDivHtml = """
      <div class="pull-down">
        <span class="pull-down-icon"></span><span class="pull-down-label">Pull down to refresh...</span>
      </div>
    """
    innerElement.prepend $(pullDownDivHtml)
    pullUpDivHtml = """
      <div class="pull-up">
        <div class='more-results-wrapper invisible'>
          <div class='more-results-spin spin'>
          </div>
        </div>
      </div>
    """
    innerElement.append $(pullUpDivHtml)

  getPullEnabledTrackingOptions: (element, options) ->
    pullDownDiv = element.find(".pull-down")
    pullDownOffset = pullDownDiv.outerHeight()
    pullUpDiv = element.find(".pull-up")
    pullUpOffset = pullUpDiv.outerHeight()
    emptyFunc = ->

    options.onScrollStart = options.onScrollStart or emptyFunc
    options.onScrollEnd = options.onScrollEnd or emptyFunc
    options.onPulledDown = options.onPulledDown or emptyFunc
    options.onPulledUp = options.onPulledUp or emptyFunc

    resetPullingDown = ->
      pullDownDiv.removeClass "flip"
      pullDownDiv.find(".pull-down-label").text I18n.t("pulling.pulldown_to_refresh")
      @minScrollY = -pullDownOffset

    topOffset: pullDownOffset
    onScrollMove: ->
      options.onScrollStart()
      if @y > 5 and not pullDownDiv.hasClass("flip")
        pullDownDiv.addClass "flip"
        pullDownDiv.find(".pull-down-label").text I18n.t("pulling.release_to_refresh")
        @minScrollY = 0
      else if @y < 5 and pullDownDiv.hasClass("flip")
        resetPullingDown.call(@)
      else if @y < (@maxScrollY - 5) and not pullUpDiv.hasClass("flip")
        pullUpDiv.addClass "flip"
        @maxScrollY = @maxScrollY
      else if @y > (@maxScrollY + 5) and pullUpDiv.hasClass("flip")
        pullUpDiv.removeClass "flip"
        @maxScrollY = pullUpOffset

    onScrollEnd: ->
      setTimeout (->
        options.onScrollEnd()
      ), 0
      if pullDownDiv.hasClass("flip")
        options.onPulledDown()
      else if pullUpDiv.hasClass("flip")
        pullUpDiv.removeClass "flip"
        options.onPulledUp()
      resetPullingDown.call(@)
      @refresh()
