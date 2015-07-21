Scribbly.Views.PostShowView = Backbone.View.extend(
  template: JST['posts/show']
  initialize: ->

  render: ->
    content = @template(post: @model)
    @$el.html content
    this

  events: {}

)