import QtQuick
import Quickshell
import qs.Themes

Item {
    id: styledTextRoot
    property var color: Theme.colText
    property var elide: ""
    property var bold: false
    property string text: ""
    property int textSize: 12

    implicitWidth: styledText.implicitWidth
    implicitHeight: styledText.implicitHeight

    Text {
        id: styledText
        color: styledTextRoot.color
        elide: styledTextRoot.elide
        text: styledTextRoot.text
        font.bold: styledTextRoot.bold
        font.family: Theme.fontFamily
        font.pointSize: styledTextRoot.textSize
    }
}
