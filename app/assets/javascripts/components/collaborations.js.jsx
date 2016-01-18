var Collaborations = React.createClass({
  getInitialState() {
    return {
      collabStore: CollaborationStore.getState(),
      showNewCollabForm: false
    };
  },

  componentWillMount() {
    CollaborationStore.listen(this.handleStoreChange);

    CollaborationActions.fetchCollaborations();
  },

  componentWillUnmount() {
    CollaborationStore.unlisten(this.handleStoreChange);
  },

  handleStoreChange(state) {
    this.setState({ collabStore: state });
  },

  onNewCollaborationClick(e) {
    if (e) { e.preventDefault(); }
    this.setState({ showNewCollabForm: !this.state.showNewCollabForm });
  },

  renderCollabs() {
    return this.state.collabStore.collaborations.map(function(collab, i) {
      return (
        <div className="Collaboration" key={i}>
          <div className="Collaboration-name">name: {collab.name}</div>
          <div className="Collaboration-description">description: {collab.description}</div>
        </div>
      )
    })
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
        { this.state.showNewCollabForm ? <NewCollaborationForm closeForm={ this.onNewCollaborationClick } /> : null }
        { this.state.collabStore.collaborations.length ? this.renderCollabs() : null }
      </div>
    )
  }
});

var NewCollaborationForm = React.createClass({
  getInitialState() {
    return {
      name: '',
      description: ''
    }
  },

  onNameInputChange(e) {
    this.setState({ name: e.target.value })
  },

  onDescriptionInputChange(e) {
    this.setState({ description: e.target.value })
  },

  onSaveButtonClick(e) {
    this.props.closeForm();
    CollaborationActions.newCollaboration(this.state);
  },

  onBackButtonClick(e) {
    this.props.closeForm();
  },

  render() {
    return (
      <div>
        <h3>Name</h3>
        <input type="text" value={this.state.name} onChange={ this.onNameInputChange }></input>
        <h3>Description</h3>
        <textarea value={this.state.description} onChange={ this.onDescriptionInputChange }></textarea>
        <button type="button" className="success button" onClick={ this.onSaveButtonClick }>Save</button>
        <button type="button" className="alert button" onClick={ this.onBackButtonClick }>Back</button>
      </div>
    )
  }
});
