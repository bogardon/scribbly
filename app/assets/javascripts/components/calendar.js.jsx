var Calendar = React.createClass({
  renderCalendarType() {
    switch (this.props.timeScale) {
      case 'day':
        return <CalendarDay
                  dateRange={this.props.dateRange}
                  posts={this.props.posts}
                  onPostButtonClick={this.props.onPostButtonClick} />
      case 'week':
        return <CalendarWeek
                  dateRange={this.props.dateRange}
                  weekdays={this.props.weekdays}
                  posts={this.props.posts}
                  onPostButtonClick={this.props.onPostButtonClick} />
      case 'month':
        return <CalendarMonth
                  dateRange={this.props.dateRange}
                  days={this.props.days}
                  weekdays={this.props.weekdays}
                  posts={this.props.posts}
                  onPostButtonClick={this.props.onPostButtonClick} />
    }
  },

  render() {
    console.log('calendar', this);
    return (
      <div>
        { this.renderCalendarType() }
      </div>
    )
  }
});
