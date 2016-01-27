(() => {
  class CalendarActions {
    updateTimeScale(timeScale) {
      return timeScale;
    }

    onTimeScaleArrowClick(scaleAmount) {
      return scaleAmount;
    }

    onTodayButtonClick() {
      return true;
    }

    fetchPosts(id) {
      return id;
    }
  };

  this.CalendarActions = alt.createActions(CalendarActions);
})();
