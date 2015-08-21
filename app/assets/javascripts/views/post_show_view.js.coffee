Scribbly.Views.PostShowView = Backbone.View.extend(
  template: JST['posts/show']
  initialize: (options)->

  render: ->
    content = @template()
    @$el.html content
    this

  events: {}

)
