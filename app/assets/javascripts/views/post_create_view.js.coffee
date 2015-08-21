Scribbly.Views.PostCreateView = Backbone.View.extend(
  template: JST['posts/create']
  className: "modal-container"
  initialize: () ->

  events: {
    'click #cancel-create-button': "onClose"
    'click #submit-post-button': "onCreate"
  }

  render: () ->
    @$el.html @template()
    this

  onCreate: () ->
    name = @$el.find("#post-name").val()
    scheduled_at = @$el.find("#post-scheduled-at").val()
    @model.create(
      name: name
      collaboration_id: @model.collaborationId
      scheduled_at: scheduled_at
      timezone_offset: moment().zone() * 60
    )
    @onClose()

  onClose: () ->
    @remove()

)
