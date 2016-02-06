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

  onPostButtonClick(post) {
    this.transitionTo('post', {collaboration_id: this.props.params.id, post_id: post.id});
  },

  render() {
    console.log('collab view', this);
    return (
      <div className='row'>
        <button className="waves-effect waves-light btn" onClick={this.onBackButtonClick}>Back</button>
        <h1 id="collaboration-name">{this.state.collaboration.name ? this.state.collaboration.name : null}</h1>
        <p id="collaboration-description">{this.state.collaboration.description ? this.state.collaboration.description : null}</p>
        <CalendarContainer
          collaborationId={this.props.params.id}
          onCreatePostButtonClick={this.onCreatePostButtonClick}
          onPostButtonClick={this.onPostButtonClick} />
      </div>
    )
  }
});
