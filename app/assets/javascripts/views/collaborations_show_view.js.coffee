Scribbly.Views.CollaborationsShowView = Backbone.View.extend(
  template: JST['collaborations/show']
  initialize: (data) ->
    @membershipsIndexView = new Scribbly.Views.MembershipsIndexView(@model.id)

  render: ->
    content = @template(collaboration: @model)
    @$el.html content
<<<<<<< Updated upstream
=======

    $('.time-scale-select').filter ->
      $(this).data('scale') == @timeScale()
    .toggleClass 'secondary'
>>>>>>> Stashed changes
    @fetchPosts(@dateRange(@savedDate()))
    this

  events:
    'click .time-scale-select': 'onTimeScaleSelectClick'
    'click .b': 'c'

  onCalendarLoad: () ->
    self = this
    btns = $('.time-scale-select')
    _.each btns, (btn) ->
      if $(btn).data('scale') == self.timeScale()
        $(btn).removeClass 'secondary'
      else
        $(btn).addClass 'secondary'
      return

  onTimeScaleSelectClick: (event) ->
    event.preventDefault()
    $btn = $(event.currentTarget)
    scale = $btn.data('scale')
    $.cookie("time_scale", scale)
    @fetchPosts(@dateRange(@savedDate()))

  savedDate: () ->
    date = $.cookie("saved_date")
    if date? then moment(date) else moment()

  dateRange: (date) ->
    self = this
    switch self.timeScale()
      when "day" then {start: moment(date).startOf("day"), end: moment(date).endOf("day")}
      when "week" then {start: moment(date).startOf("week"), end: moment(date).endOf("week")}
      when "month" then {start: moment(date).startOf("month").startOf("week"), end: moment(date).endOf("month").endOf("week")}

  timeScale: () ->
    scale = $.cookie("time_scale")
    if scale? then scale else "week"

  fetchPosts: (dateRange) ->
    self = this
    postsUrl = '/collaborations/' + @model.id + '/posts'
    start = moment(dateRange.start)
    end = moment(dateRange.end)
    $.get postsUrl, start: start.toString(), end: end.toString()
    .success (data) ->
      # set new html for calendar div
      switch self.timeScale()
        when "week"
          if start.month() == end.month() && start.year() == end.year()
            $("#time-scale-title").html "#{start.format("MMM")} #{start.date()} - #{end.date()}, #{start.format("YYYY")}"
          else if start.month() != end.month() && start.year() == end.year()
            $("#time-scale-title").html "#{start.format("MMM")} #{start.date()} - #{end.format("MMM")} #{end.date()}, #{start.format("YYYY")}"
          else
            $("#time-scale-title").html "#{start.format("MMM")} #{start.date()}, #{start.format("YYYY")} - #{end.format("MMM")} #{end.date()}, #{end.format("YYYY")}"

          days = while start < end
            day =
              description: start.toString()
              dayOfWeek: start.format("ddd")
              month: start.month() + 1
              date: start.date()
              posts: _.filter data, (post) ->
                moment(post.scheduled_at) >= moment(start).startOf("day") &&
                moment(post.scheduled_at) <= moment(start).endOf('day')
            start.add(1, "day")
            day
          weeklyView = new (Scribbly.Views.CalendarWeeklyView)(collection: days)
          weeklyView.render()
          self.onCalendarLoad()
        when "month"
          $("#time-scale-title").html self.savedDate().format("MMMM YYYY")
          obj =
            weekdays: moment.weekdaysShort()
            days: while start < end
              day =
                description: start.toString()
                date: start.date()
                currentMonth: self.savedDate().month() == start.month()
                today: moment().month() == start.month() && moment().date() == start.date() && moment().year() == start.year()
                posts: _.filter data, (post) ->
                  moment(post.scheduled_at) >= moment(start).startOf("day") &&
                  moment(post.scheduled_at) <= moment(start).endOf('day')
              start.add(1, "day")
              day
          monthlyView = new (Scribbly.Views.CalendarMonthlyView)(collection: obj)
          monthlyView.render()
          self.onCalendarLoad()
)
