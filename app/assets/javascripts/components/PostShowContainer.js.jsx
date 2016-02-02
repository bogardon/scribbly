var Navigation = ReactRouter.Navigation;

var PostShowContainer = React.createClass({
  mixins: [Navigation],

  onBackButtonClick(e) {
    e.preventDefault();
    this.transitionTo('collaboration', {id: this.props.params.collaboration_id});
  },

  render() {
    console.log('post show!', this);
    return (
      <div>
        <button className="waves-effect waves-light btn" onClick={this.onBackButtonClick}>Back</button>
        <h1>Post show!</h1>
      </div>
    )
  }
});
