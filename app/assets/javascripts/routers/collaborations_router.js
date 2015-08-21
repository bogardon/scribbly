Scribbly.Routers.CollaborationsRouter = Backbone.Router.extend({
  initialize: function () {
  },

  routes: {
    'collaborations': 'collaborationsIndex',
    'collaborations/:collaborationId' : 'collaborationShow',
    'collaborations/:collaborationId/posts/:postId': 'postShow'
  },

  collaborationsIndex: function() {
    this.currentView && this.currentView.remove();
    this.currentView = new Scribbly.Views.CollaborationsIndexView({
    });

    $("#content").html(this.currentView.render().el)
  },

  collaborationShow: function(collaborationId) {
    this.currentView && this.currentView.remove();
    this.currentView = new Scribbly.Views.CollaborationShowView({
      collaborationId: collaborationId,
    });

    $("#content").html(this.currentView.render().el)
  },

  postShow: function(collaborationId, postId) {
    this.currentView && this.currentView.remove();
    this.currentView = new Scribbly.Views.PostShowView({
      collaborationId: collaborationId,
      postId: postId
    });

    $("#content").html(this.currentView.render().el)
  },
});
