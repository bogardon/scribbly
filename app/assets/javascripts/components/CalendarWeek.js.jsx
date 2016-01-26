var CalendarWeek = React.createClass({
  renderWeekdays() {
    return this.props.weekdays.map(function(weekday, i) {
      return (
        <li className='day-list-item' id='weekday-<%= weekday.day %>' key={i}>
          <div className='day-title'>
            {weekday.day} {weekday.month} / {weekday.date}
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
      </ul>
    )
  }
});
