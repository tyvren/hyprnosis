import QtQuick
import Quickshell
import Quickshell.Io
import qs.Components
import qs.Modules.Menus.BarMenu
import qs.Themes

Item {
    id: bluetoothbutton
    implicitWidth: button.implicitWidth
    implicitHeight: button.implicitHeight

    BarButton {
        id: button
        icon: ""
        
        onClicked: { bluetoothBarMenuLoader.item.visible = !bluetoothBarMenuLoader.item.visible }
    }
      
    LazyLoader {
        id: bluetoothBarMenuLoader
        loading: true

        BluetoothMenu {}
    }
}
