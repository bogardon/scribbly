var Collaborations = React.createClass({
  getInitialState() {
    return CollaborationStore.getState();
  },

  componentWillMount() {
    CollaborationStore.listen(this.handleStoreChange);

    CollaborationActions.fetchCollaborations();
  },

  componentWillUnmount() {
    CollaborationStore.unlisten(this.handleStoreChange);
  },

  handleStoreChange(state) {
    this.setState(state);
  },

  onNewCollaborationClick(e) {
    e.preventDefault();
  },

  render() {
    console.log('collaborations!', this);

    if (this.state.errorMessage) {
      return (
        <div>Something is wrong</div>
      );
    }

    return (
      <div className="row">
        <h1>Your Collaborations</h1>
        <a className="large button" href="#" onClick={ this.onNewCollaborationClick }>New Collaboration</a>

      </div>
    )
  }
})
