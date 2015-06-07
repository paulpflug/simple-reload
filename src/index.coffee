recursiveDelete = (children) ->
  for child in children
    if require.cache[child.id]
      children = require.cache[child.id].children
      delete require.cache[child.id]
      recursiveDelete children if children?
  null

module.exports = (name,  deep=false) ->
  fullname = require.resolve(name)
  if require.cache[fullname]
    if deep
      recursiveDelete require.cache[fullname].children
    delete require.cache[fullname]
  require(fullname)
