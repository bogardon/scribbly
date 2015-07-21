Scribbly.Routers.CollaborationsRouter = Backbone.Router.extend({
  initialize: function ($rootEl, collaborations) {
    this.$rootEl = $rootEl;
    this.collaborations = collaborations;
  },

  routes: {
    '': 'index',
    ':id' : 'show',
    ':id/posts/:postId': 'showPost'
  },

  index: function() {
    var that = this;
    var formView = new Scribbly.Views.CollaborationsIndexView({
      collection: that.collaborations
    });

    that._swapView(formView);
  },

  show: function(id) {
    var that = this;

    var collaboration = _(that.collaborations.models).findWhere({id: parseInt(id) });
    var formView = new Scribbly.Views.CollaborationsShowView({
      model: collaboration
    });

    that._swapView(formView);
  },

  showPost: function(id, postId) {
    var that = this;
    var post = new Scribbly.Models.Post({
      id: postId,
      collaborationId: id
    });
    post.fetch({
      success: function() {
        var postView = new Scribbly.Views.PostShowView({ model: post });
        // postView.render();
        that._swapView(postView);
      }
    });
  },

  _swapView: function (view) {
    this._currentView && this._currentView.remove();
    this._currenView = view;
    this.$rootEl.html(view.render().$el);
  }
});