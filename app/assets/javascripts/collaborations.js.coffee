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
              description: start.toString()
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
                description: start.toString()
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
    $('#create-post-modal').foundation("reveal", "close")

  # post creation stuff
  optionTemplate = _.template $("#campaign-option-template").html()

  $("#create-post-button").click (e) ->
    $('#create-post-modal')
    .foundation('reveal', 'open')
    .find("#offset").val(moment().zone() * 60)
    .end()
    .find("#post_campaign_id").html (optionTemplate c for c in campaigns)

  $("#post-form").on 'ajax:success', (xhr, data, status) ->
    fetchPosts(dateRange(savedDate()))

  # membership backboned
  Member = Backbone.Model.extend {
  }

  collaborationId = location.pathname.split('/').pop()

  MemberList = Backbone.Collection.extend {
    model: Member,
    initialize: (models, options) ->
      this.collaborationId = options.collaborationId
    ,
    url: () ->
      "/collaborations/#{this.collaborationId}/memberships"
    ,
  }

  Members = new MemberList([], {collaborationId: collaborationId})

  MemberView = Backbone.View.extend {
    tagName: "li",
    className: "membership-list-item"
    template: _.template($("#membership-template").html()),
    initialize: () ->
      this.listenTo this.model, 'change', this.render
      this.listenTo this.model, 'destroy', this.remove
    ,
    events: {
      "click a" : "clear"
    }
    render: () ->
      this.$el.html this.template(this.model.toJSON())
      return this
    ,
    clear: () ->
      this.model.destroy()
  }

  MemberSectionView = Backbone.View.extend {
    el: $("#membership-section"),
    initialize: () ->
      this.input = $("#membership-form")
      this.list = $("#membership-list")
      this.listenTo Members, 'add', this.addOne
      this.listenTo Members, 'all', this.render
      Members.fetch {
        data:
          collaboration_id: collaborationId
      }
    ,
    events: {
      "keypress #membership-form":  "createOnEnter",
    },
    createOnEnter: (e) ->
      return unless e.keyCode == 13

      Members.create {
        user:
          email: this.input.val()
      }
      this.input.val('')
    ,
    addOne: (member) ->
      view = new MemberView({model: member})
      this.list.append(view.render().el)
  }

  MembersView = new MemberSectionView

  # campaign stuff
  campaignTemplate = _.template $("#campaign-template").html()
  campaigns = []

  campaignShown = (campaignId) ->
    $.parseJSON($.cookie("show-campaign-#{campaignId}") || true)

  toggleCampaignShown = (campaignId) ->
    $.cookie("show-campaign-#{campaignId}", !campaignShown(campaignId))

  $('#campaign-form').on 'ajax:success', (xhr, data, status) ->
    $(this)[0].reset()
    data.shown = campaignShown(data.id)
    campaigns.push data
    $("#campaign-list").append campaignTemplate data
    bindToCampaignSelection()

  fetchCampaigns = () ->
    campaignsUrl = "/collaborations/#{$("#campaign-list").data('collaboration-id')}/campaigns"
    $.get campaignsUrl
    .success (data) ->
      _.each data, (c) ->
        c.shown = campaignShown(c.id)
      campaigns = data
      campaignListItems = (campaignTemplate campaign for campaign in data)
      $("#campaign-list").html campaignListItems.join('')
      bindToCampaignSelection()

  bindToCampaignSelection = () ->
    $('.campaign-list-item').unbind('click').click (e) ->
      campaignItem = $(this)
      toggleCampaignShown(campaignItem.data('campaign-id'))
      color = if campaignShown(campaignItem.data('campaign-id')) then campaignItem.data('color') else ""
      campaignItem.find('.campaign-selection').css("background-color", color)
      $(".post-list-item").filter (i, e) ->
        $(this).data('campaign-id') == campaignItem.data('campaign-id')
      .toggleClass 'post-hide'
      false

  fetchCampaigns() if $("#campaign-list").length
