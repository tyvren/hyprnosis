import QtQuick
import Quickshell
import qs.Themes

Item {
    id: styledTextRoot
    property var color: Theme.colText
    property var elide: Text.ElideNone
    property var horizontalAlignment: Text.AlignLeft
    property var verticalAlignment: Text.AlignVCenter
    property var maximumLineCount: 0
    property var bold: false
    property var wrapMode: Text.NoWrap
    property string text: ""
    property int size: 12

    implicitWidth: styledText.implicitWidth
    implicitHeight: styledText.implicitHeight

    Text {
        id: styledText
        width: parent.width
        height: parent.height
        color: styledTextRoot.color
        elide: styledTextRoot.elide
        text: styledTextRoot.text
        font.bold: styledTextRoot.bold
        font.family: Theme.fontFamily
        font.pointSize: styledTextRoot.size
        horizontalAlignment: styledTextRoot.horizontalAlignment
        verticalAlignment: styledTextRoot.verticalAlignment
        maximumLineCount: styledTextRoot.maximumLineCount
        wrapMode: styledTextRoot.wrapMode
    }
}
