String.prototype.gsub = (hash) ->
  source = this
  for pattern, replacement of hash
    source = source.replace(new RegExp("\%\{#{pattern}\}", "g"), replacement)
  source
