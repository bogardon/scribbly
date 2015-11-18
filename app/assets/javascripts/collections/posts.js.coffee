Scribbly.Collections.Posts = Backbone.Collection.extend(
  model: Scribbly.Models.Post
  initialize: (attributes, options) ->

  url: () ->
    "/posts"
)
