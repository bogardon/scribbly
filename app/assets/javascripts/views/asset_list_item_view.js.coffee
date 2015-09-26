Scribbly.Views.AssetListItemView = Backbone.View.extend(
  template: JST['assets/list_item']
  tagName: "li"
  className: "asset-list-item"

  render: ->
    @$el.append @template(asset: @model)
    @delegateEvents()
    this
)
