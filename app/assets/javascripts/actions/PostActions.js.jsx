(() => {
  class PostActions {
    updatePost(post) {
      return post;
    }

    fetchPost(id) {
      var self = this;

      return (dispatch) => {
        dispatch();
        $.ajax({
          url: `/posts/${id}`,
          method: 'GET',
          dataType: 'json',
          success: function(post) {
            self.updatePost(post);
          }
        });
      };
    }

    updatePlatforms(platforms) {
      return platforms;
    }

    fetchPlatforms() {
      var self = this;

      return (dispatch) => {
        dispatch();
        $.ajax({
          url: "/api/platforms",
          method: "GET",
          dataType: 'json',
          success: function(platforms) {
            self.updatePlatforms(platforms);
          }
        });
      };
    }

    selectPlatform(platform) {
      return platform;
    }

    submitPost(post, timezone_offset) {
      console.log('handleSubmitPost', post);
      return (dispatch) => {
        dispatch();
        var data = {
          post: post,
          scheduled_at: post.scheduled_at,
          timezone_offset: timezone_offset
        };

        $.ajax({
          url: '/posts',
          type: 'POST',
          data: data,
          dataType: 'json',
          success: function(data) {
            console.log('yay!', data);
          }
        });
      };
    }
  };

  this.PostActions = alt.createActions(PostActions);
})();
