(() => {
  class CalendarActions {
    updateTimeScale(timeScale) {
      return timeScale;
    }

    onTimeScaleArrowClick(scaleAmount) {
      return scaleAmount;
    }
  };

  this.CalendarActions = alt.createActions(CalendarActions);
})();
