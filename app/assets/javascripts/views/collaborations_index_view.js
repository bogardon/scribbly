Scribbly.Views.CollaborationsIndexView = Backbone.View.extend({

  template: JST['collaborations/index'],

  initialize: function () {
    var that = this;
    this.model = new Scribbly.Collections.Collaborations;
    self = this;
    this.model.fetch({
      success: function () {
        self.render()
      }
    });
  },

  render: function () {
    var content = this.template({ collaborations: this.model });
    this.$el.html(content);
    this.delegateEvents();;
    return this;
  },

  events: {

  }
})
