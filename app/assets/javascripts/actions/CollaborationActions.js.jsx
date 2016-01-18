(() => {
  class CollaborationActions {
    updateCollaborations(collaborations) {
      return collaborations;
    }

    fetchCollaborations() {
      fetch('/collaborations')
        .then((collaborations) => {
          console.log('fetchCollaborations complete: ', collaborations);
          // we can access other actions within our action through `this.actions`
          this.updateCollaborations(collaborations);
        })
        .catch((errorMessage) => {
          this.collaborationsFailed(errorMessage);
        });
    }

    collaborationsFailed(errorMessage) {
      return errorMessage;
    }
  };

  this.CollaborationActions = alt.createActions(CollaborationActions);
})();
