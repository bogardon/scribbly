Scribbly.Views.CalendarMonthlyView = Backbone.View.extend(
  template: JST['calendar/monthly']
  initialize: ->
  render: ->
    content = @template(weekdays: @weekdays)
    @$el.html content
    this
  events: {}
)