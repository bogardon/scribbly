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

  },

  onTimeScaleSelectClick(timeScale, e) {
    e.preventDefault();
    CalendarActions.updateTimeScale(timeScale);
  },

  onCreatePostButtonClick(e) {
    e.preventDefault();
    // go to create post route
  },

  onTimeScaleArrowClick(scaleAmount, e) {
    e.preventDefault();
    CalendarActions.onTimeScaleArrowClick(scaleAmount);
  },

  renderCalendarControls() {
    var classes = 'tiny button';
    var dailyClasses = this.state.calendarStore.timeScale === 'day' ? classes : (classes + ' secondary');
    var weeklyClasses = this.state.calendarStore.timeScale === 'week' ? classes : (classes + ' secondary');
    var monthlyClasses = this.state.calendarStore.timeScale === 'month' ? classes : (classes + ' secondary');

    return (
      <div>
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
        <div>
          <a className='time-scale-arrow' onClick={this.onTimeScaleArrowClick.bind(this, -1)}><i className='fi-arrow-left'></i></a>
          <a className='time-scale-arrow float-right' onClick={this.onTimeScaleArrowClick.bind(this, 1)}><i className='fi-arrow-right'></i></a>
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
            weekdays={this.state.calendarStore.weekdays} /> : <Loader /> }
      </div>
    )
  }
});
