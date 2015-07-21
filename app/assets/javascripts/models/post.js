Scribbly.Models.Post = Backbone.Model.extend({
	urlRoot: function() {
		var url = '/collaborations/' + this.attributes.collaborationId + '/posts/';
		return url;
	}
});