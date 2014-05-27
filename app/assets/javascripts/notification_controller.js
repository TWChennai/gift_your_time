window.NotificationController = function(noticeMsgsSelector, alertMsgsSelector) {
    var noticeMsgs = $(noticeMsgsSelector).contents();
    var alertMsgs = $(alertMsgsSelector).contents();
    this.showNotifications = function() {
        var notyOptions = {
            timeout: 2000
        };
        if (noticeMsgs.length > 0) {
            notyOptions["text"] = noticeMsgs[0];
            notyOptions["type"] = "sucess";
            noty(notyOptions);
        }
        if (alertMsgs.length > 0) {
            notyOptions["text"] = alertMsgs[0];
            noty(notyOptions);
        }
    };
};