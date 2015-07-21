Scribbly.Collections.Posts = Backbone.Collection.extend(
  model: Scribbly.Models.Post
  initialize: (data) ->
    @collaborationId = data.collaborationId
    @startDate = moment(data.startDate).toString()
    @endDate = moment(data.endDate).toString()
  url: () ->
    '/collaborations/' + @collaborationId + '/posts?start=' + @startDate + '&end=' + @endDate
)