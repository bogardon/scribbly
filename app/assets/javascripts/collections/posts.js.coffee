Scribbly.Collections.Posts = Backbone.Collection.extend(
  model: Scribbly.Models.Post
  initialize: (attributes, options) ->
    @collaborationId = options.collaborationId
  url: () ->
    "/collaborations/#{@collaborationId}/posts"
)
