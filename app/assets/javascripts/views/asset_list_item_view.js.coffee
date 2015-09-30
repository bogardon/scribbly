Scribbly.Views.AssetListItemView = Backbone.View.extend(
  template: JST['assets/list_item']
  tagName: "li"
  className: "asset-list-item"

  initialize: ->
    @model.urlRoot = '/assets'

  events:
    "click .asset-check": "onCheck"
    "click .asset-action-button": 'onAction'

  onAction: (e) ->
    @$el.find(".menu").toggleClass("hide");

  onCheck: (e) ->
    this.model.save(
      {
        approved_at: moment().toString()
      },
      {
        wait: true
        patch: true
      }
    )

  render: ->
    @$el.append @template(asset: @model)
    @delegateEvents()
    this
)
