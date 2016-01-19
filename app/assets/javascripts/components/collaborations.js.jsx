var Navigation = ReactRouter.Navigation;

var Collaborations = React.createClass({
  mixins: [Navigation],

  getInitialState() {
    return CollaborationsStore.getState()
  },

  componentWillMount() {
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
        <div className="Collaboration" onClick={ self.onCollabClick.bind(self, collab.id) } key={i}>
          <div className="Collaboration-name">name: {collab.name}</div>
          <div className="Collaboration-description">description: {collab.description}</div>
        </div>
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
        { this.state.showNewCollabForm ? <NewCollaborationForm closeForm={ this.onNewCollaborationClick } /> : null }
        { this.state.collaborations.length ? this.renderCollabs() : null }
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
    CollaborationsActions.createCollaboration(this.state);
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
