window.CalendarController = function(calenderElementSelector, calendarWidget) {
    var compiledTemplates = {
        eventDetails: _.template($("#event-details-template").html())
    };
    var timeDifferenceInHours = function(pastTime, futureTime) {
        var ms = moment(futureTime, "DD/MM/YYYY HH:mm:ss").diff(moment(pastTime, "DD/MM/YYYY HH:mm:ss"));
        var duration = moment.duration(ms);
        return Math.floor(duration.asHours());
    };
    var toProperTime = function(dateString, timeString) {
        var date = moment(dateString);
        var time = moment(timeString).utc();
        date.hours(time.hours());
        date.minutes(time.minutes());
        return date;
    };
    var registerMobileDetection = function() {
        Foundation.utils.register_media("detect-mobile", "detect-mobile");
    }
    var isMobileViewPort = function() {
        return window.matchMedia(Foundation.media_queries['detect-mobile']).matches;
    }
    this.init = function() {
        calendarWidget.init(calenderElementSelector);
        calendarWidget.onReady($.proxy(this.loadEvents, this));
        calendarWidget.onEventClicked($.proxy(this.redirectToEventPage, this));
        calendarWidget.onDayClicked($.proxy(this.showEventsList, this));
        registerMobileDetection();
    };
    this.loadEvents = function() {
        $.ajax({
            url: '/events.json',
            dataType: 'json',
            success: function(data) {
                var allEvents = [];
                $.each(data, function(index, eventObject) {
                    var startTime = toProperTime(eventObject.date, eventObject.start_time);
                    var endTime = toProperTime(eventObject.date, eventObject.end_time);
                    allEvents.push({
                        id: eventObject.id,
                        title: eventObject.name,
                        description: eventObject.description,
                        startTime: startTime,
                        endTime: endTime,
                        date: eventObject.date,
                        formattedStartTime: startTime.format("hh:mm A ")
                    });
                });
                window.Calendar.setEvents(allEvents);
            }
        });
    };
    this.redirectToEventPage = function(eventId) {
        window.location.assign("events/" + eventId);
    };
    this.showEventsList = function(date, events) {
        var eventsList = [];
        var hoursLeft;
        _.each(events, function(event) {
            var currentTime = moment();
            hoursLeft = timeDifferenceInHours(currentTime, event.startTime);
            eventsList.push({
                formattedStartTime: event.formattedStartTime,
                title: event.title,
                description: event.description,
                eta: hoursLeft > 0 ? "In " + hoursLeft + " hours" : (hoursLeft === 0 ? "Less than an hour" : "")
            });
        });
        var isMobile = isMobileViewPort();
        var eventDetailsHtml = compiledTemplates.eventDetails({
            dayNumber: date.format("DD"),
            monthName: date.format("MMMM"),
            year: date.format("YYYY"),
            events: eventsList,
            isMobile: isMobile
        });
        $("#event-details").html("");
        $("#light-box-container").html("");
        if (isMobile) {
            $("#event-details").html(eventDetailsHtml);
        } else {
            $("#light-box-container").html(eventDetailsHtml);
            $("#light-box-container").foundation("reveal", "open");
        }
    };
};