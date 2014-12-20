# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  dayTemplate = _.template $("#day-template").html()

  savedDate = () ->
    date = $.cookie("saved_date")
    if date?
      return moment(date)
    else
      return moment()

  fetchPostsInWeek = (date) ->
    campaignId = $("#calendar").data('campaign-id')
    request = $.get "/campaigns/#{campaignId}/posts", date: date.toString()
    request.success (data) ->
      $.cookie("saved_date", date)

      calendar = $("#calendar")
      newHtml = ''
      data.forEach (pair) ->
        dayOfWeek = moment(pair[0])
        posts = pair[1]

        html = dayTemplate month: dayOfWeek.month() + 1, date: dayOfWeek.date(), posts: posts

        newHtml += html

      calendar.html newHtml

  $('#right-arrow').click (e) ->
    fetchPostsInWeek(savedDate().add(7, 'days'))

  $('#left-arrow').click (e) ->
    fetchPostsInWeek(savedDate().add(-7, 'days'))

  if $("#calendar").length
    fetchPostsInWeek(savedDate())
