Scribbly.Views.PostsIndexView = Backbone.View.extend(
  template: JST['posts/index']
  id: "post-section"
  initialize: (options) ->
    @model = new Scribbly.Collections.Posts([], collaborationId: options.collaborationId)
    @fetchPosts(@dateRange(@savedDate()))

  render: () ->
    timeScale = @timeScale()
    savedDate = @savedDate()
    dateRange = @dateRange(savedDate)
    timeScaleTitle = switch timeScale
      when 'day'
        savedDate.format("dddd MM/DD")
      when 'week'
        start = dateRange.start
        end = dateRange.end
        if start.month() == end.month() && start.year() == end.year()
          "#{start.format("MMM")} #{start.date()} - #{end.date()}, #{start.format("YYYY")}"
        else if start.month() != end.month() && start.year() == end.year()
          "#{start.format("MMM")} #{start.date()} - #{end.format("MMM")} #{end.date()}, #{start.format("YYYY")}"
        else
          "#{start.format("MMM")} #{start.date()}, #{start.format("YYYY")} - #{end.format("MMM")} #{end.date()}, #{end.format("YYYY")}"
      when 'month'
        savedDate.format("MMMM YYYY")

    @$el.html(@template(timeScaleTitle: timeScaleTitle))

    @$el.find('.time-scale-select').each ->
      if $(this).data('scale') == timeScale
        $(this).removeClass('secondary')
      else
        $(this).addClass('secondary')

    @calendarView && @calendarView.remove()
    @calendarView = switch timeScale
      when 'day'
        new Scribbly.Views.CalendarDailyView(
          dateRange: dateRange
          savedDate: savedDate
          model: @model
        )
      when 'week'
        new Scribbly.Views.CalendarWeeklyView(
          dateRange: dateRange
          savedDate: savedDate
          model: @model
        )
      when 'month'
        new Scribbly.Views.CalendarMonthlyView(
          dateRange: dateRange
          savedDate: savedDate
          model: @model
        )

    @$el.append @calendarView.render().el

    @delegateEvents()

    this

  events:
    'click .time-scale-select': 'onTimeScaleSelectClick'
    'click .time-scale-arrow': 'onTimeScaleArrowClick'
    'click #today-button': 'onTodayButtonClick'
    'click #create-post-button': 'onCreatePost'

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

  onCreatePost: (event) ->
    @modalView && @modalView.remove()
    @modalView = new Scribbly.Views.PostCreateView(model: @model)
    $("body").append @modalView.render().el
    false
)
