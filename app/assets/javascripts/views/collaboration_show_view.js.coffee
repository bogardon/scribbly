Scribbly.Views.CollaborationShowView = Backbone.View.extend(
  template: JST['collaborations/show']
  initialize: (options) ->
    @model = new Scribbly.Models.Collaboration(id: options.collaborationId)
    @listenTo @model, 'change', @updateTitle
    @model.fetch()

    @membershipsIndexView = new Scribbly.Views.MembershipsIndexView(
      collaborationId: options.collaborationId
    )

    @postsIndexView = new Scribbly.Views.PostsIndexView(
      collaborationId: options.collaborationId
    )

  render: ->
    content = @template(collaboration: @model)
    @$el.html content

    @$el.find("#left-column").html @membershipsIndexView.render().el
    @$el.find("#right-column").html @postsIndexView.render().el

    @delegateEvents()

    this

  updateTitle: ->
    @$el.find("#collaboration-name").html @model.escape("name")
    @$el.find("#collaboration-description").html @model.escape("description")

  remove: ->
    @membershipsIndexView && @membershipsIndexView.remove()
    @postsIndexView && @postsIndexView.remove()
)
