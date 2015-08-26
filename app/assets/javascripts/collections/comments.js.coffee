Scribbly.Collections.Comments = Backbone.Collection.extend(
  model: Scribbly.Models.Comment

  initialize: (attributes, options) ->
    @collaborationId = options.collaborationId
    @postId = options.postId

  url: () ->
    "/collaborations/#{@collaborationId}/posts/#{@postId}/comments"
)
