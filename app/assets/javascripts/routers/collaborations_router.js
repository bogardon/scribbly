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
      el: $('#content')
    });
  },

  show: function(id) {
    this.currentView && this.currentView.remove();
    this.currentView = new Scribbly.Views.CollaborationsShowView({
      id: id,
      el: $('#content')
    });
  },

  showPost: function(id, postId) {
    // Implement.
  },
});
