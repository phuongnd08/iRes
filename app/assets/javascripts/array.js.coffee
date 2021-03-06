falsy = (x) -> false
reflect = (x) -> x
Array::any = (callback = falsy) ->
  @.detect(callback) != null

Array::select = (callback) ->
  ret = []
  for item in @
    ret.push(item) if callback(item)
  ret

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

Array::removeIf = (callback) ->
  index = @length - 1
  while index >= 0
    if callback @[index]
      @splice(index, 1)
    index -= 1
  @

Array::map = (callback = reflect) ->
  callback(item) for item in @

Array::inject = (init, callback) ->
  result = init
  for item in @
    result = callback(result, item)
  result

Array::count = (callback) ->
  @inject 0, ((count, value) ->
    count += 1 if callback(value)
    count
  )

Array::sum = ->
  @inject 0, (sum, value) -> sum + value

Array::size = -> @length

Array::first = ->
  @[0]

Array::last = ->
  @[@.length-1]
