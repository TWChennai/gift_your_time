$(function() {
    window.Calendar.init("#calendar");
    window.Calendar.onReady(function() {
        (function loadEvents() {
            $.ajax({
                url: '/events.json',
                dataType: 'json',
                success: function(data) {
                    var allEvents = [];
                    $.each(data, function(index, eventObject) {
                        allEvents.push({
                            id: eventObject.id,
                            title: eventObject.name,
                            date: eventObject.date,
                            imAttending: true
                        });
                    });
                    window.Calendar.setEvents(allEvents);
                }
            });
        })();
    });
    window.Calendar.onEventClicked(function(eventId) {
        window.location.assign("events/" + eventId);
    });
    window.Calendar.onDayClicked(function(date, events) {
        alert('a day has been clicked!');
    })
});