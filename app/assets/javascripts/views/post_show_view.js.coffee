Scribbly.Views.PostShowView = Backbone.View.extend(
  template: JST['posts/show']
  initialize: (options)->
    @model = new Scribbly.Models.Post(collaboration_id: options.collaborationId, id: options.postId)
    @listenTo @model, 'change', @render
    @listenTo @model.comments, 'add', @addComment
    @model.fetch()

  render: ->
    content = @template()
    @$el.html content
    @delegateEvents
    @input = @$el.find("#new-comment-field")
    this

  events:
    'keypress #new-comment-field': 'onCommentField'
    'click #post-comment-button': 'onPostButton'

  onCommentField: (e) ->
    return unless e.keyCode == 13

    @createComment @input.val()

  onPostButton: () ->
    @createComment @input.val()

  createComment: (body) ->
    return unless body.length > 0

    @model.comments.create(
      {
        comment:
          body: body
      },
      {
        wait: true
      }
    )

  addComment: (c) ->
    

)
