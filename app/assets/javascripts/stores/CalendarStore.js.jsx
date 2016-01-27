(() => {
  class CalendarStore {
    constructor() {
      this.timeScale = null;
      this.savedDate = null;
      this.dateRange = null;
      this.timeScaleTitle = null;
      this.days = [];
      this.weekdays = [];

      this.posts = [];

      this.bindListeners({
        handleUpdateTimeScale: CalendarActions.UPDATE_TIME_SCALE,
        handleOnTimeScaleArrowClick: CalendarActions.ON_TIME_SCALE_ARROW_CLICK,
        handleOnTodayButtonClick: CalendarActions.ON_TODAY_BUTTON_CLICK,
        handleFetchPosts: CalendarActions.FETCH_POSTS
      });

      this.on('init', () => {
        // init is called when the store is initialized as well as whenever a store is recycled.
        this.setInitialData();
      });
    }

    handleUpdateTimeScale(timeScale) {
      this.timeScale = timeScale;
      this.getDateRange(timeScale);
    }

    getTimeScale() {
      var scale = this.timeScale || $.cookie("time_scale");

      if (scale != null) {
        this.handleUpdateTimeScale(scale);
      } else {
        this.handleUpdateTimeScale("month");
      }
    }

    handleUpdateSavedDate(date) {
      this.savedDate = date;
      this.getTimeScale();
    }

    getSavedDate() {
      var date = $.cookie("saved_date");

      if (date != null) {
        this.handleUpdateSavedDate(moment(date));
      } else {
        this.handleUpdateSavedDate(moment());
      }
    }

    handleOnTimeScaleArrowClick(scaleAmount) {
      var newDate = this.savedDate.add(scaleAmount, this.timeScale);
      console.log('newData', newDate);
      $.cookie('saved_date', newDate);
      this.handleUpdateSavedDate(newDate);
    }

    handleOnTodayButtonClick() {
      var newDate = moment();
      $.cookie('saved_date', newDate);
      this.handleUpdateSavedDate(newDate);
    }

    handleUpdateDateRange(range) {
      this.dateRange = range;
      this.getDays();
      this.getWeekdays();
      this.getTimeScaleTitle();
    }

    getDateRange(timeScale) {
      var date = this.savedDate;
      var timeScale = timeScale || this.timeScale;

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
      if (!this.savedDate) {return}

      switch (this.timeScale) {
        case 'day':
          return this.handleUpdateTimeScaleTitle(this.savedDate.format("dddd MM/DD"));
        case 'week':
          var start = this.dateRange.start;
          var end = this.dateRange.end;

          if (start.month() === end.month() && start.year() === end.year()) {
            return this.handleUpdateTimeScaleTitle((start.format("MMM")) + " " + (start.date()) + " - " + (end.date()) + ", " + (start.format("YYYY")));
          } else if (start.month() !== end.month() && start.year() === end.year()) {
            return this.handleUpdateTimeScaleTitle((start.format("MMM")) + " " + (start.date()) + " - " + (end.format("MMM")) + " " + (end.date()) + ", " + (start.format("YYYY")));
          } else {
            return this.handleUpdateTimeScaleTitle((start.format("MMM")) + " " + (start.date()) + ", " + (start.format("YYYY")) + " - " + (end.format("MMM")) + " " + (end.date()) + ", " + (end.format("YYYY")));
          }
          break;
        case 'month':
          return this.handleUpdateTimeScaleTitle(this.savedDate.format("MMMM YYYY"));
      }
    }

    handleUpdateDays(days) {
      this.days = days;
    }

    getDays() {
      var start = moment(this.dateRange.start);
      var end = moment(this.dateRange.end);
      var results = [];
      var day;

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
        var results = [];
        var day = {};

        while (start < end) {
          day = {
            description: start.toString(),
            day: start.format("ddd"),
            month: start.month() + 1,
            date: start.date()
          };
          start.add(1, "day");
          results.push(day);
        }
        this.handleUpdateWeekdays(results);
      } else {
        this.handleUpdateWeekdays(moment.weekdaysShort());
      }
    }

    handleUpdatePosts(posts) {
      this.posts = posts;
    }

    handleFetchPosts(id) {
      if (!this.dateRange) {return};

      var self = this;
      var start = moment(this.dateRange.start);
      var end = moment(this.dateRange.end);

      var data = {
        collaboration_id: id,
        start: start.toString(),
        end: end.toString()
      };

      $.ajax({
        url: "/posts",
        method: "GET",
        data: data,
        dataType: 'json',
        success: function(posts) {
          self.handleUpdatePosts(posts);
        }
      });
    }

    setInitialData() {
      this.getTimeScale();
      this.getSavedDate();
      this.getTimeScaleTitle();
      this.getDateRange();
      this.getDays();
      this.getWeekdays();
    }

  };

  this.CalendarStore = alt.createStore(CalendarStore, 'CalendarStore');
})();
