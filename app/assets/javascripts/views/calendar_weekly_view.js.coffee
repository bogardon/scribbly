Scribbly.Views.CalendarWeeklyView = Backbone.View.extend(
  template: JST['calendar/weekly']
  initialize: (options) ->
    @dateRange = options.dateRange
    @savedDate = options.savedDate
    @render()
    this.listenTo @model, 'add', this.addOne

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
)
