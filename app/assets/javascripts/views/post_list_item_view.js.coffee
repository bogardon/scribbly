Scribbly.Views.PostListItemView = Backbone.View.extend(
  tagName: "li",
  className: "post-list-item"
  template: JST['posts/list_item']
  initialize: () ->
    @listenTo @model, 'change', @render
  ,
  events: {
  }
  render: () ->
    this.$el.html @template(post: @model)
    return this
)
