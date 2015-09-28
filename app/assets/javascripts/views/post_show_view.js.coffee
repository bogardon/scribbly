Scribbly.Views.PostShowView = Backbone.View.extend(
  template: JST['posts/show']
  initialize: (options)->
    @model = new Scribbly.Models.Post(collaboration_id: options.collaborationId, id: options.postId)
    @model.urlRoot = '/posts'
    @listenTo @model.comments(), 'add', @addComment
    @listenTo @model.assets(), 'add', @addAsset
    @commentViews = []
    @assetViews = []
    @model.fetch()

  render: ->
    content = @template()
    @$el.html content
    @input = @$el.find("#new-comment-field")
    @upload = @$el.find("#upload-asset")
    @delegateEvents()
    this

  events:
    'keypress #new-comment-field': 'onCommentField'
    'click #post-comment-button': 'onPostButton'
    'click #upload-content-button': 'onUploadButton'
    'change #upload-asset': 'onFileSelect'

  onCommentField: (e) ->
    return unless e.keyCode == 13

    @createComment @input.val()

  onPostButton: () ->
    @createComment @input.val()

  onUploadButton: () ->
    @upload.trigger('click')

  onFileSelect: () ->
    file = @upload[0].files[0]
    formData = new FormData()
    formData.append('asset[image][attachment]', file, file.name)

    self = this
    @model.assets().create(
      {

      },
      {
        wait: true,
        data: formData,
        processData: false
        contentType: false
        success: ->
          self.refreshComments()
      }
    )

  createComment: (body) ->
    return unless body.length > 0

    @model.comments().create(
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

    _.each @assetViews, (assetView) ->
      assetView.remove()

  refreshComments: ->
    @model.comments().fetch()

  addAsset: (a) ->
    @listenTo a, "change", @refreshComments
    assetView = new Scribbly.Views.AssetListItemView(model: a)
    @assetViews.push assetView
    @$el.find("#asset-list").append assetView.render().$el

  addComment: (c) ->
    commentView = new Scribbly.Views.CommentListItemView(model: c)
    @commentViews.push commentView
    @$el.find("#comment-list").append commentView.render().$el
)
