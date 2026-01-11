import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell
import Quickshell.Io
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
    }

    Rectangle {
      Layout.fillWidth: true
      height: 1
      color: Theme.colMuted
      opacity: 0.3
    }
  }

  RowLayout {
    spacing: 15
    Layout.fillWidth: true

    Repeater {
      model: displayPane.monitors

      Rectangle {
        id: monitorRect
        Layout.preferredWidth: 160
        Layout.preferredHeight: 90
        radius: 12
        color: displayPane.selectedMonitorIdx === index ? Theme.colMuted : (monitorMa.containsMouse ? Theme.colMuted : "transparent")
        opacity: (displayPane.selectedMonitorIdx !== index && monitorMa.containsMouse) ? 0.6 : 1.0
        border.color: Theme.colAccent
        border.width: 1

        ColumnLayout {
          anchors.centerIn: parent
          spacing: 2

          Text {
            text: modelData.name
            color: Theme.colAccent
            font.bold: true
            font.pointSize: 11
            Layout.alignment: Qt.AlignHCenter
          }

          Text {
            text: modelData.width + "x" + modelData.height
            color: Theme.colAccent
            font.pointSize: 9
            Layout.alignment: Qt.AlignHCenter
          }

          Text {
            text: modelData.refreshRate.toFixed(2) + "Hz"
            color: Theme.colAccent
            font.pointSize: 8
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

  Rectangle {
    Layout.fillWidth: true
    height: 1
    color: Theme.colMuted
    opacity: 0.3
  }

  GridLayout {
    columns: 2
    rowSpacing: 25
    columnSpacing: 30
    Layout.fillWidth: true

    ColumnLayout {
      spacing: 8

      Text {
        text: "Monitor Position"
        color: Theme.colAccent
        font.pointSize: 10
      }

      RowLayout {
        spacing: 10

        Repeater {
          model: ["auto", "left", "right"]

          Rectangle {
            Layout.preferredWidth: 70
            Layout.preferredHeight: 32
            radius: 6
            color: displayPane.currentPos === modelData ? Theme.colAccent : (posMa.containsMouse ? Theme.colMuted : "transparent")
            border.color: Theme.colAccent
            border.width: 1

            Text {
              anchors.centerIn: parent
              text: modelData
              color: displayPane.currentPos === modelData ? Theme.colBg : Theme.colAccent
              font.pointSize: 9
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

    ColumnLayout {
      spacing: 8

      Text {
        text: "Hyprland Scaling"
        color: Theme.colAccent
        font.pointSize: 10
      }

      RowLayout {
        spacing: 10

        Repeater {
          model: ["1", "1.5", "2"]

          Rectangle {
            Layout.preferredWidth: 50
            Layout.preferredHeight: 32
            radius: 6
            color: displayPane.currentScale === modelData ? Theme.colAccent : (scaleMa.containsMouse ? Theme.colMuted : "transparent")
            border.color: Theme.colAccent
            border.width: 1

            Text {
              anchors.centerIn: parent
              text: modelData
              color: displayPane.currentScale === modelData ? Theme.colBg : Theme.colAccent
              font.pointSize: 9
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

    ColumnLayout {
      spacing: 8

      Text {
        text: "GDK App Scaling"
        color: Theme.colAccent
        font.pointSize: 10
      }

      RowLayout {
        spacing: 10

        Repeater {
          model: ["1", "2"]

          Rectangle {
            Layout.preferredWidth: 60
            Layout.preferredHeight: 32
            radius: 6
            color: displayPane.currentGdk === modelData ? Theme.colAccent : (gdkMa.containsMouse ? Theme.colMuted : "transparent")
            border.color: Theme.colAccent
            border.width: 1

            Text {
              anchors.centerIn: parent
              text: modelData + "x"
              color: displayPane.currentGdk === modelData ? Theme.colBg : Theme.colAccent
              font.pointSize: 9
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

    ColumnLayout {
      spacing: 8

      Text {
        text: "Resolution & Refresh Rate"
        color: Theme.colAccent
        font.pointSize: 10
      }

      ComboBox {
        id: modeSelector
        Layout.preferredWidth: 185
        Layout.preferredHeight: 45
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
            color: highlighted ? Theme.colBg : Theme.colAccent
            font.pointSize: 10
            verticalAlignment: Text.AlignVCenter
          }

          background: Rectangle {
            color: highlighted ? Theme.colAccent : Theme.colBg
          }
        }

        contentItem: Text {
          leftPadding: 15
          text: modeSelector.displayText
          font.pointSize: 11
          color: Theme.colAccent
          verticalAlignment: Text.AlignVCenter
        }

        background: Rectangle {
          color: Theme.colMuted
          opacity: 0.2
          border.color: Theme.colAccent
          border.width: 1
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

  Item {
    Layout.fillHeight: true
  }

  Rectangle {
    Layout.alignment: Qt.AlignRight
    Layout.preferredWidth: 140
    Layout.preferredHeight: 40
    radius: 10
    color: applyMa.containsMouse ? Theme.colMuted : Theme.colAccent
    border.color: Theme.colAccent
    border.width: 1

    Text {
      anchors.centerIn: parent
      text: "Apply Settings"
      color: applyMa.containsMouse ? Theme.colAccent : Theme.colBg
      font.bold: true
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
