Scribbly.Views.CollaborationsShowView = Backbone.View.extend(
  template: JST['collaborations/show']
  initialize: () ->
    @membershipsIndexView = new Scribbly.Views.MembershipsIndexView(@id)
    @model = new Scribbly.Models.Collaboration(id: @id)
    self = this
    @model.fetch(
      success: (data) ->
        self.render()
    )

  el: $('#content')

  render: ->
    content = @template(collaboration: @model)
    @$el.html content
    self = this
    $('.time-scale-select').filter ->
      $(this).data('scale') == self.timeScale()
    .toggleClass 'secondary'
    @fetchPosts(@dateRange(@savedDate()))
    this

  events:
    'click .time-scale-select': 'onTimeScaleSelectClick'
    'click .time-scale-arrow': 'onTimeScaleArrowClick'
    'click #today-button': 'onTodayButtonClick'

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
    start = moment(dateRange.start)
    end = moment(dateRange.end)
    posts = new Scribbly.Collections.Posts (collaborationId: @model.id, startDate: start, endDate: end)
    posts.fetch success: (data) ->
    # postsUrl = '/collaborations/' + @model.id + '/posts'
    # $.get postsUrl, start: start.toString(), end: end.toString()
    # .success (data) ->
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
              posts: _.filter data.models, (post) ->
                moment(post.attributes.scheduled_at) >= moment(start).startOf("day") &&
                moment(post.attributes.scheduled_at) <= moment(start).endOf('day')
            start.add(1, "day")
            day
          weeklyView = new Scribbly.Views.CalendarWeeklyView (collection: days, model: self.model)
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
                posts: _.filter data.models, (post) ->
                  moment(post.attributes.scheduled_at) >= moment(start).startOf("day") &&
                  moment(post.attributes.scheduled_at) <= moment(start).endOf('day')
              start.add(1, "day")
              day
          monthlyView = new Scribbly.Views.CalendarMonthlyView (collection: obj, model: self.model)
          monthlyView.render()
          self.onCalendarLoad()

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

  onTimeScaleArrowClick: (event) ->
    event.preventDefault()
    $btn = $(event.currentTarget)
    newDate = @savedDate().add($btn.data('scale-amount'), @timeScale())
    $.cookie 'saved_date', newDate
    @fetchPosts(@dateRange(newDate))
    false

  onTodayButtonClick: (event) ->
    event.preventDefault()
    newDate = moment()
    $.cookie 'saved_date', newDate
    @fetchPosts(@dateRange(newDate))

  onCreatePostButtonClick: (event) ->
    event.preventDefault()

)
