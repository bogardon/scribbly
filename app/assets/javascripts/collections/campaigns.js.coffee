Scribbly.Collections.Campaigns = Backbone.Collection.extend(
  model: Scribbly.Models.Campaign

  initialize: (attributes, options) ->
    @collaborationId = options.collaborationId

  url: () ->
    "/collaborations/#{@collaborationId}/campaigns"
)
