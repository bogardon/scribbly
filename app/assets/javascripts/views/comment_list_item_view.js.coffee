Scribbly.Views.CommentListItemView = Backbone.View.extend(
  template: JST['comments/list_item']
  tagName: "li"
  className: "comment-list-item"

  render: ->
    @$el.html @template(comment: @model)
    @delegateEvents
    this
)
