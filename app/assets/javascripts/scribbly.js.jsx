var Route = ReactRouter.Route;

this.routes = (
  <Route handler={App}>
    <Route name='home' handler={Home} path='/' />
    ...
  </Route>
);
