var CollaborationsContainer = React.createClass({
  getInitialState() {
    return CollaborationsStore.getState()
  },

  componentDidMount() {
    CollaborationsStore.listen(this.handleStoreChange);

    CollaborationsActions.fetchCollaborations();
  },

  componentWillUnmount() {
    CollaborationsStore.unlisten(this.handleStoreChange);
  },

  handleStoreChange(state) {
    this.setState(state);
  },

  onNewCollaborationClick(e) {
    if (e) { e.preventDefault(); }
    CollaborationsActions.showNewCollabForm(!this.state.showNewCollabForm);
  },

  renderCollabs() {
    var self = this;

    return this.state.collaborations.map(function(collab, i) {
      return (
        <CollaborationLink collab={collab} key={i} />
      )
    })
  },

  onCollabClick(id) {
    console.log('id!', id);
    this.transitionTo('collaboration', {id: id});
  },

  render() {
    console.log('collaborations view!', this);
    if (this.state.errorMessage) {
      return (
        <div>Something is wrong</div>
      );
    }

    return (
      <div className="row Collaborations">
        <h1>Your Collaborations</h1>
        <a className="large button" href="#" onClick={ this.onNewCollaborationClick }>New Collaboration</a>
        { this.state.showNewCollabForm ? <CollaborationCreateForm closeForm={ this.onNewCollaborationClick } /> : null }
        { this.state.collaborations.length ? this.renderCollabs() : <Loader /> }
      </div>
    )
  }
});