Scribbly.Routers.CollaborationsRouter = Backbone.Router.extend({
  initialize: function ($rootEl, collaborations) {
    this.$rootEl = $rootEl;
    this.collaborations = collaborations;
  },

  routes: {
    '': 'index',
    ":id" : "show"
  },

  index: function() {
    var that = this;
    var formView = new Scribbly.Views.CollaborationsIndexView({
      collection: that.collaborations
    });

    that._swapView(formView);
  },

  show: function (id) {
    var that = this;

    var collaboration = _(that.collaborations.models).findWhere({id: parseInt(id) });
    var formView = new Scribbly.Views.CollaborationsShowView({
      model: collaboration
    })

    that._swapView(formView);
  },

  _swapView: function (view) {
    this._currentView && this._currentView.remove();
    this._currenView = view;
    this.$rootEl.html(view.render().$el);
  }
});