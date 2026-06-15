import QtQuick
import Quickshell
import Quickshell.Io
import qs.Components
import qs.Themes

Item {
    id: bluetoothbutton
    implicitWidth: button.implicitWidth
    implicitHeight: button.implicitHeight

    BarButton {
        id: button
        icon: ""
        onClicked: {
            Quickshell.execDetached(["qs", "ipc", "call", "barMenuBluetooth", "toggle"])
        }
    }
}
