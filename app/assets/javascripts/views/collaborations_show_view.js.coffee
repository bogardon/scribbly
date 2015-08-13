Scribbly.Views.CollaborationsShowView = Backbone.View.extend(
  template: JST['collaborations/show']
  initialize: () ->
    @model = new Scribbly.Models.Collaboration(id: @id)
    self = this
    @model.fetch(
      success: (data) ->
        self.render()
        self.membershipsIndexView = new Scribbly.Views.MembershipsIndexView(
          id: self.id
          el: $("#membership-section")
        )
        self.campaignsIndexView = new Scribbly.Views.CampaignsIndexView(
          id: self.id
          el: $("#campaign-section")
        )
        self.postsIndexView = new Scribbly.Views.PostsIndexView(
          id: self.id
          el: $("#post-section")
        )
    )

  render: ->
    content = @template(collaboration: @model)
    @$el.html content
    this
)
