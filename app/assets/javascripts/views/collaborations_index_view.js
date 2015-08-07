Scribbly.Views.CollaborationsIndexView = Backbone.View.extend({

  template: JST['collaborations/index'],

  el: $('#content'),

  initialize: function () {
    var that = this;
    this.collaborations = new Scribbly.Collections.Collaborations
    this.collaborations.fetch({
      success: function () {
        that.render();
      },
    });
  },

  render: function () {
    var content = this.template({ collaborations: this.collection });
    this.$el.html(content);
    return this;
  },

  events: {

  }

})
