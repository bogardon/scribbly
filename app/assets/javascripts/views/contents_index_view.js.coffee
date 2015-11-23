Scribbly.Views.ContentsIndexView = Backbone.View.extend (
  template: JST['contents/index']
  id: "content-section"
  initialize: (options) ->
    @postId = options.postId
    @listenTo @collection, 'add', @addContent
    @contentViews = []

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
    @trigger("content-select", @selectedContent.model)

  selectFirstContent: ->
    @contentViews[0].$el.trigger('click')

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
    self = this
    @collection.each (c) ->
      self.addContent(c)

    this

  addContent: (c) ->
    contentView = new Scribbly.Views.ContentListItemView(model: c)
    @contentViews.push contentView
    @$el.find("#content-list").append contentView.render().$el
)
