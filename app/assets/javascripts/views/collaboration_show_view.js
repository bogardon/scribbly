Scribbly.Views.CollaborationShowView = Backbone.View.extend({

  template: JST['collaborations/show'],

  render: function () {
    var content = this.template({ collaboration: this.model });
    this.$el.html(content);
    return this;
  }

});