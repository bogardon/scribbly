// CalendarContainer
var CalendarContainer = React.createClass({
  getInitialState() {
    return {
      calendarStore: CalendarStore.getState(),
      postStore: null
    }
  },

  componentDidMount() {
    CalendarStore.listen(this.handleCalendarStoreChange);
  },

  componentWillUnmount() {
    CalendarStore.unlisten(this.handleCalendarStoreChange);
  },

  handleCalendarStoreChange(state) {
    this.setState({ calendarStore: state });
  },

  onTodayButtonClick(e) {
    e.preventDefault();
    var newDate;
    newDate = moment();
    $.cookie('saved_date', newDate);
    // this.setState({ savedDate: newDate })
  },

  onTimeScaleSelectClick(timeScale, e) {
    e.preventDefault();
    CalendarActions.updateTimeScale(timeScale);
    // this.setState({ timeScale: timeScale })
  },

  onCreatePostButtonClick(e) {
    e.preventDefault();
    // go to create post route
  },

  onTimeScaleArrowClick(e) {
    e.preventDefault();
    var $btn, newDate;
    $btn = $(e.currentTarget);
    newDate = this.state.savedDate().add($btn.data('scale-amount'), this.timeScale());
    $.cookie('saved_date', newDate);
    // this.setState({ savedDate: newDate })
  },

  renderCalendarControls() {
    var classes = 'tiny button';
    var dailyClasses = this.state.calendarStore.timeScale === 'day' ? classes : (classes + ' secondary');
    var weeklyClasses = this.state.calendarStore.timeScale === 'week' ? classes : (classes + ' secondary');
    var monthlyClasses = this.state.calendarStore.timeScale === 'month' ? classes : (classes + ' secondary');

    return (
      <div className='row'>
        <div className='small-2 columns'>
          <a className='tiny button success' id='today-button' onClick={this.onTodayButtonClick}>Today</a>
        </div>
        <div className='small-4 small-offset-2 columns'>
          <ul className="button-group even-3 text-center">
            <li><a href="#" className={dailyClasses} onClick={this.onTimeScaleSelectClick.bind(this, 'day')}>Daily</a></li>
            <li><a href="#" className={weeklyClasses} onClick={this.onTimeScaleSelectClick.bind(this, 'week')}>Weekly</a></li>
            <li><a href="#" className={monthlyClasses} onClick={this.onTimeScaleSelectClick.bind(this, 'month')}>Monthly</a></li>
          </ul>
        </div>
        <div className='small-2 columns text-right'>
          <a className='tiny button success' id='create-post-button' onClick={this.onCreatePostButtonClick}>Create Post</a>
        </div>
      </div>
    )
  },

  render() {
    console.log('calendarcontainer', this);
    return (
      <div>
        <h1>Calendar!</h1>
        <h3>{this.state.calendarStore.timeScaleTitle}</h3>
        { this.renderCalendarControls() }
        { this.state.calendarStore.dateRange ?
          <Calendar
            timeScale={this.state.calendarStore.timeScale}
            dateRange={this.state.calendarStore.dateRange}
            savedDate={this.state.calendarStore.savedDate}
            days={this.state.calendarStore.days}
            weekdays={this.state.calendarStore.weekdays} /> : null }
      </div>
    )
  }
});

// Calendar
var Calendar = React.createClass({
  getInitialState() {
    return {

    }
  },

  componentDidMount() {

  },

  renderCalendarType() {
    switch (this.props.timeScale) {
      case 'day':
        return <CalendarDaily
                  dateRange={this.props.dateRange} />
      case 'week':
        return <CalendarWeekly
                  dateRange={this.props.dateRange}
                  weekdays={this.props.weekdays} />
      case 'month':
        return <CalendarMonthly
                  dateRange={this.props.dateRange}
                  days={this.props.days}
                  weekdays={this.props.weekdays} />
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

// CalendarMonthly
var CalendarMonthly = React.createClass({
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

// CalendarWeekly
var CalendarWeekly = React.createClass({
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

// CalendarDaily
var CalendarDaily = React.createClass({
  render() {
    return (
      <ul className='post-list'>
      </ul>
    )
  }
});
