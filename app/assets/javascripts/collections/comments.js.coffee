Scribbly.Collections.Comments = Backbone.Collection.extend(
  model: Scribbly.Models.Comment

  initialize: (attributes, options) ->

  url: () ->
    "/posts/#{@postId}/comments"
)
