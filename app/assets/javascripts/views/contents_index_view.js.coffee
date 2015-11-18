Scribbly.Views.ContentsIndexView = Backbone.View.extend (
  template: JST['contents/index']
  id: "content-section"
  initialize: (options) ->
    @postId = options.postId
    @model = new Scribbly.Collections.Contents()
    @listenTo @model, 'add', @addComment
    @contentViews = []
    this.listenTo @model, 'add', this.addContent
    @model.fetch(
      data:
        post_id: @postId
    )

  events:
    'click #add-new-content': 'onAddNewContent',
    'click .content-list-item': 'onContentListItem'

  onContentListItem: (e) ->
    @selectedContent && @selectedContent.$el.toggleClass('content-selected')
    @selectedContent = _.find(
      @contentViews,
      (c) ->
        c.el == e.target
    )
    @selectedContent && @selectedContent.$el.toggleClass('content-selected')
    @trigger("content-change", @selectedContent.model)

  onAddNewContent: (e) ->
    @model.create(
      {
        post_id: @postId
      },
      {wait: true}
    )

  render: () ->
    @$el.html @template()
    @input = @$el.find("#new-comment-field")
    @delegateEvents()
    this

  addContent: (c) ->
    contentView = new Scribbly.Views.ContentListItemView(model: c)
    @contentViews.push contentView
    @$el.find("#content-list").append contentView.render().$el
)
