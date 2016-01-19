var RouteHandler = ReactRouter.RouteHandler;

var App = React.createClass({
  getInitialState() {
    return {}
  },

  componentDidMount() {
  },

  render() {
    return (
      <div className="app">
        <RouteHandler {...this.props}/>
      </div>
    );
  }
});
