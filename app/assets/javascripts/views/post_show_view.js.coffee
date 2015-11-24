Scribbly.Views.PostShowView = Backbone.View.extend(
  template: JST['posts/show']
  initialize: (options)->
    @postId = options.postId
    @model = new Scribbly.Models.Post(collaboration_id: options.collaborationId, id: options.postId)
    @model.fetch()
    @listenTo @model, 'change', @onLoad

  render: ->
    content = @template()
    @$el.html content
    this

  onLoad: ->
    @$el.find("#post-title").html @model.escape("title")
    @commentsIndexView = new Scribbly.Views.CommentsIndexView(
      postId: @postId
      collection: @model.comments()
    )
    @contentsIndexView = new Scribbly.Views.ContentsIndexView(
      postId: @postId
      collection: @model.contents()
    )
    @assetsIndexView = new Scribbly.Views.AssetsIndexView(
    )
    @$el.find("#left-column").html @commentsIndexView.render().el
    @$el.find("#right-column").append @assetsIndexView.render().el
    @$el.find('#right-column').append @contentsIndexView.render().el

    @listenTo @contentsIndexView, 'content-select', @onContentSelect
    @contentsIndexView.selectFirstContent()

  onContentSelect: (content) ->
    @assetsIndexView.collection.set content.assets().models
)
