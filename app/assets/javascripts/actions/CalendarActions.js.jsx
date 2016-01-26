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
  };

  this.CalendarActions = alt.createActions(CalendarActions);
})();
