import QtQuick
import QtQuick.Effects
import Quickshell
import Quickshell.Io
import qs.Components
import qs.Themes

Item {
    id: mainMenuBtn
    implicitWidth: 25 
    implicitHeight: 25

    BarButton {
        id: mainMenuComponent
        icon: "   "
        onClicked: {
            quickMenuLoader.item.visible = !quickMenuLoader.item.visible 
        }
    }

    Image {
        id: buttonLogo
        width: 25
        height: 25
        anchors.verticalCenter: parent.verticalCenter
        source: Theme.logoPath
        mipmap: true
        asynchronous: true
        fillMode: Image.PreserveAspectFit
        layer.enabled: true
        visible: false
    }

    MultiEffect {
        anchors.fill: parent
        source: buttonLogo
        shadowEnabled: true
        shadowBlur: 0.2
        shadowOpacity: 0.7
    } 
}
