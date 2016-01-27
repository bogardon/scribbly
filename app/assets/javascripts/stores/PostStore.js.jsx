(() => {
  class PostStore {
    constructor() {
      this.post = {};
      this.bindListeners({
        handleUpdatePost: PostActions.UPDATE_POST
      });
    }

    handleUpdatePost(post) {

    }
  };

  this.PostStore = alt.createStore(PostStore, 'PostStore');
})();
