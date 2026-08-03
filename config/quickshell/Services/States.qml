pragma Singleton
import QtQuick

QtObject {
    id: windowStates

    property bool bluetoothOpen: false
    property bool launcherOpen: false
    property bool mediaPlayerOpen: false
    property bool networkOpen: false
    property bool notificationOSDOpen: false
    property bool timeDateOSDOpen: true
    property bool volumeOSDOpen: false

   onBluetoothOpenChanged: {
        if (bluetoothOpen) {
            launcherOpen = false
            mediaPlayerOpen = false
            networkOpen = false
            notificationOSDOpen = false
            timeDateOSDOpen = false
            volumeOSDOpen = false
          } else {
            timeDateOSDOpen = true
          } 
    }

    onLauncherOpenChanged: {
        if (launcherOpen) {
            bluetoothOpen = false
            mediaPlayerOpen = false
            networkOpen = false
            notificationOSDOpen = false
            timeDateOSDOpen = false
            volumeOSDOpen = false
          } else {
            timeDateOSDOpen = true
          } 
    }

    onMediaPlayerOpenChanged: {
        if (mediaPlayerOpen) {
            bluetoothOpen = false
            launcherOpen = false
            networkOpen = false
            notificationOSDOpen = false
            timeDateOSDOpen = false
            volumeOSDOpen = false
        } else {
            timeDateOSDOpen = true
        }
    }
    
    onNotificationOSDOpenChanged: {
        if (notificationOSDOpen) {
            bluetoothOpen = false
            launcherOpen = false
            networkOpen = false
            timeDateOSDOpen = false
            volumeOSDOpen = false
        } else {
            timeDateOSDOpen = true
        }
    }
    onVolumeOSDOpenChanged: {
        if (volumeOSDOpen) {
            bluetoothOpen = false
            launcherOpen = false
            mediaPlayerOpen = false
            networkOpen = false
            notificationOSDOpen = false
            timeDateOSDOpen = false
          } else {
            timeDateOSDOpen = true
          }
    }
}
