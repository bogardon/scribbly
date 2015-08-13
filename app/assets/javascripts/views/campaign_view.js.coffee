Scribbly.Views.CampaignView = Backbone.View.extend(
  tagName: "li",
  className: "campaign-list-item"
  template: JST['campaigns/list_item']
  initialize: () ->
    this.listenTo this.model, 'change', this.render
    this.listenTo this.model, 'destroy', this.remove

  events: {

  }

  render: () ->
    this.$el.html @template(campaign: @model)
    return this
)
