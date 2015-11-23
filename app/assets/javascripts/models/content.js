Scribbly.Models.Content = Backbone.Model.extend({
  urlRoot: '/contents',

  initialize: function() {
    this.selected = false
  },

  assets: function() {
    if (typeof this._assets == "undefined") {
      this._assets = new Scribbly.Collections.Assets();
    }
    return this._assets;
  },

  parse: function(response) {
    if (response.assets) {
      this.assets().set(response.assets, {parse: true});
      delete response.assets;
    }
    return response
  },
});
