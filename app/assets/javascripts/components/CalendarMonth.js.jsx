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
    return this.props.days.map(function(day, i) {
      var currentMonth = day.currentMonth ? "current-month" : "";
      var today = day.today ? "today" : "";
      var classes = 'month-day-item ' + currentMonth + today;
      var id = 'date-' + day.month + '-' + day.date;

      return (
        <li className={classes} id={id} key={i}>
          <div className='month-day-title'>
            {day.date}
          </div>
          <ul className='post-list'>
          </ul>
        </li>
      )
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
