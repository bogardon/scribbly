# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  # calendar stuff
  weeklyTemplate = _.template $("#weekly-template").html()
  monthlyTemplate = _.template $("#monthly-template").html()

  savedDate = () ->
    date = $.cookie("saved_date")
    if date? then moment(date) else moment()

  dateRange = (date) ->
    switch timeScale()
      when "day" then {start: moment(date).startOf("day"), end: moment(date).endOf("day")}
      when "week" then {start: moment(date).startOf("week"), end: moment(date).endOf("week")}
      when "month" then {start: moment(date).startOf("month").startOf("week"), end: moment(date).endOf("month").endOf("week")}

  timeScale = () ->
    scale = $.cookie("time_scale")
    if scale? then scale else "week"

  fetchPosts = (dateRange) ->
    postsUrl = "/collaborations/#{$("#calendar").data('collaboration-id')}/posts"
    start = moment(dateRange.start)
    end = moment(dateRange.end)
    $.get postsUrl, start: start.toString(), end: end.toString()
    .success (data) ->
      # set new html for calendar div
      switch timeScale()
        when "week"
          if start.month() == end.month() && start.year() == end.year()
            $("#time-scale-title").html "#{start.format("MMM")} #{start.date()} - #{end.date()}, #{start.format("YYYY")}"
          else if start.month() != end.month() && start.year() == end.year()
            $("#time-scale-title").html "#{start.format("MMM")} #{start.date()} - #{end.format("MMM")} #{end.date()}, #{start.format("YYYY")}"
          else
            $("#time-scale-title").html "#{start.format("MMM")} #{start.date()}, #{start.format("YYYY")} - #{end.format("MMM")} #{end.date()}, #{end.format("YYYY")}"

          days = while start < end
            day =
              dayOfWeek: start.format("ddd")
              month: start.month() + 1
              date: start.date()
              posts: _.filter data, (post) ->
                moment(post.scheduled_at) >= moment(start).startOf("day") &&
                moment(post.scheduled_at) <= moment(start).endOf('day')
            start.add(1, "day")
            day
          $("#calendar").html weeklyTemplate days
        when "month"
          $("#time-scale-title").html savedDate().format("MMMM YYYY")
          obj =
            weekdays: moment.weekdaysShort()
            days: while start < end
              day =
                date: start.date()
                currentMonth: savedDate().month() == start.month()
                today: moment().month() == start.month() && moment().date() == start.date() && moment().year() == start.year()
                posts: _.filter data, (post) ->
                  moment(post.scheduled_at) >= moment(start).startOf("day") &&
                  moment(post.scheduled_at) <= moment(start).endOf('day')
              start.add(1, "day")
              day
          $("#calendar").html monthlyTemplate obj

  $("#today-button").click (e) ->
    newDate = moment()
    $.cookie 'saved_date', newDate
    fetchPosts(dateRange(newDate))

  $('.time-scale-arrow').click (e) ->
    newDate = savedDate().add($(this).data('scale-amount'), timeScale())
    $.cookie 'saved_date', newDate
    fetchPosts(dateRange(newDate))
    false

  $('.time-scale-select').click (e) ->
    $.cookie("time_scale", $(this).data('scale'))
    $('.time-scale-select').toggleClass 'secondary'
    fetchPosts(dateRange(savedDate()))

  if $("#calendar").length
    $('.time-scale-select').filter ->
      $(this).data('scale') == timeScale()
    .toggleClass 'secondary'
    fetchPosts(dateRange(savedDate()))

  # membership stuff
  membershipTemplate = _.template $("#membership-template").html()

  fetchMembers = () ->
    membershipsUrl = "/collaborations/#{$("#membership-list").data('collaboration-id')}/memberships"
    $.get membershipsUrl
    .success (data) ->
      membershipListItems = (membershipTemplate member for member in data)
      $("#membership-list").html membershipListItems.join('')
      bindToMembershipX()

  $('#membership-form').on 'ajax:success', (xhr, data, status) ->
    $(this)[0].reset()
    $("#membership-list").append membershipTemplate data
    bindToMembershipX()

  bindToMembershipX = () ->
    $('.membership-x').off 'ajax:success'
    .on 'ajax:success', (xhr, data, status) ->
      $(this).parent().remove()

  fetchMembers() if $("#membership-list").length

  # campaign stuff
  campaignTemplate = _.template $("#campaign-template").html()

  $('#campaign-form').on 'ajax:success', (xhr, data, status) ->
    $(this)[0].reset()
    $("#campaign-list").append campaignTemplate data
    bindToCampaignSelection()

  fetchCampaigns = () ->
    campaignsUrl = "/collaborations/#{$("#campaign-list").data('collaboration-id')}/campaigns"
    $.get campaignsUrl
    .success (data) ->
      campaignListItems = (campaignTemplate campaign for campaign in data)
      $("#campaign-list").html campaignListItems.join('')
      bindToCampaignSelection()

  bindToCampaignSelection = () ->
    $('.campaign-selection').unbind('click').click (e) ->
      console.log "sup"
      campaignItem = $(this)
      campaignItem.toggleClass "campaign-show"

      $(".post-list-item").filter (i, e) ->
        $(this).data('campaign-id') == campaignItem.parent().data('campaign-id')
      .toggleClass 'post-hide'
      false

  fetchCampaigns() if $("#campaign-list").length
