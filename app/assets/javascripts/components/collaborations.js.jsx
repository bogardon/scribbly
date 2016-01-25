var Navigation = ReactRouter.Navigation;

// CollaborationsContainer
var CollaborationsContainer = React.createClass({
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
        <CollaborationBadge collab={collab} key={i} />
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

// CollaborationBadge
var CollaborationBadge = React.createClass({
  mixins: [Navigation],

  onCollabClick(id) {
    console.log('id!', id);
    this.transitionTo('collaboration', {id: id});
  },

  render() {
    return (
      <div className="Collaboration" onClick={ this.onCollabClick.bind(this, this.props.collab.id) }>
        <div className="Collaboration-name">name: {this.props.collab.name}</div>
        <div className="Collaboration-description">description: {this.props.collab.description}</div>
      </div>
    )
  }
});

// NewCollaborationForm
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
    if (!this.state.name.length || $.trim(this.state.name) === "") { return }
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
