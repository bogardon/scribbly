(() => {
  class CollaborationsStore {
    constructor() {
      this.collaborations = [];
      this.errorMessage = null;
      this.showNewCollabForm = false;
      this.bindListeners({
        handleUpdateCollaborations: CollaborationsActions.UPDATE_COLLABORATIONS,
        handleFetchCollaborations: CollaborationsActions.FETCH_COLLABORATIONS,
        handleCollaborationsFailed: CollaborationsActions.COLLABORATIONS_FAILED,
        handleShowNewCollabForm: CollaborationsActions.SHOW_NEW_COLLAB_FORM
      });
    }

    handleUpdateCollaborations(collaborations) {
      this.collaborations = collaborations;
      this.errorMessage = null;
    }

    handleFetchCollaborations() {
      // reset the array while we're fetching new collaborations so React can
      // be smart and render a spinner for us since the data is empty.
      this.collaborations = [];
    }

    handleCollaborationsFailed(errorMessage) {
      this.errorMessage = errorMessage;
    }

    handleShowNewCollabForm(state) {
      this.showNewCollabForm = state;
    }
  };

  this.CollaborationsStore = alt.createStore(CollaborationsStore, 'CollaborationsStore');
})();
