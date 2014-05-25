window.EventController = function(selector) {
    var eventContainer = $(selector);
    var startTimeElement = eventContainer.find("#start_time");
    var endTimeElement = eventContainer.find("#end_time");

    var onStartTimeChanged = function() {
        var startTime = $(this).val();
        endTimeElement.timepicker("remove");
        endTimeElement.timepicker({
            'minTime': startTime,
            'maxTime': '12:00am',
            'showDuration': true,
            'timeFormat': 'h:i A'
        });
    };

    this.init = function() {
        startTimeElement.timepicker({
            'scrollDefaultNow': true,
            'timeFormat': 'h:i A'
        });
        startTimeElement.on("changeTime", onStartTimeChanged);
        endTimeElement.timepicker({
            'scrollDefaultNow': true,
            'timeFormat': 'h:i A'
        });
    };
};