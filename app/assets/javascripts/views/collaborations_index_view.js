Scribbly.Views.CollaborationsIndexView = Backbone.View.extend({

  template: JST['collaborations/index'],

  initialize: function () {

  },

  render: function () {
    var content = this.template({ collaborations: this.collection });
    this.$el.html(content);
    return this;
  },

  events: {

  }

})