pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Services.Notifications

Singleton {
  id: root

  property alias notifications: notifServer.trackedNotifications
  signal notification(notification: Notification)
  
  signal clearAllRequested()

  function clearAll() {
    root.clearAllRequested()
  }

  NotificationServer {
    id: notifServer

    actionsSupported: false
    bodySupported: true
    bodyMarkupSupported: true
    bodyImagesSupported: false
    bodyHyperlinksSupported: false
    persistenceSupported: false
    imageSupported: true

    onNotification: function(notif) {
      notif.tracked = true
      
      root.clearAllRequested.connect(notif.dismiss)
      
      notif.closed.connect(() => {
        root.clearAllRequested.disconnect(notif.dismiss)
      })

      root.notification(notif)
    }
  }
}
