var Navigation = ReactRouter.Navigation;

var PostCreateContainer = React.createClass({
  mixins: [Navigation],

  onBackButtonClick(e) {
    e.preventDefault();
    this.transitionTo('collaboration', {id: this.props.params.collaboration_id});
  },

  render() {
    console.log('new-post', this);
    return (
      <div>
        <a className="button" onClick={this.onBackButtonClick}>Back</a>
        <h1>PostCreate!</h1>
      </div>
    )
  }
});
