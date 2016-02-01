var Navigation = ReactRouter.Navigation;

var CollaborationContainer = React.createClass({
  mixins: [Navigation],

  getInitialState() {
    return {
      collaboration: {name: null, description: null}
    }
  },

  componentDidMount() {
    this.getCollaboration();
  },

  getCollaboration() {
    var self = this;

    $.ajax({
      url: "/collaborations/" + this.props.params.id,
      method: "GET",
      success: function(collaboration) {
        self.setState({ collaboration: collaboration });
      }
    });
  },

  componentWillUnmount() {

  },

  onBackButtonClick(e) {
    e.preventDefault();
    // this.context.router.goBack(); // does not work if you land on collab page first
    this.transitionTo('/');
  },

  onCreatePostButtonClick() {
    this.transitionTo('new-post', {collaboration_id: this.props.params.id});
  },

  render() {
    console.log('collab view', this);
    return (
      <div className='row'>
        <a className="button" onClick={this.onBackButtonClick}>Back</a>
        <h1 id="collaboration-name">{this.state.collaboration.name ? this.state.collaboration.name : null}</h1>
        <p id="collaboration-description">{this.state.collaboration.description ? this.state.collaboration.description : null}</p>
        <CalendarContainer collaborationId={this.props.params.id} onCreatePostButtonClick={this.onCreatePostButtonClick} />
      </div>
    )
  }
});
