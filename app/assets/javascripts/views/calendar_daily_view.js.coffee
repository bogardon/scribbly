Scribbly.Views.CalendarDailyView = Backbone.View.extend(
  template: JST['calendar/daily']
  initialize: (options) ->
    @dateRange = options.dateRange
    @savedDate = options.savedDate
    @render()
    this.listenTo @model, 'add', this.addOne

    @listViews = []

    self = this
    @model.each (post) ->
      scheduledAt = moment(post.get("scheduled_at"))
      inRange = self.dateRange.start <= scheduledAt && self.dateRange.end >= scheduledAt
      self.addOne(post) if inRange

  remove: ->
    _.each @listViews, (listView) ->
      listView.remove()

  render: ->
    content = @template()
    @$el.html content
    this

  addOne: (post) ->
    postListItemView = new Scribbly.Views.PostListItemView(model: post)
    postList = @$el.find(".post-list")
    postList.append postListItemView.render().el

    @listViews.push postListItemView
)
