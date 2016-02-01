var CalendarMonth = React.createClass({
  renderWeekdays() {
    return this.props.weekdays.map(function(weekday, i) {
      return (
        <li className='day-list-item' key={i}>
          <div className='day-title'>
            {weekday}
          </div>
        </li>
      )
    })
  },

  renderDays() {
    var self = this;

    return this.props.days.map(function(day, i) {
      var currentMonth = day.currentMonth ? "current-month" : "";
      var today = day.today ? " today" : "";
      var classes = 'month-day-item ' + currentMonth + today;
      var id = 'date-' + day.month + '-' + day.date;

      return (
        <li className={classes} id={id} key={i}>
          <div className='month-day-title'>
            {day.date}
          </div>
          <ul className='post-list'>
            { self.renderPosts(day) }
          </ul>
        </li>
      )
    })
  },

  renderPosts(day) {
    var self = this;

    return this.props.posts.map(function(post, i) {
      var scheduledAt = moment(post.scheduled_at).format('MMMM do YYYY');
      var currentDay = moment(day.description).format('MMMM Do YYYY');

      if (currentDay === scheduledAt) {
        return (
          <li className='post-list-item' key={i}>
            <div className='post-title'>
              <a key={i}>
                { post.title }
              </a>
            </div>
          </li>
        )
      }
    })
  },

  render() {
    return (
      <ul className='small-block-grid-7'>
        { this.renderWeekdays() }
        { this.renderDays() }
      </ul>
    )
  }
});
