import QtQuick
import QtQuick.Effects
import qs.Themes

Item {
    id: root
    property string icon: ""
    property bool isActive: false
    property alias containsMouse: mouseArea.containsMouse
    signal clicked()
    
    implicitWidth: iconText.implicitWidth
    implicitHeight: iconText.implicitHeight

    Text {
        id: iconText
        text: root.icon
        font.family: Theme.fontFamily
        font.pixelSize: Theme.fontSize
        color: Theme.colAccent
        layer.enabled: true
        visible: false
    }

    BtnTextShadow {
        anchors.fill: parent
        source: iconText
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true
        onClicked: root.clicked()
    }
}
