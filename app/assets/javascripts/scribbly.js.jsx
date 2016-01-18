var Route = ReactRouter.Route;

this.routes = (
  <Route handler={App}>
    <Route path='/' name='collaborations' handler={Collaborations} />
  </Route>
);

// ReactRouter.run(routes, ReactRouter.HistoryLocation, function (Handler) {
//   ReactDOM.render(<Handler/>, document.getElementById('content'));
// });
