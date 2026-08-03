pragma Singleton
import QtQuick
import qs.Services

QtObject {
    id: windowStates

    property bool bluetoothOpen: false
    property bool launcherOpen: false
    property bool mediaPlayerOpen: false
    property bool networkOpen: false
    property bool notificationOSDOpen: false
    property bool timeDateOSDOpen: true
    property bool volumeOSDOpen: false
    property bool mediaPlayerInGracePeriod: false

    function restoreDefaultState() {
        bluetoothOpen = false
        launcherOpen = false
        networkOpen = false

        if (Players.isPlaying || mediaPlayerInGracePeriod) {
            mediaPlayerOpen = true
            timeDateOSDOpen = false
        } else {
            mediaPlayerOpen = false
            timeDateOSDOpen = true
        }
    }

    onBluetoothOpenChanged: {
        if (bluetoothOpen) {
            launcherOpen = false
            mediaPlayerOpen = false
            networkOpen = false
            notificationOSDOpen = false
            timeDateOSDOpen = false
            volumeOSDOpen = false
        } else {
            restoreDefaultState()
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
            restoreDefaultState()
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
        }
    }

    onNetworkOpenChanged: {
        if (networkOpen) {
            bluetoothOpen = false
            launcherOpen = false
            mediaPlayerOpen = false
            notificationOSDOpen = false
            timeDateOSDOpen = false
            volumeOSDOpen = false
        } else {
            restoreDefaultState()
        }
    }

    onNotificationOSDOpenChanged: {
        if (notificationOSDOpen) {
            bluetoothOpen = false
            launcherOpen = false
            mediaPlayerOpen = false
            networkOpen = false
            timeDateOSDOpen = false
            volumeOSDOpen = false
        } else if (!volumeOSDOpen) {
            restoreDefaultState()
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
        } else if (!notificationOSDOpen) {
            restoreDefaultState()
        }
    }
}
