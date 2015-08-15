Scribbly.Views.CalendarMonthlyView = Backbone.View.extend(
  template: JST['calendar/monthly']
  initialize: (options) ->
    @dateRange = options.dateRange
    @savedDate = options.savedDate
    @render()
    this.listenTo @model, 'add', this.addOne

  render: ->
    start = @dateRange.start
    end = @dateRange.end
    days = while start < end
      day =
        description: start.toString()
        date: start.date()
        currentMonth: @savedDate.month() == start.month()
        today: moment().month() == start.month() && moment().date() == start.date() && moment().year() == start.year()
      start.add(1, "day")
      day

    content = @template(weekdays: moment.weekdaysShort(), days: days)
    $('#calendar').html content
    this

  addOne: (post) ->
    postListItem = new Scribbly.Views.PostListItemView(model: post)
    postDate = moment(post.get("scheduled_at"))
    selector = "#date-#{postDate.date()}"
    postList = $(selector).find(".post-list")
    postList.append postListItem.render().el
)
