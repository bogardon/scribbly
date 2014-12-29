# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  # calendar stuff
  dayTemplate = _.template $("#day-template").html()
  postTemplate = _.template $("#post-template").html()

  savedDate = () ->
    date = $.cookie("saved_date")
    if date?
      return moment(date)
    else
      return moment()

  allWeek = (date) ->

  fetchPostsInWeek = (date) ->
    postsUrl = "/collaborations/#{$("#calendar").data('collaboration-id')}/posts"
    start = moment(date).startOf("week")
    end = moment(date).endOf("week")
    $.get postsUrl, start: start.toString(), end: end.toString()
    .success (data) ->
      $.cookie("saved_date", date)

      dayListItems = while start < end
        dayListItem = $(dayTemplate day: start.format("ddd"), month: start.month()+1, date: start.date())
        _.each data, (post) ->
          scheduledAt = moment(post.scheduled_at)
          if  scheduledAt >= start and scheduledAt <= moment(start).endOf("day")
            dayListItem.children(".post-list").append postTemplate id: post.id, campaign_id: post.campaign_id, name: post.name, time: scheduledAt.format("hh:mma")
        start.add(1, "day")
        dayListItem

      calendar = $("#calendar")
      calendar.html dayListItems



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
      $(this).parent().remove()
    .on 'ajax:error', (xhr, status, error) ->

  fetchMembers() if $("#membership-list").length

  # campaign stuff
  campaignTemplate = _.template $("#campaign-template").html()

  fetchCampaigns = () ->
    campaignsUrl = "/collaborations/#{$("#campaign-list").data('collaboration-id')}/campaigns"
    $.get campaignsUrl
    .success (data) ->
      campaignListItems = (campaignTemplate campaign for campaign in data)
      $("#campaign-list").html campaignListItems.join('')
      bindToCampaignSelection()

  bindToCampaignSelection = () ->
    $('.campaign-selection').click (e) ->
      campaignItem = $(this)
      campaignItem.toggleClass "campaign-show"

      $(".post-list-item").filter (i, e) ->
        $(this).data('campaign-id') == campaignItem.parent().data('campaign-id')
      .toggleClass 'post-hide'


  fetchCampaigns() if $("#campaign-list").length
