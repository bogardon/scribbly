var CollaborationContainer = React.createClass({
  getInitialState() {
    return {

    }
  },

  componentDidMount() {

  },

  componentWillUnmount() {

  },

  render() {
    console.log('collab view', this);
    return (
      <div className='row'>
        <h1 id="collaboration-name">{"name"}</h1>
        <p id="collaboration-description">{"desc"}</p>
        <CalendarContainer />
      </div>
    )
  }
});
