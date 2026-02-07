import QtQuick
import QtQuick.Effects
import qs.Services
import qs.Themes

Item {
    id: clockWrapper
    implicitWidth: clock.implicitWidth
    implicitHeight: clock.implicitHeight

    Text {
        id: clock
        text: TimeH.time
        font.family: Theme.fontFamily
        font.pixelSize: Theme.fontSize
        font.bold: true
        color: Theme.colAccent
    }
}

