Scribbly.Models.Post = Backbone.Model.extend({
  initialize: function() {
    this.comments().postId = this.get("id");
    this.assets().postId = this.get("id");
  },

  comments: function() {
    if (typeof this._comments == "undefined") {
      this._comments = new Scribbly.Collections.Comments();
    }
    return this._comments;
  },

  assets: function() {
    if (typeof this._assets == "undefined") {
      this._assets = new Scribbly.Collections.Assets();
    }
    return this._assets;
  },

  parse: function(response) {
    if (response.feed_items) {
      this.comments().set(response.feed_items);
      delete response.feed_items;
    }
    if (response.assets) {
      this.assets().set(response.assets);
      delete response.assets;
    }
    return response;
  }
});
