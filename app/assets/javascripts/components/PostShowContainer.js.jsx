var Navigation = ReactRouter.Navigation;

var PostShowContainer = React.createClass({
  mixins: [Navigation],

  getInitialState() {
    return PostStore.getState()
  },

  componentDidMount() {
    PostStore.listen(this.handleStoreChange);

    PostActions.fetchPost(this.props.params.post_id);
  },

  componentWillUnmount() {
    PostStore.unlisten(this.handleStoreChange);
  },

  handleStoreChange(state) {
    this.setState(state);
  },

  onBackButtonClick(e) {
    e.preventDefault();
    this.transitionTo('collaboration', {id: this.props.params.collaboration_id});
  },

  render() {
    console.log('post show!', this);
    return (
      <div className="row">
        <button className="waves-effect waves-light btn" onClick={this.onBackButtonClick}>Back</button>
        <h1>Post show!</h1>
        <div className="col s12">
          <ChatContainer
            messages={this.state.feedItems} />
          <PostDetailContainer
            post={this.state.post} />
        </div>
      </div>
    )
  }
});

var ChatContainer = React.createClass({
  render() {
    return (
      <div className="col s12 m4">
        <h3>chat</h3>
      </div>
    )
  }
});

var PostDetailContainer = React.createClass({
  render() {
    console.log('post detail', this);
    return (
      <div className="col s12 m8">
        <h3>post detail</h3>
      </div>
    )
  }
});
