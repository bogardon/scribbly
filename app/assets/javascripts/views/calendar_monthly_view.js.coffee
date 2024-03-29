Scribbly.Views.CalendarMonthlyView = Backbone.View.extend(
  template: JST['calendar/monthly']
  id: "calendar"
  initialize: (options) ->
    @dateRange = options.dateRange
    @savedDate = options.savedDate
    this.listenTo @model, 'add', this.addOne

    @listViews = []

  remove: ->
    @removeAllListViews()

  render: ->
    start = moment(@dateRange.start)
    end = moment(@dateRange.end)
    days = while start < end
      day =
        description: start.toString()
        date: start.date()
        month: start.month()
        currentMonth: @savedDate.month() == start.month()
        today: moment().month() == start.month() && moment().date() == start.date() && moment().year() == start.year()
      start.add(1, "day")
      day

    content = @template(weekdays: moment.weekdaysShort(), days: days)
    @$el.html content

    @removeAllListViews()
    self = this
    @model.each (post) ->
      scheduledAt = moment(post.get("scheduled_at"))
      inRange = self.dateRange.start <= scheduledAt && self.dateRange.end >= scheduledAt
      self.addOne(post) if inRange

    this

  removeAllListViews: ->
    _.each @listViews, (listView) ->
      listView.remove()
      listView.unbind()

  addOne: (post) ->
    postListItemView = new Scribbly.Views.PostListItemView(model: post)
    postDate = moment(post.get("scheduled_at"))
    selector = "#date-#{postDate.month()}-#{postDate.date()}"
    postList = @$el.find(selector).find(".post-list")
    postList.append postListItemView.render().el
    @listViews.push postListItemView
)
