window.Scribbly =
  Models: {},
  Collections: {},
  Views: {},
  Routers: {},
  initialize: () ->
    collaborations = new Scribbly.Collections.Collaborations
    collaborations.fetch (
      success: () ->
        new Scribbly.Routers.CollaborationsRouter($('#content'), collaborations)
        Backbone.history.start()
    )

$ ->
  Scribbly.initialize()