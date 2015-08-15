Scribbly.Views.PostListItemView = Backbone.View.extend(
  tagName: "li",
  className: "post-list-item"
  template: JST['posts/list_item']
  initialize: () ->
  ,
  events: {
  }
  render: () ->
    this.$el.html @template(post: @model)
    return this
)
