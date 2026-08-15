import QtQuick
import Quickshell
import Quickshell.Io
import qs.Components
import qs.Modules.Menus.BarMenu
import qs.Services
import qs.Themes

Item {
    id: networkbutton
    implicitWidth: button.implicitWidth
    implicitHeight: button.implicitHeight

    BarButton {
        id: button
        icon: {
            if (Network.ethernetConnected) {
                return "󰈀"
            }
            if (!Network.wifiEnabled) {
                return "󰤮"
            }
            const activeNet = Network.networks[Network.connectedSsid]
            if (activeNet) {
                return Network.signalIcon(activeNet.signal)
            }
            return "󰤯"
        }
        onClicked: { networkBarMenuLoader.item.visible = !networkBarMenuLoader.item.visible }
      }
    LazyLoader {
        id: networkBarMenuLoader
        loading: true

        NetworkMenu {}
    }
}
