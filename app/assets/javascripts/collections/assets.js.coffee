Scribbly.Collections.Assets = Backbone.Collection.extend({
  model: Scribbly.Models.Asset,
  url: () ->
    "/assets"
});
