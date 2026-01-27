import QtQuick
import QtQuick.Controls
import QtQuick.Effects
import QtQuick.Layouts
import Quickshell
import Quickshell.Io
import qs.Components
import qs.Themes

ColumnLayout {
  id: displayPane
  spacing: 20

  property bool active: false
  property var monitors: []
  property int selectedMonitorIdx: 0

  property string currentMode: ""
  property string currentPos: "auto"
  property string currentScale: "1"
  property string currentGdk: "1"

  function updateCurrentSettings() {
    if (monitors.length > 0 && monitors[selectedMonitorIdx]) {
      let m = monitors[selectedMonitorIdx];
      currentMode = m.width + "x" + m.height + "@" + m.refreshRate.toFixed(2) + "Hz";
      currentPos = "auto"
      currentScale = m.scale.toString();
    }
  }

  onSelectedMonitorIdxChanged: updateCurrentSettings()

  Process {
    id: getMonitors
    command: ["hyprctl", "monitors", "-j"]
    running: displayPane.active
    stdout: StdioCollector {
      onStreamFinished: {
        try {
          displayPane.monitors = JSON.parse(text);
          displayPane.updateCurrentSettings();
        } catch(e) {}
      }
    }
  }

  ColumnLayout {
    spacing: 10
    Layout.fillWidth: true

    Text {
      text: "Display Configuration"
      color: Theme.colAccent
      font.pointSize: 16
      font.family: Theme.fontFamily
      antialiasing: true
    }

    DividerLine {
      Layout.fillWidth: true
    }
  }

  RowLayout {
    spacing: 15
    Layout.fillWidth: true
    Layout.alignment: Qt.AlignHCenter

    Repeater {
      model: displayPane.monitors

      Item {
        Layout.preferredWidth: 160
        Layout.preferredHeight: 90
        Layout.alignment: Qt.AlignHCenter

        MultiEffect {
          anchors.fill: monitorRect
          source: monitorRect
          shadowEnabled: true
          shadowBlur: 0.2
          shadowColor: Theme.colAccent
          shadowVerticalOffset: 1
          shadowHorizontalOffset: 0
          opacity: 0.8
        }

        Rectangle {
          id: monitorRect
          anchors.fill: parent
          radius: 12
          color: (displayPane.selectedMonitorIdx === index || monitorMa.containsMouse) ? Theme.colAccent : Theme.colMuted
          border.color: Theme.colAccent
          border.width: 1

          ColumnLayout {
            anchors.centerIn: parent
            spacing: 2

            Text {
              text: modelData.name
              color: (displayPane.selectedMonitorIdx === index || monitorMa.containsMouse) ? Theme.colBg : Theme.colText
              font.bold: true
              font.pointSize: 11
              font.family: Theme.fontFamily
              Layout.alignment: Qt.AlignHCenter
            }

            Text {
              text: modelData.width + "x" + modelData.height
              color: (displayPane.selectedMonitorIdx === index || monitorMa.containsMouse) ? Theme.colBg : Theme.colText
              font.pointSize: 9
              font.family: Theme.fontFamily
              Layout.alignment: Qt.AlignHCenter
            }

            Text {
              text: modelData.refreshRate.toFixed(2) + "Hz"
              color: (displayPane.selectedMonitorIdx === index || monitorMa.containsMouse) ? Theme.colBg : Theme.colText
              font.pointSize: 8
              font.family: Theme.fontFamily
              opacity: 0.7
              Layout.alignment: Qt.AlignHCenter
            }
          }

          MouseArea {
            id: monitorMa
            anchors.fill: parent
            hoverEnabled: true
            onClicked: displayPane.selectedMonitorIdx = index
          }
        }
      }
    }
  }

  DividerLine {
    Layout.fillWidth: true
  }

  GridLayout {
    columns: 2
    rowSpacing: 40
    columnSpacing: 80
    Layout.fillWidth: true
    Layout.alignment: Qt.AlignHCenter

    ColumnLayout {
      spacing: 8
      Layout.fillWidth: true
      Layout.alignment: Qt.AlignHCenter

      Text {
        Layout.alignment: Qt.AlignHCenter
        text: "Resolution & Refresh Rate"
        color: Theme.colAccent
        font.pointSize: 10
        font.family: Theme.fontFamily
      }

      Item {
        Layout.preferredWidth: 220
        Layout.preferredHeight: 35
        Layout.alignment: Qt.AlignHCenter

        ComboBox {
          id: modeSelector
          anchors.fill: parent
          model: displayPane.monitors.length > 0 ? displayPane.monitors[displayPane.selectedMonitorIdx].availableModes : []

          currentIndex: {
            if (displayPane.monitors.length === 0 || !displayPane.currentMode) return -1;
            let modes = displayPane.monitors[displayPane.selectedMonitorIdx].availableModes;
            for (let i = 0; i < modes.length; i++) {
              let btnParts = modes[i].split('@');
              let curParts = displayPane.currentMode.split('@');
              if (btnParts[0] === curParts[0] && btnParts[1].substring(0,3) === curParts[1].substring(0,3)) return i;
            }
            return 0;
          }

          onActivated: (index) => { displayPane.currentMode = model[index]; }

          delegate: ItemDelegate {
            width: modeSelector.width

            contentItem: Text {
              text: modelData
              color: highlighted ? Theme.colBg : Theme.colText
              font.pointSize: 10
              font.family: Theme.fontFamily
              verticalAlignment: Text.AlignVCenter
              horizontalAlignment: Text.AlignHCenter
            }

            background: Rectangle {
              color: Theme.colMuted
              opacity: 0.2
              border.color: Theme.colAccent
              border.width: 1
              radius: 10
            }
          }

          contentItem: Text {
            text: modeSelector.displayText
            font.pointSize: 11
            font.family: Theme.fontFamily
            color: Theme.colText
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
          }

          background: Rectangle {
            id: modeSelectorBackground
            color: Theme.colMuted
            opacity: 0.2
            radius: 10
          }

          popup: Popup {
            y: modeSelector.height + 5
            width: modeSelector.width
            implicitHeight: Math.min(contentItem.implicitHeight, 250)
            padding: 1

            contentItem: ListView {
              clip: true
              implicitHeight: contentHeight
              model: modeSelector.popup.visible ? modeSelector.delegateModel : null
              currentIndex: modeSelector.highlightedIndex
              ScrollIndicator.vertical: ScrollIndicator { }
            }

            background: Rectangle {
              color: Theme.colBg
              border.color: Theme.colAccent
              radius: 10
            }
          }
        }
      }
    }

    ColumnLayout {
      spacing: 8
      Layout.fillWidth: true
      Layout.alignment: Qt.AlignHCenter

      Text {
        Layout.alignment: Qt.AlignHCenter
        text: "Monitor Position"
        color: Theme.colAccent
        font.pointSize: 10
        font.family: Theme.fontFamily
      }

      RowLayout {
        spacing: 10
        Layout.alignment: Qt.AlignHCenter

        Repeater {
          model: ["auto", "left", "right"]

          Item {
            Layout.preferredWidth: 70
            Layout.preferredHeight: 35

            MultiEffect {
              anchors.fill: posBtnRect
              source: posBtnRect
              shadowEnabled: true
              shadowBlur: 0.2
              shadowColor: Theme.colAccent
              shadowVerticalOffset: 1
              shadowHorizontalOffset: 0
              opacity: 0.8
            }

            Rectangle {
              id: posBtnRect
              anchors.fill: parent
              radius: 10
              color: (displayPane.currentPos === modelData || posMa.containsMouse) ? Theme.colAccent : Theme.colMuted

              Text {
                anchors.centerIn: parent
                text: modelData
                color: (displayPane.currentPos === modelData || posMa.containsMouse) ? Theme.colBg : Theme.colText
                font.pointSize: 9
                font.family: Theme.fontFamily
              }

              MouseArea {
                id: posMa
                anchors.fill: parent
                hoverEnabled: true
                onClicked: displayPane.currentPos = modelData
              }
            }
          }
        }
      }
    }

    ColumnLayout {
      spacing: 8
      Layout.fillWidth: true
      Layout.alignment: Qt.AlignHCenter

      Text {
        Layout.alignment: Qt.AlignHCenter
        text: "Hyprland Scaling"
        color: Theme.colAccent
        font.pointSize: 10
        font.family: Theme.fontFamily
      }

      RowLayout {
        spacing: 10
        Layout.alignment: Qt.AlignHCenter

        Repeater {
          model: ["1", "1.5", "2"]

          Item {
            Layout.preferredWidth: 70
            Layout.preferredHeight: 35

            MultiEffect {
              anchors.fill: scaleBtnRect
              source: scaleBtnRect
              shadowEnabled: true
              shadowBlur: 0.2
              shadowColor: Theme.colAccent
              shadowVerticalOffset: 1
              shadowHorizontalOffset: 0
              opacity: 0.8
            }

            Rectangle {
              id: scaleBtnRect
              anchors.fill: parent
              radius: 10
              color: (displayPane.currentScale === modelData || scaleMa.containsMouse) ? Theme.colAccent : Theme.colMuted

              Text {
                anchors.centerIn: parent
                text: modelData
                color: (displayPane.currentScale === modelData || scaleMa.containsMouse) ? Theme.colBg : Theme.colText
                font.pointSize: 9
                font.family: Theme.fontFamily
              }

              MouseArea {
                id: scaleMa
                anchors.fill: parent
                hoverEnabled: true
                onClicked: displayPane.currentScale = modelData
              }
            }
          }
        }
      }
    }

    ColumnLayout {
      spacing: 8
      Layout.fillWidth: true
      Layout.alignment: Qt.AlignHCenter

      Text {
        Layout.alignment: Qt.AlignHCenter
        text: "GDK App Scaling"
        color: Theme.colAccent
        font.pointSize: 10
        font.family: Theme.fontFamily
      }

      RowLayout {
        spacing: 10
        Layout.alignment: Qt.AlignHCenter

        Repeater {
          model: ["1", "2"]

          Item {
            Layout.preferredWidth: 70
            Layout.preferredHeight: 35

            MultiEffect {
              anchors.fill: gdkBtnRect
              source: gdkBtnRect
              shadowEnabled: true
              shadowBlur: 0.2
              shadowColor: Theme.colAccent
              shadowVerticalOffset: 1
              shadowHorizontalOffset: 0
              opacity: 0.8
            }

            Rectangle {
              id: gdkBtnRect
              anchors.fill: parent
              radius: 10
              color: (displayPane.currentGdk === modelData || gdkMa.containsMouse) ? Theme.colAccent : Theme.colMuted

              Text {
                anchors.centerIn: parent
                text: modelData + "x"
                color: (displayPane.currentGdk === modelData || gdkMa.containsMouse) ? Theme.colBg : Theme.colText
                font.pointSize: 9
                font.family: Theme.fontFamily
              }

              MouseArea {
                id: gdkMa
                anchors.fill: parent
                hoverEnabled: true
                onClicked: displayPane.currentGdk = modelData
              }
            }
          }
        }
      }
    }
  }

  Item {
    id: menuSpacer
    Layout.fillHeight: true
  }

  Item {
    id: applyBtn
    Layout.alignment: Qt.AlignRight
    Layout.preferredWidth: 90
    Layout.preferredHeight: 35

    MultiEffect {
      anchors.fill: applyBtnRect
      source: applyBtnRect
      shadowEnabled: true
      shadowBlur: 0.2
      shadowColor: Theme.colAccent
      shadowVerticalOffset: 1
      shadowHorizontalOffset: 0
      opacity: 0.8
    }

    Rectangle {
      id: applyBtnRect
      anchors.fill: parent
      radius: 10
      color: applyMa.containsMouse ? Theme.colAccent : Theme.colMuted

      Text {
        anchors.centerIn: parent
        text: "Apply"
        color: applyMa.containsMouse ? Theme.colBg : Theme.colText
        font.bold: true
        font.family: Theme.fontFamily
      }

      MouseArea {
        id: applyMa
        anchors.fill: parent
        hoverEnabled: true
        onClicked: {
          let monitor = displayPane.monitors[displayPane.selectedMonitorIdx];
          Quickshell.execDetached([
            Quickshell.env("HOME") + "/.config/hyprnosis/modules/style/qs_apply_monitors.sh",
            monitor.name,
            displayPane.currentMode,
            displayPane.currentPos,
            displayPane.currentScale,
            displayPane.currentGdk
          ]);
        }
      }
    }
  }
}
