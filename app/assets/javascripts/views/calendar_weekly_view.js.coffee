Scribbly.Views.CalendarWeeklyView = Backbone.View.extend(
  template: JST['calendar/weekly']
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
    start = @dateRange.start
    end = @dateRange.end
    weekdays = while start < end
      day =
        description: start.toString()
        day: start.format("ddd")
        month: start.month() + 1
        date: start.date()
      start.add(1, "day")
      day

    content = @template(weekdays: weekdays)
    $('#calendar').html content
    this

  addOne: (post) ->
    scheduledAt = moment(post.get("scheduled_at"))
    postListItemView = new Scribbly.Views.PostListItemView(model: post)
    @$el.find("#weekday-#{scheduledAt.format("ddd")}").find("ul").append postListItemView.render().el
)
