import QtQuick
import Quickshell
import qs.Themes

Item {
    id: styledTextRoot
    property string color: "" 
    property string text: ""
    property int textSize: 12

    implicitWidth: styledText.implicitWidth
    implicitHeight: styledText.implicitHeight

    Text {
        id: styledText
        color: styledTextRoot.color
        text: styledTextRoot.text
        font.family: Theme.fontFamily
        font.pointSize: styledTextRoot.textSize
    }
}
