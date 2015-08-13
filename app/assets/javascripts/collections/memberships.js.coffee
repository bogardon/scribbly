Scribbly.Collections.Memberships = Backbone.Collection.extend(
  model: Scribbly.Models.Membership

  initialize: (attributes, options) ->
    @collaborationId = options.collaborationId

  url: () ->
    "/collaborations/#{@collaborationId}/memberships"
)
