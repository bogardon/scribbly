var Navigation = ReactRouter.Navigation;

var CollaborationLink = React.createClass({
  mixins: [Navigation],

  onCollabClick(id) {
    console.log('onCollabClick id!', id);
    this.transitionTo('collaboration', {id: id});
  },

  render() {
    return (
      <div className="Collaboration" onClick={ this.onCollabClick.bind(this, this.props.collab.id) }>
        <div className="Collaboration-name">name: {this.props.collab.name}</div>
        <div className="Collaboration-description">description: {this.props.collab.description}</div>
      </div>
    )
  }
});
