Scribbly.Views.CollaborationShowView = Backbone.View.extend(
  template: JST['collaborations/show']
  initialize: () ->
    @model = new Scribbly.Models.Collaboration(id: @id)
    @listenTo @model, 'change', @render
    @model.fetch()

  render: ->
    content = @template(collaboration: @model)
    @$el.html content

    self.membershipsIndexView = new Scribbly.Views.MembershipsIndexView(
      id: @id
      el: $("#membership-section")
    )

    self.postsIndexView = new Scribbly.Views.PostsIndexView(
      id: @id
      el: $("#post-section")
    )

    this

  remove: ->
    self.membershipsIndexView && self.membershipsIndexView.remove()
    self.postsIndexView && self.postsIndexView.remove()
)
