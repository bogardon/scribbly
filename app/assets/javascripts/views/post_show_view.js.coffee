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
    )
    @contentsIndexView = new Scribbly.Views.ContentsIndexView(
      postId: @postId
    )
    @listenTo @contentsIndexView, 'content-change', @onContentChange
    @assetsIndexView = new Scribbly.Views.AssetsIndexView()
    @$el.find("#left-column").html @commentsIndexView.render().el
    @$el.find("#right-column").append @assetsIndexView.render().el
    @$el.find('#right-column').append @contentsIndexView.render().el

  onContentChange: (c) ->
    @assetsIndexView.setContentId(c.get("id"))
)
