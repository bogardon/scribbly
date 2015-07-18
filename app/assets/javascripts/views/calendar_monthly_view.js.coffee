Scribbly.Views.CalendarMonthlyView = Backbone.View.extend(
  template: JST['calendar/monthly']
  initialize: ->
  render: ->
    content = @template(weekdays: @collection.weekdays, days: @collection.days)
    $('#calendar').html content
    this
  events: {}
)