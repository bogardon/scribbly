Scribbly.Views.PostShowView = Backbone.View.extend(
  template: JST['posts/show']
  initialize: (options)->
    @model = new Scribbly.Models.Post(collaboration_id: options.collaborationId, id: options.postId)
    @listenTo @model.comments, 'add', @addComment
    @commentViews = []
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

    @input.val("")

  remove: ->
    _.each @commentViews, (commentView) ->
      commentView.remove()

  addComment: (c) ->
    commentView = new Scribbly.Views.CommentListItemView(model: c)
    @commentViews.push commentView
    @$el.find("#comment-list").append commentView.render().$el
)
