import QtQuick
import qs.Services
import qs.Components
import qs.Themes

Item {
  id: batterybutton
  implicitWidth: button.implicitWidth
  implicitHeight: button.implicitHeight
  visible: Battery.available

  BarButton {
    id: button
    icon: Math.round(Battery.percentage * 100) + "%"
  }
}
