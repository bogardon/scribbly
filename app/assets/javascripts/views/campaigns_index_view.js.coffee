Scribbly.Views.CampaignsIndexView = Backbone.View.extend (
  initialize: () ->
    @model = new Scribbly.Collections.Campaigns([], collaborationId: @id)
    this.listenTo @model, 'add', this.addOne
    @model.fetch (
      success: (data) ->

    )

  events:
    "keypress #campaign-form" : "createCampaign"

  createCampaign: (e) ->
    return unless e.keyCode == 13

    input = $(e.currentTarget)
    @model.create(
      {
        campaign:
          name: input.val()
      },
      {
        wait: true
      }
    )
    input.val('')

  addOne: (campaign) ->
    list = $("#campaign-list")
    view = new Scribbly.Views.CampaignView(model: campaign)
    list.append(view.render().el)
)
