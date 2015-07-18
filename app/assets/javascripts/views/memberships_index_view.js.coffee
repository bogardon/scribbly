Scribbly.Views.MembershipsIndexView = Backbone.View.extend (
  el: $("#membership-section")
  initialize: (collaborationId) ->
    @collaborationId = collaborationId
    @memberships = new Scribbly.Collections.Memberships(@collaborationId)
    this.listenTo @memberships, 'add', this.addOne
    @memberships.fetch {
    }
  addOne: (member) ->
    list = $("#membership-list")
    view = new Scribbly.Views.MembershipView(model: member)
    list.append(view.render().el)
)
