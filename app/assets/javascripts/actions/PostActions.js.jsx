(() => {
  class PostActions {
    updatePost(post) {
      return post;
    }

    updatePlatforms(platforms) {
      return platforms;
    }

    fetchPlatforms() {
      var self = this;

      $.ajax({
        url: "/api/platforms",
        method: "GET",
        dataType: 'json',
        success: function(platforms) {
          self.updatePlatforms(platforms);
        }
      });
    }

    selectPlatform(platform) {
      return platform;
    }

    submitPost(post) {
      return post;
    }
  };

  this.PostActions = alt.createActions(PostActions);
})();
