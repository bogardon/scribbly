Scribbly.Views.AssetListItemView = Backbone.View.extend(
  template: JST['assets/list_item']
  tagName: "li"
  className: "asset-list-item"

  initialize: ->
    @model.urlRoot = '/assets'

  events:
    "click .asset-check": "onCheck"

  onCheck: (e) ->
    this.model.save(
      {
        approved_at: moment().toString()
      },
      {
        patch: true
      }
    )

  render: ->
    @$el.append @template(asset: @model)
    @delegateEvents()
    this
)
