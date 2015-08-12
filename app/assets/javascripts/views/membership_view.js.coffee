Scribbly.Views.MembershipView = Backbone.View.extend(
  tagName: "li",
  className: "membership-list-item"
  template: JST['memberships/list_item']
  initialize: () ->
    this.listenTo this.model, 'change', this.render
    this.listenTo this.model, 'destroy', this.remove
  ,
  events: {
    "click a" : "clear"
  }
  render: () ->
    this.$el.html @template(member: @model)
    return this
  ,
  clear: () ->
    this.model.destroy(
      wait: true
    )
)
