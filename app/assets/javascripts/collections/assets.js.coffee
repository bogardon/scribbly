Scribbly.Collections.Assets = Backbone.Collection.extend({
  model: Scribbly.Models.Asset,
  url: () ->
    "/posts/#{@postId}/assets"
});
