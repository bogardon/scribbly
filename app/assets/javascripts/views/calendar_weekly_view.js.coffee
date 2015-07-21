Scribbly.Views.CalendarWeeklyView = Backbone.View.extend(
  template: JST['calendar/weekly']
  initialize: ->
  render: ->
    content = @template(days: @collection, collab: @model.attributes)
    $('#calendar').html content
    this
  events: {}
)