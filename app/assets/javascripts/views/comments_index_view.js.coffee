Scribbly.Views.CommentsIndexView = Backbone.View.extend (
  template: JST['comments/index']
  id: "comment-section"
  initialize: (options) ->
    @postId = options.postId
    @listenTo @collection, 'add', @addComment
    @commentViews = []

  events:
    'keypress #new-comment-field': 'onCommentField'
    'click #post-comment-button': 'onPostButton'

  render: () ->
    @$el.html @template()
    @input = @$el.find("#new-comment-field")
    @delegateEvents()

    self = this
    @collection.each (c) ->
      self.addComment(c)

    this

  addComment: (c) ->
    commentView = new Scribbly.Views.CommentListItemView(model: c)
    @commentViews.push commentView
    @$el.find("#comment-list").append commentView.render().$el

  onCommentField: (e) ->
    return unless e.keyCode == 13

    @createComment @input.val()

  onPostButton: () ->
    @createComment @input.val()

  createComment: (body) ->
    return unless body.length > 0

    @collection.create(
      {
        post_id: @postId
        comment:
          body: body
      },
      {
        wait: true
      }
    )

    @input.val("")
)
