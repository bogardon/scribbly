var Route = ReactRouter.Route;
var DefaultRoute = ReactRouter.DefaultRoute;

this.routes = (
  <Route handler={App} path='/'>
    <DefaultRoute handler={Collaborations}/>
    <Route path='collaborations/:id' name='collaboration' handler={Collaboration}/>
  </Route>
);

// ReactRouter.run(routes, ReactRouter.HistoryLocation, function (Handler) {
//   ReactDOM.render(<Handler/>, document.getElementById('content'));
// });

// ReactDOM.render((
//   <Router>
//     <Route path="/" component={App}>
//       <Route path="about" component={About}/>
//       <Route path="users" component={Users}>
//         <Route path="/user/:userId" component={User}/>
//       </Route>
//       <Route path="*" component={NoMatch}/>
//     </Route>
//   </Router>
// ), document.getElementById('content'))
