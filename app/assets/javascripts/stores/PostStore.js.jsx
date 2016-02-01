(() => {
  class PostStore {
    constructor() {
      this.post = null;
      this.platforms = [];
      this.platform = null;
      this.collaboration_id = null;
      this.timezone_offset = moment().zone() * 60;

      this.bindListeners({
        handleUpdatePost: PostActions.UPDATE_POST,
        handleUpdatePlatforms: PostActions.UPDATE_PLATFORMS,
        handleSelectPlatform: PostActions.SELECT_PLATFORM,
        handleSubmitPost: PostActions.SUBMIT_POST
      });

      this.on('init', () => {
        // init is called when the store is initialized as well as whenever a store is recycled.
        this.getInitialData();
      });
    }

    handleUpdatePost(post) {
      $.extend(this.post, post);
    }

    handleUpdatePlatforms(platforms) {
      this.platforms = platforms;
    }

    handleSelectPlatform(platform) {
      this.platform = platform;
    }

    handleSubmitPost(post) {
      console.log('handleSubmitPost', post);
      this.post = post;
      var data = {
        post: post,
        scheduled_at: post.scheduled_at,
        timezone_offset: this.timezone_offset
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
    }

    getInitialData() {
      PostActions.fetchPlatforms();
    }
  };

  this.PostStore = alt.createStore(PostStore, 'PostStore');
})();
