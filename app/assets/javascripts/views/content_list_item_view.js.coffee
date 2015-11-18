Scribbly.Views.ContentListItemView = Backbone.View.extend(
  template: JST['contents/list_item']
  tagName: "li"
  className: "content-list-item"

  initialize: ->
    @model.urlRoot = '/contents'

  render: ->
    @$el.append @template(content: @model)
    @delegateEvents()
    this
)
