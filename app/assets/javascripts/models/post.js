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
    if (response.comments) {
      this.comments().set(response.comments);
      delete response.comments;
    }
    if (response.assets) {
      this.assets().set(response.assets);
      delete response.assets;
    }
    return response;
  }
});
