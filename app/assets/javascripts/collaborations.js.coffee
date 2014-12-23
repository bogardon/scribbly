# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  # calendar stuff
  dayTemplate = _.template $("#day-template").html()

  savedDate = () ->
    date = $.cookie("saved_date")
    if date?
      return moment(date)
    else
      return moment()

  fetchPostsInWeek = (date) ->
    postsUrl = "/collaborations/#{$("#calendar").data('collaboration-id')}/posts"
    $.get postsUrl, date: date.toString()
    .success (data) ->
      $.cookie("saved_date", date)

      calendar = $("#calendar")
      newHtml = ''
      data.forEach (pair) ->
        dayOfWeek = moment(pair[0])
        posts = pair[1]
        new_posts = _.map posts, (p) ->
          id: p.id, name: p.name, time: moment(p.scheduled_at).format("hh:mma")
        obj =
          moment:
            day: dayOfWeek.format("ddd")
            month: dayOfWeek.month() + 1
            date: dayOfWeek.date()
          posts: new_posts
        html = dayTemplate obj

        newHtml += html

      calendar.html newHtml

  $('#right-arrow').click (e) ->
    fetchPostsInWeek(savedDate().add(7, 'days'))
    false

  $('#left-arrow').click (e) ->
    fetchPostsInWeek(savedDate().add(-7, 'days'))
    false

  fetchPostsInWeek(savedDate()) if $("#calendar").length

  # membership stuff
  membershipTemplate = _.template $("#membership-template").html()

  fetchMembers = () ->
    membershipsUrl = "/collaborations/#{$("#membership-list").data('collaboration-id')}/memberships"
    $.get membershipsUrl
    .success (data) ->
      membershipListItems = (membershipTemplate member for member in data)
      $("#membership-list").html membershipListItems.join('')
      bindToMembershipX()

  $('input').focus () ->
    $(this).attr 'placeholder', 'Enter email'
  $('input').focusout () ->
    $(this).attr 'placeholder', 'Add member'

  $('#membership-form').on 'ajax:success', (xhr, data, status) ->
    $("#membership-form")[0].reset()
    $("#membership-list").append membershipTemplate data
    bindToMembershipX()

  bindToMembershipX = () ->
    $('.membership-x').on 'ajax:success', (xhr, data, status) ->
      debugger
      $(this).parent().remove()
    .on 'ajax:error', (xhr, status, error) ->
      debugger

  fetchMembers() if $("#membership-list").length
