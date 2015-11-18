Scribbly.Views.PostCreateView = Backbone.View.extend(
  template: JST['posts/create']
  className: "modal-container"
  initialize: (options) ->
    @collaborationId = options.collaborationId

  events: {
    'click #cancel-create-button': "onClose"
    'click #submit-post-button': "onCreate"
  }

  render: () ->
    @$el.html @template()
    this

  onCreate: () ->
    title = @$el.find("#post-title").val()
    scheduled_at = @$el.find("#post-scheduled-at").val()
    @model.create(
      title: title
      collaboration_id: @collaborationId
      scheduled_at: scheduled_at
      timezone_offset: moment().zone() * 60
    )
    @onClose()

  onClose: () ->
    @remove()

)
