(() => {
  class CalendarStore {
    constructor() {
      this.timeScale = null;
      this.savedDate = null;
      this.dateRange = null;
      this.timeScaleTitle = null;
      this.days = [];
      this.weekdays = [];
      this.start = null;
      this.end = null;

      this.bindListeners({
        handleUpdateTimeScale: CalendarActions.UPDATE_TIME_SCALE
      });

      this.on('init', () => {
        // init is called when the store is initialized as well as whenever a store is recycled.
        this.setInitialData();
      });
    }

    handleUpdateTimeScale(timeScale) {
      this.timeScale = timeScale;
    }

    getTimeScale() {
      var scale;
      scale = $.cookie("time_scale");
      if (scale != null) {
        this.handleUpdateTimeScale(scale);
      } else {
        this.handleUpdateTimeScale("month");
      }
    }

    handleUpdateSavedDate(date) {
      this.savedDate = date;
    }

    getSavedDate() {
      var date;
      date = $.cookie("saved_date");
      if (date != null) {
        this.savedDate = moment(date);
      } else {
        this.savedDate = moment();
      }
    }

    handleUpdateDateRange(range) {
      this.dateRange = range;
    }

    getDateRange() {
      var date = this.savedDate;
      var timeScale = this.timeScale;

      if (!timeScale) {return}

      switch (timeScale) {
        case "day":
          return this.handleUpdateDateRange({
            start: moment(date).startOf("day"),
            end: moment(date).endOf("day")
          });
        case "week":
          return this.handleUpdateDateRange({
            start: moment(date).startOf("week"),
            end: moment(date).endOf("week")
          });
        case "month":
          return this.handleUpdateDateRange({
            start: moment(date).startOf("month").startOf("week"),
            end: moment(date).endOf("month").endOf("week")
          });
      }
    }

    handleUpdateTimeScaleTitle(title) {
      this.timeScaleTitle = title;
    }

    getTimeScaleTitle() {
      switch (this.timeScale) {
        case 'day':
          return this.savedDate.format("dddd MM/DD");
        case 'week':
          var start = this.dateRange.start;
          var end = this.dateRange.end;

          if (start.month() === end.month() && start.year() === end.year()) {
            return (start.format("MMM")) + " " + (start.date()) + " - " + (end.date()) + ", " + (start.format("YYYY"));
          } else if (start.month() !== end.month() && start.year() === end.year()) {
            return (start.format("MMM")) + " " + (start.date()) + " - " + (end.format("MMM")) + " " + (end.date()) + ", " + (start.format("YYYY"));
          } else {
            return (start.format("MMM")) + " " + (start.date()) + ", " + (start.format("YYYY")) + " - " + (end.format("MMM")) + " " + (end.date()) + ", " + (end.format("YYYY"));
          }
          break;
        case 'month':
          this.handleUpdateTimeScaleTitle(this.savedDate.format("MMMM YYYY"));
      }
    }

    handleUpdateDays(days) {
      this.days = days;
    }

    getDays() {
      var start = moment(this.dateRange.start);
      var end = moment(this.dateRange.end);
      var results = [];
      while (start < end) {
        day = {
          description: start.toString(),
          date: start.date(),
          month: start.month(),
          currentMonth: this.savedDate.month() === start.month(),
          today: moment().month() === start.month() && moment().date() === start.date() && moment().year() === start.year()
        };
        start.add(1, "day");
        results.push(day);
      }
      this.handleUpdateDays(results);
    }

    handleUpdateWeekdays(weekdays) {
      this.weekdays = weekdays;
    }

    getWeekdays() {
      if (this.timeScale === "week") {
        var start = moment(this.dateRange.start);
        var end = moment(this.dateRange.end);
        var day, results;
        results = [];
        while (start < end) {
          day = {
            description: start.toString(),
            day: start.format("ddd"),
            month: start.month() + 1,
            date: start.date()
          };
          this.start.add(1, "day");
          results.push(day);
        }
        this.handleUpdateWeekdays(results);
      } else {
        this.handleUpdateWeekdays(moment.weekdaysShort());
      }
    }

    setInitialData() {
      this.getTimeScale();
      this.getSavedDate();
      this.getDateRange();
      this.getTimeScaleTitle();
      this.getDays();
      this.getWeekdays();
    }

  };

  this.CalendarStore = alt.createStore(CalendarStore, 'CalendarStore');
})();
