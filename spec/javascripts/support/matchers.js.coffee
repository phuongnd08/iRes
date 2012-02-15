beforeEach ->
  @addMatchers
    toBeTheSameNodeAs: (node)->
      this.message = ->
        [ "Expected event #{this.actual.selector} to be same node as #{node.selector}" ]
      this.actual[0] == node[0]
