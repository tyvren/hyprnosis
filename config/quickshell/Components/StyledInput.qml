import QtQuick
import QtQuick.Controls
import qs.Themes

TextField {
  id: input
  color: Theme.colAccent 
  font.family: Theme.fontFamily 
  font.pointSize: 10
  verticalAlignment: TextInput.AlignVCenter 
  horizontalAlignment: TextInput.AlignHCenter

  signal userEdited(string val)
  onTextEdited: userEdited(text)

  background: Rectangle {
    implicitWidth: 80 
    implicitHeight: 30 
    radius: 8 
    color: Theme.colMuted 
    opacity: 0.3
    border.color: input.activeFocus ? Theme.colAccent : "transparent" 
    border.width: 1
  }
}
