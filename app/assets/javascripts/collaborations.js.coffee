# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  # calendar stuff
  weeklyTemplate = _.template $("#weekly-template").html()

  dateRange = () ->
    date = $.cookie("saved_date")
    savedDate = if date? then moment(date) else moment()
    {start: moment(savedDate).startOf("week"), end: moment(savedDate).endOf("week")}

  fetchPosts = (dateRange) ->
    postsUrl = "/collaborations/#{$("#calendar").data('collaboration-id')}/posts"
    start = moment(dateRange.start)
    end = moment(dateRange.end)
    $.get postsUrl, start: start.toString(), end: end.toString()
    .success (data) ->

      # set new html for calendar div
      days = while start < end
        posts = _.filter data, (post) ->
          moment(post.scheduled_at) >= moment(start).startOf("day") &&
          moment(post.scheduled_at) <= moment(start).endOf('day')
        day =
          dayOfWeek: start.format("ddd")
          month: start.month() + 1
          date: start.date()
          posts: posts

        start.add(1, "day")
        day

      $("#calendar").html weeklyTemplate days

  $('#right-arrow').click (e) ->
    false

  $('#left-arrow').click (e) ->
    false

  fetchPosts(dateRange()) if $("#calendar").length

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
