Scribbly.Routers.CollaborationsRouter = Backbone.Router.extend({
  initialize: function () {
  },

  routes: {
    'collaborations': 'index',
    'collaborations/:id' : 'show',
    'collaborations/:id/posts/:postId': 'showPost'
  },

  index: function() {
    this.currentView && this.currentView.remove();
    this.currentView = new Scribbly.Views.CollaborationsIndexView({
    });

    $("#content").html(this.currentView.render().el)
  },

  show: function(id) {
    this.currentView && this.currentView.remove();
    this.currentView = new Scribbly.Views.CollaborationShowView({
      collaborationId: id,
    });

    $("#content").html(this.currentView.render().el)
  },

  showPost: function(id, postId) {
    // Implement.
  },
});
