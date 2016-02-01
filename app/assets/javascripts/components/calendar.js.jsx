var Calendar = React.createClass({
  renderCalendarType() {
    switch (this.props.timeScale) {
      case 'day':
        return <CalendarDay
                  dateRange={this.props.dateRange}
                  posts={this.props.posts} />
      case 'week':
        return <CalendarWeek
                  dateRange={this.props.dateRange}
                  weekdays={this.props.weekdays}
                  posts={this.props.posts} />
      case 'month':
        return <CalendarMonth
                  dateRange={this.props.dateRange}
                  days={this.props.days}
                  weekdays={this.props.weekdays}
                  posts={this.props.posts} />
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
