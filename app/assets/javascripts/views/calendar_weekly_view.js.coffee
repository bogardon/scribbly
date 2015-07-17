Scribbly.Views.CalendarWeeklyView = Backbone.View.extend(
  template: JST['calendar/weekly']
  initialize: ->
  render: ->
    content = @template(days: @collection)
    $('#calendar').html content
    this
  events: {}
)