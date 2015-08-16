Scribbly.Views.CalendarDailyView = Backbone.View.extend(
  template: JST['calendar/daily']
  initialize: (options) ->
    @dateRange = options.dateRange
    @savedDate = options.savedDate
    @render()
    this.listenTo @model, 'add', this.addOne

    @listViews && _.each @listViews, (listView) ->
      listView.remove()
    self = this
    @model.each (post) ->
      self.addOne(post)

  render: ->
    content = @template()
    $('#calendar').html content
    this

  addOne: (post) ->
    postListItem = new Scribbly.Views.PostListItemView(model: post)
    postList = @$el.find(".post-list")
    postList.append postListItem.render().el
)
