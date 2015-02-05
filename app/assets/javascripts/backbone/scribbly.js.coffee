#= require_self
#= require_tree ./templates
#= require_tree ./models
#= require_tree ./views
#= require_tree ./routers

window.Scribbly =
  Models: {}
  Collections: {}
  Routers: {}
  Views: {}

$ ->
  Scribbly.Routers.AppRouter = Backbone.Router.extend {
    routes: {
      "" : "root",
      "collaborations/:id" : "collaborationShow"
    },
    root: () ->
      console.log "hey yo"
    collaborationShow: (collaborationId) ->
      console.log "hea;lkdjf"
  }

  appRouter = new Scribbly.Routers.AppRouter()

  Backbone.history.start()
