var Navigation = ReactRouter.Navigation;

var PostCreateContainer = React.createClass({
  mixins: [Navigation],

  getInitialState() {
    return PostStore.getState();
  },

  componentDidMount() {
    PostStore.listen(this.handleStoreChange);
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

  renderPostCreateForm() {
    switch (this.state.platform.name) {
      case "Facebook":
        return <PostCreateForm
                platform={this.state.platform}
                collaborationId={this.props.params.collaboration_id} />
      case "Twitter":
        return <PostCreateForm
                platform={this.state.platform}
                collaborationId={this.props.params.collaboration_id} />
      case "Instagram":
        return <PostCreateForm
                platform={this.state.platform}
                collaborationId={this.props.params.collaboration_id} />
    }
  },

  render() {
    console.log('new-post', this);
    return (
      <div>
        <button className="waves-effect waves-light btn" onClick={this.onBackButtonClick}>Back</button>
        <h1>Create Post</h1>
        <PostPlatforms platform={this.state.platform} platforms={this.state.platforms}/>
        {this.state.platform ? this.renderPostCreateForm() : null}
      </div>
    )
  }
});

var PostPlatforms = React.createClass({
  onPlatformClick(platform, e) {
    e.preventDefault();
    PostActions.selectPlatform(platform);
  },

  renderPlatforms() {
    var self = this;

    return this.props.platforms.map(function(platform, i) {
      var platformClasses = self.props.platform === platform ? 'Platform selected' : 'Platform';

      return (
        <div className={platformClasses} key={i} onClick={self.onPlatformClick.bind(self, platform)}>
          {platform.name}
        </div>
      )
    });
  },

  render() {
    return (
      <div className="Platforms-Container">
        {this.renderPlatforms()}
      </div>
    );
  }
});

var PostCreateForm = React.createClass({
  getInitialState() {
    return {
      title: '',
      copy: '',
      scheduled_at: null,
      assets: [],
      platform_id: this.props.platform.id,
      collaboration_id: this.props.collaborationId
    }
  },

  onTitleChange(e) {
    this.setState({ title: e.target.value });
  },

  onDateTimeChange(e) {
    this.setState({ scheduled_at: e.target.value });
  },

  onCopyChange(e) {
    this.setState({ copy: e.target.value });
  },

  onFileInputChange(e) {
    console.log('onFileInputChange: ', e);
    this.setState({ assets: e.target.files });
  },

  onSubmitPostClick(e) {
    e.preventDefault();
    PostActions.submitPost(this.state);
  },

  render() {
    console.log('postcreate', this);
    return (
      <div className="row">
        <h4>Selected Platform: {this.props.platform.name}</h4>
        <input id='post-title' className="validate" type='text' placeholder="Title" value={this.state.title} onChange={this.onTitleChange} />
        <input id='post-scheduled-at' className="validate" type="datetime-local" value={this.state.dateTime} onChange={this.onDateTimeChange}/>
        <textarea id='post-title' className="materialize-textarea" placeholder="Copy" value={this.state.copy} onChange={this.onCopyChange}/>
        <form action="#">
          <div className="file-field input-field">
            <div className="btn">
              <span>File</span>
              <input type="file" onChange={this.onFileInputChange}/>
            </div>
            <div className="file-path-wrapper">
              <input className="file-path validate" type="text"/>
            </div>
          </div>
        </form>
        <button id='submit-post-button' className='waves-effect waves-light btn-large' onClick={this.onSubmitPostClick}>Submit</button>
      </div>
    );
  }
});
