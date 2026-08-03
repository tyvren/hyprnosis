import QtQuick
import QtQuick.Effects
import qs.Services
import qs.Themes

Item {
    id: clockWrapper
    implicitWidth: clock.implicitWidth
    implicitHeight: clock.implicitHeight

    property int textSize: Theme.fontSize
    property string orientation: "horizontal"

    Text {
        id: clock
        text: {
            if (clockWrapper.orientation === "vertical") {
                return Time.vertical;
            } else if (clockWrapper.orientation === "horizontal") {
                     return Time.horizontal;
              }
              else if (clockWrapper.orientation === "horizontalFull") {
                     return Time.horizontalFull;
              }    
        }  
        font.family: Theme.fontFamily
        font.pixelSize: clockWrapper.textSize
        font.bold: true
        color: Theme.colAccent
    }
}
