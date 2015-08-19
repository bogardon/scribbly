Scribbly.Models.Post = Backbone.Model.extend({
	urlRoot: function() {
		var url = '/collaborations/' + this.get("collaboration_id") + '/posts/';
		return url;
	}
});
