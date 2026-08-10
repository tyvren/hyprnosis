import QtQuick
import QtQuick.Controls
import qs.Services
import qs.Themes

TextField {
    id: input
    color: Theme.colText 
    font.family: Theme.fontFamily 
    font.pointSize: 10
    verticalAlignment: TextInput.AlignVCenter 
    horizontalAlignment: TextInput.AlignHCenter

    signal userEdited(string val)
    onTextEdited: userEdited(text)

    background: Rectangle {
        implicitWidth: 80 
        implicitHeight: 30 
        radius: Config.data.rounding 
        color: Theme.colMuted 
        opacity: 0.3
        border.color: input.activeFocus ? Theme.colAccent : "transparent" 
        border.width: Config.data.borderSize
    }
}
