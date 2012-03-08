String.prototype.gsub = (hash) ->
  source = this
  for pattern, replacement of hash
    source = source.replace(new RegExp("\%\{#{pattern}\}", "g"), replacement)
    source = source.replace(new RegExp("\%\%7B#{pattern}\%7D", "g"), replacement)
  source
