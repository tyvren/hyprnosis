import QtQuick
import Quickshell
import Quickshell.Io
import qs.Components
import qs.Modules.Menus
import qs.Themes

Item {
    id: quickMenuBtn
    implicitWidth: button.implicitWidth
    implicitHeight: button.implicitHeight

    BarButton {
        id: button
        icon: "󰍜"
        onClicked: { sidePaneLoader.item.visible = !sidePaneLoader.item.visible }
    }

    LazyLoader {
        id: sidePaneLoader
        loading: true

        SidePane {}
    }
}
