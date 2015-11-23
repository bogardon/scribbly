Scribbly.Models.Post = Backbone.Model.extend({
  initialize: function() {
    this.comments().postId = this.get("id");
    this.contents().postId = this.get("id");
  },

  urlRoot: '/posts',

  comments: function() {
    if (typeof this._comments == "undefined") {
      this._comments = new Scribbly.Collections.Comments();
    }
    return this._comments;
  },

  contents: function() {
    if (typeof this._contents == "undefined") {
      this._contents = new Scribbly.Collections.Contents();
    }
    return this._contents;
  },

  parse: function(response) {
    if (response.feed_items) {
      this.comments().set(response.feed_items, {parse: true});
      delete response.feed_items;
    }
    if (response.contents) {
      this.contents().set(response.contents, {parse: true});
      delete response.contents;
    }
    return response;
  }
});
