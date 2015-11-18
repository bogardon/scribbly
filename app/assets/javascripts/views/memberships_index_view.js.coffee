Scribbly.Views.MembershipsIndexView = Backbone.View.extend (
  template: JST['memberships/index']
  id: "membership-section"
  initialize: (options) ->
    @collaborationId = options.collaborationId
    @model = new Scribbly.Collections.Memberships()
    this.listenTo @model, 'add', this.addOne
    @model.fetch(
      data:
        collaboration_id: @collaborationId
    )

  events:
    "keypress #membership-form" : "createMember"

  render: () ->
    @$el.html @template()
    this

  createMember: (e) ->
    return unless e.keyCode == 13

    input = $(e.currentTarget)
    @model.create(
      {
        collaboration_id: @collaborationId
        user:
          email: input.val()
      },
      {
        wait: true
      }
    )
    input.val('')

  addOne: (member) ->
    list = @$el.find("#membership-list")
    view = new Scribbly.Views.MembershipView(model: member)
    list.append(view.render().el)
)
