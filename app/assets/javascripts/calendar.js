window.Calendar = (function() {
    var eventClickHandlers = [];
    var dayClickHandlers = [];
    var onReadyHandlers = [];
    var monthChangeHandlers = [];
    var calendarWidget;
    var calendarElement;
    var isCalendarReady = false;
    var handleEventClick = function(event) {
        var eventId = $(event.target).closest("li.inline-event").data("event-id");
        event.stopPropagation();
        _.each(eventClickHandlers, function(handler) {
            handler(eventId);
        });
    };
    var handleDayClick = function(target) {
        _.each(dayClickHandlers, function(handler) {
            handler(target.date, target.events);
        })
    }
    var handleOnReady = function() {
        _.each(onReadyHandlers, function(handler) {
            handler();
        });
    }
    var handleMonthChange = function(month) {
        _.each(monthChangeHandlers, function(handler) {
            handler(month);
        });
    }
    return {
        init: function(containerSelector) {
            calendarElement = $(containerSelector);
            calendarWidget = calendarElement.clndr({
                template: $("#calendar-template").html(),
                clickEvents: {
                    click: handleDayClick,
                    onMonthChange: handleMonthChange
                },
                doneRendering: function() {
                    calendarElement.find(".inline-event-list li").bind("click", handleEventClick);
                },
                ready: function() {
                    isCalendarReady = true;
                    handleOnReady();
                },
                daysOfTheWeek: ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat']
            });
        },
        onReady: function(callback) {
            if (isCalendarReady) {
                callback();
            };
            onReadyHandlers.push(callback);
        },
        onDayClicked: function(callback) {
            dayClickHandlers.push(callback);
        },
        onMonthChanged: function(callback) {
            monthChangeHandlers.push(callback);
        },
        onEventClicked: function(callback) {
            eventClickHandlers.push(callback);
        },
        setEvents: function(events) {
            calendarWidget.setEvents(events);
        },
        addEvents: function(events) {
            calendarWidget.addEvents(events);
        }
    };
})();