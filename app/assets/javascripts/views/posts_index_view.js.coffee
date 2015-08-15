Scribbly.Views.PostsIndexView = Backbone.View.extend(
  template: JST['posts/index']

  initialize: () ->
    @model = new Scribbly.Collections.Posts([], collaborationId: @id)
    @render()
    @fetchPosts(@dateRange(@savedDate()))

  render: () ->
    @$el.html(@template(timeScaleTitle: @savedDate().format("MMMM YYYY")))

    timeScale = @timeScale()
    savedDate = @savedDate()
    dateRange = @dateRange(savedDate)
    $('.time-scale-select').each ->
      if $(this).data('scale') == timeScale
        $(this).removeClass('secondary')
      else
        $(this).addClass('secondary')

    @calendarView && @calendarView.remove()
    @calendarView = switch timeScale
      when 'week'
        new Scribbly.Views.CalendarWeeklyView()
      when 'month'
        new Scribbly.Views.CalendarMonthlyView(
          el: $("#calendar")
          dateRange: dateRange
          savedDate: savedDate
          model: @model
        )
    this

  events:
    'click .time-scale-select': 'onTimeScaleSelectClick'
    'click .time-scale-arrow': 'onTimeScaleArrowClick'
    'click #today-button': 'onTodayButtonClick'

  savedDate: () ->
    date = $.cookie("saved_date")
    if date? then moment(date) else moment()

  dateRange: (date) ->
    switch @timeScale()
      when "day" then {start: moment(date).startOf("day"), end: moment(date).endOf("day")}
      when "week" then {start: moment(date).startOf("week"), end: moment(date).endOf("week")}
      when "month" then {start: moment(date).startOf("month").startOf("week"), end: moment(date).endOf("month").endOf("week")}

  timeScale: () ->
    scale = $.cookie("time_scale")
    if scale? then scale else "month"

  fetchPosts: (dateRange) ->
    self = this
    start = moment(dateRange.start)
    end = moment(dateRange.end)
    @model.fetch(
      data:
        start: start.toString()
        end: end.toString()
      success: (data) ->
    )

  onTimeScaleSelectClick: (event) ->
    $btn = $(event.currentTarget)
    scale = $btn.data('scale')
    $.cookie("time_scale", scale)
    @render()
    @fetchPosts(@dateRange(@savedDate()))
    false

  onTimeScaleArrowClick: (event) ->
    $btn = $(event.currentTarget)
    newDate = @savedDate().add($btn.data('scale-amount'), @timeScale())
    $.cookie 'saved_date', newDate
    @render()
    @fetchPosts(@dateRange(@savedDate()))
    false

  onTodayButtonClick: (event) ->
    newDate = moment()
    $.cookie 'saved_date', newDate
    @render()
    @fetchPosts(@dateRange(@savedDate()))
    false
)
