falsy = (x) -> false
reflect = (x) -> x
Array::any = (callback = falsy) ->
  @.detect(callback) != null

Array::detect = (callback = falsy) ->
  for item in @
    return item if callback(item)
  null

Array::contains = (item) ->
  @indexOf(item) >= 0

Array::remove = (item) ->
  if @contains(item)
    @splice(@indexOf(item), 1)
  else
    throw "Element #{item} does not exist"

Array::map = (callback = reflect) ->
  callback(item) for item in @

Array::inject = (init, callback) ->
  result = init
  for item in @
    result = callback(result, item)
  result

Array::first = ->
  @[0]

Array::last = ->
  @[@.length-1]
