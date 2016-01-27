(() => {
  class PostActions {
    updatePost(post) {
      return post;
    }
  };

  this.PostActions = alt.createActions(PostActions);
})();
