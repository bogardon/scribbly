Scribbly.Views.CollaborationsIndexView = Backbone.View.extend({

  initialize: function () {

  },

  template: JST['collaborations/index'],

  render: function () {
    var content = this.template({ collaborations: this.collection });
    this.$el.html(content);
    return this; // this is the instance of the view.
  },

  events: {

  }

})