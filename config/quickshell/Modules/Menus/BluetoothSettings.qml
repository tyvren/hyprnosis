import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import qs.Themes
import qs.Services

Item {
  id: bluetoothRoot

  ColumnLayout {
    anchors.fill: parent
    spacing: 15

    RowLayout {
      Layout.fillWidth: true

      Text { 
        text: "Bluetooth"
        color: Theme.colAccent
        font.pointSize: 14 
        font.family: Theme.fontFamily
        Layout.alignment: Qt.AlignVCenter
      }

      Item { Layout.fillWidth: true }
      
      Switch {
        id: btToggle
        checked: Bluetooth.enabled
        onToggled: Bluetooth.togglePower()
        Layout.alignment: Qt.AlignVCenter
        
        indicator: Rectangle {
          implicitWidth: 48; implicitHeight: 24; radius: 12
          color: btToggle.checked ? Theme.colAccent : Theme.colMuted
          opacity: btToggle.checked ? 1.0 : 0.3
          Rectangle {
            x: btToggle.checked ? parent.width - width - 4 : 4; y: 4
            width: 16; height: 16; radius: 8
            color: btToggle.checked ? Theme.colBg : Theme.colAccent
            Behavior on x { NumberAnimation { duration: 200 } }
          }
        }
      }
    }

    ScrollView {
      Layout.fillWidth: true
      Layout.fillHeight: true
      clip: true

      ListView {
        model: Bluetooth.devices
        spacing: 8
        delegate: ItemDelegate {
          width: parent.width
          height: 55
          background: Rectangle {
            color: modelData.connected ? Theme.colAccent : Theme.colMuted
            opacity: modelData.connected ? 0.2 : 0.1
            radius: 10
          }

          contentItem: Item {
            anchors.fill: parent

            Text { 
              id: btIcon
              text: Bluetooth.getIcon(modelData)
              color: Theme.colAccent
              font.pointSize: 14 
              anchors.verticalCenter: parent.verticalCenter
              anchors.left: parent.left
              anchors.leftMargin: 15
            }

            Column {
              id: btLabelColumn
              anchors.verticalCenter: parent.verticalCenter
              anchors.left: btIcon.right
              anchors.leftMargin: 15
              spacing: 0

              Text { 
                text: modelData.name
                color: Theme.colAccent
                font.bold: modelData.connected
                font.family: Theme.fontFamily
              }
              Text { 
                text: modelData.connected ? "Connected" : (modelData.paired ? "Paired" : "Available")
                color: Theme.colMuted
                font.pointSize: 8
                font.family: Theme.fontFamily
              }
            }
            
            Item { Layout.fillWidth: true }

            Rectangle {
              visible: modelData.paired || modelData.connected
              width: 70; height: 26; radius: 6
              color: forgetMa.containsMouse ? Theme.colAccent : "transparent"
              border.color: Theme.colAccent; border.width: 1
              anchors.verticalCenter: parent.verticalCenter
              anchors.right: parent.right
              anchors.rightMargin: 15

              Text {
                anchors.centerIn: parent
                text: "Forget"
                font.pointSize: 8
                color: forgetMa.containsMouse ? Theme.colBg : Theme.colAccent
              }

              MouseArea {
                id: forgetMa
                anchors.fill: parent
                hoverEnabled: true
                onClicked: Bluetooth.forgetDevice(modelData)
              }
            }
          }
          onClicked: Bluetooth.connectDevice(modelData)
        }
      }
    }

    Rectangle {
      id: scanBtnRect
      Layout.alignment: Qt.AlignRight
      Layout.preferredWidth: 100
      Layout.preferredHeight: 35
      radius: 10
      color: scanMa.containsMouse ? Theme.colAccent : Theme.colMuted
      
      Text {
        anchors.centerIn: parent
        text: Bluetooth.scanning ? "..." : "Scan"
        color: scanMa.containsMouse ? Theme.colBg : Theme.colAccent
        font.bold: true
        font.family: Theme.fontFamily
      }
      
      MouseArea {
        id: scanMa
        anchors.fill: parent
        hoverEnabled: true
        onClicked: Bluetooth.toggleScan()
      }
    }
  }
}
