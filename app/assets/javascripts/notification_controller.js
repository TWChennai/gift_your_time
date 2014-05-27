window.NotificationController = function(noticeMsgsSelector, alertMsgsSelector) {
    var noticeMsgs = $(noticeMsgsSelector).contents();
    var alertMsgs = $(alertMsgsSelector).contents();
    this.showNotifications = function() {
        if (noticeMsgs.length > 0) {
            noty({
                text: noticeMsgs[0],
                timeout: 2000,
                type: "success"
            });
        }
        if (alertMsgs.length > 0) {
            noty({
                text: alertMsgs[0],
                timeout: true
            });
        }
    };
};