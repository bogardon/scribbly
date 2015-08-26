Scribbly.Models.Post = Backbone.Model.extend({
  initialize: function() {
    this.comments = new Scribbly.Collections.Comments({}, {
      postId: this.get("id"),
      collaborationId: this.get("collaboration_id")
    })
  },

  urlRoot: function() {
    var url = '/collaborations/' + this.get("collaboration_id") + '/posts'
    return url;
  },

  parse: function(response) {
    this.comments.set(response.comments);
    delete response.comments;
    return response;
  }
});
