(() => {
  class PostStore {
    constructor() {
      this.post = {};
      this.feedItems = [];

      this.platforms = [];
      this.platform = null;
      this.collaboration_id = null;
      this.timezone_offset = moment().zone() * 60;

      this.bindListeners({
        handleUpdatePost: PostActions.UPDATE_POST,
        handleUpdatePlatforms: PostActions.UPDATE_PLATFORMS,
        handleSelectPlatform: PostActions.SELECT_PLATFORM,
        handleSubmitPost: PostActions.SUBMIT_POST,
        handleFetchPost: PostActions.FETCH_POST
      });

      this.on('init', () => {
        // init is called when the store is initialized as well as whenever a store is recycled.
        this.getInitialData();
      });
    }

    handleUpdatePost(post) {
      this.post = post;
    }

    handleFetchPost(post) {
      this.post = {};
    }

    handleUpdatePlatforms(platforms) {
      this.platforms = platforms;
    }

    handleSelectPlatform(platform) {
      this.platform = platform;
    }

    handleSubmitPost(post, timezone_offset) {
      this.post = {};
    }

    getInitialData() {
      PostActions.fetchPlatforms();
    }
  };

  this.PostStore = alt.createStore(PostStore, 'PostStore');
})();
