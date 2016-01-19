(() => {
  class CollaborationsActions {
    updateCollaborations(collaborations) {
      return collaborations;
    }

    fetchCollaborations() {
      // fetch('/collaborations')
      //   .then((collaborations) => {
      //     console.log('fetchCollaborations complete: ', collaborations);
      //     // we can access other actions within our action through `this.actions`
      //     this.updateCollaborations(collaborations);
      //   })
      //   .catch((errorMessage) => {
      //     this.collaborationsFailed(errorMessage);
      //   });
      var self = this;

      $.ajax({
        url: "/collaborations",
        method: "GET",
        success: function(collaborations) {
          self.updateCollaborations(collaborations);
        },
        error: function(xhr, status, err) {
          self.collaborationsFailed(err.toString());
        }
      });
    }

    showNewCollabForm(state) {
      return state;
    }

    createCollaboration(collab) {
      console.log('newCollaboration', collab);
      var self = this;

      $.ajax({
        url: "/collaborations",
        method: "POST",
        data: collab,
        dataType: "json",
        success: function(collaborations) {
          self.updateCollaborations(collaborations);
          self.showNewCollabForm(false);
        },
        error: function(xhr, status, err) {
					console.log('newcollab error!', err.toString());
          self.collaborationsFailed(err.toString());
				}
      })
    }

    collaborationsFailed(errorMessage) {
      return errorMessage;
    }
  };

  this.CollaborationsActions = alt.createActions(CollaborationsActions);
})();
