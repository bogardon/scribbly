window.Scribbly =
  Models: {},
  Collections: {},
  Views: {},
  Routers: {},
  initialize: () ->
    new Scribbly.Routers.CollaborationsRouter()
    Backbone.history.start()
$ ->
  Scribbly.initialize()
