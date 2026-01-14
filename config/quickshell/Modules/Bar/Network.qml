import QtQuick
import Quickshell
import Quickshell.Io
import qs.Components
import qs.Themes

Item {
  id: networkbutton
  implicitWidth: button.implicitWidth
  implicitHeight: button.implicitHeight

  BarButton {
    id: button
    icon: ""
    onClicked: {
      Quickshell.execDetached(["qs", "ipc", "call", "settingsmenu", "openTo", "5"])
    }
  }
}
