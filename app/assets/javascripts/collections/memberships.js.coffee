Scribbly.Collections.Memberships = Backbone.Collection.extend(
  initialize: (collaborationId) ->
    @collaborationId = collaborationId

  model: Scribbly.Models.Membership,
  url: () ->
    "/collaborations/#{@collaborationId}/memberships"
)
