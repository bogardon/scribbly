(() => {
  class CollaborationStore {
    constructor() {
      this.collaborations = [];
      this.errorMessage = null;
      this.bindListeners({
        handleUpdateCollaborations: CollaborationActions.UPDATE_COLLABORATIONS,
        handleFetchCollaborations: CollaborationActions.FETCH_COLLABORATIONS,
        handleCollaborationsFailed: CollaborationActions.COLLABORATIONS_FAILED
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
  };

  this.CollaborationStore = alt.createStore(CollaborationStore, 'CollaborationStore');
})();
