var CollaborationCreateForm = React.createClass({
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
