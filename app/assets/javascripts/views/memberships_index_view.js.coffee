Scribbly.Views.MembershipsIndexView = Backbone.View.extend (
  template: JST['memberships/index']
  id: "membership-section"
  initialize: (options) ->
    @model = new Scribbly.Collections.Memberships([], collaborationId: options.collaborationId)
    this.listenTo @model, 'add', this.addOne
    @model.fetch()

  events:
    "keypress #membership-form" : "createMember"

  render: () ->
    @$el.html @template()
    this

  createMember: (e) ->
    debugger
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
    list = @$el.find("#membership-list")
    view = new Scribbly.Views.MembershipView(model: member)
    list.append(view.render().el)
)
