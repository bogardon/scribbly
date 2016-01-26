var CollaborationContainer = React.createClass({
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

  render() {
    console.log('collab view', this);
    return (
      <div className='row'>
        <h1 id="collaboration-name">{this.state.collaboration.name ? this.state.collaboration.name : null}</h1>
        <p id="collaboration-description">{this.state.collaboration.description ? this.state.collaboration.description : null}</p>
        <CalendarContainer />
      </div>
    )
  }
});
