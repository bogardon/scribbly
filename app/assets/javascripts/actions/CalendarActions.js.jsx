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

    fetchPosts(id, dateRange) {
      var self = this;

      return (dispatch) => {
        dispatch();
        if (!dateRange) {return};

        var start = moment(dateRange.start);
        var end = moment(dateRange.end);

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
            self.updatePosts(posts);
          }
        });
      };
    }

    updatePosts(posts) {
      return posts;
    }
  };

  this.CalendarActions = alt.createActions(CalendarActions);
})();
