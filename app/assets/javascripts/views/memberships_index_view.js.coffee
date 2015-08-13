Scribbly.Views.MembershipsIndexView = Backbone.View.extend (
  initialize: () ->
    @model = new Scribbly.Collections.Memberships([], collaborationId: @id)
    this.listenTo @model, 'add', this.addOne
    @model.fetch (
      success: (data) ->

    )

  events:
    "keypress #membership-form" : "createMember"

  createMember: (e) ->
    return unless e.keyCode == 13

    input = $(e.currentTarget)
    @model.create(
      {
        user:
          email: input.val()
      },
      {
        wait: true
      }
    )
    input.val('')

  addOne: (member) ->
    list = $("#membership-list")
    view = new Scribbly.Views.MembershipView(model: member)
    list.append(view.render().el)
)
