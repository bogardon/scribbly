Scribbly.Collections.Contents = Backbone.Collection.extend(
  model: Scribbly.Models.Content

  initialize: (attributes, options) ->

  url: () ->
    "/contents"

  parse: (response) ->
    response
)
