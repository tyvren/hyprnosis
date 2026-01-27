import QtQuick
import QtQuick.Controls
import QtQuick.Effects
import QtQuick.Layouts
import Quickshell
import Quickshell.Io
import qs.Components
import qs.Themes
import qs.Services

ColumnLayout {
  id: hyprPane
  spacing: 20

  property bool active: false

  property string gapsIn: Config.data.gapsIn
  property string gapsOut: Config.data.gapsOut
  property string borderSize: Config.data.borderSize
  property string rounding: Config.data.rounding
  property string activeOpacity: Config.data.activeOpacity
  property string inactiveOpacity: Config.data.inactiveOpacity
  property string allowTearing: Config.data.allowTearing
  property string shadowEnabled: Config.data.shadowEnabled
  property string blurEnabled: Config.data.blurEnabled
  property string blurSize: Config.data.blurSize
  property string blurPasses: Config.data.blurPasses
  property string disableHyprlandLogo: Config.data.disableHyprlandLogo
  property string forceDefaultWallpaper: Config.data.forceDefaultWallpaper

  ColumnLayout {
    spacing: 10
    Layout.fillWidth: true

    Text {
      text: "Hyprland Configuration"
      color: Theme.colAccent
      font.pointSize: 16
      font.family: Theme.fontFamily
      antialiasing: true
    }

    DividerLine { 
      Layout.fillWidth: true 
    }
  }

  GridLayout {
    columns: 2
    rowSpacing: 30
    columnSpacing: 60
    Layout.fillWidth: true
    Layout.alignment: Qt.AlignHCenter

    ColumnLayout {
      spacing: 15
      Layout.fillWidth: true
      Layout.alignment: Qt.AlignTop

      Text { 
        text: "General Layout" 
        color: Theme.colAccent
        font.pointSize: 10 
        font.family: Theme.fontFamily 
        font.bold: true
      }

      RowLayout {
        Layout.fillWidth: true
        Text { 
          text: "Gaps In"
          color: Theme.colText
          font.family: Theme.fontFamily
          Layout.fillWidth: true 
        }
        StyledInput { 
          text: hyprPane.gapsIn
          onUserEdited: (val) => hyprPane.gapsIn = val 
        }
      }

      RowLayout {
        Layout.fillWidth: true
        Text { 
          text: "Gaps Out"
          color: Theme.colText
          font.family: Theme.fontFamily
          Layout.fillWidth: true 
        }
        StyledInput { 
          text: hyprPane.gapsOut
          onUserEdited: (val) => hyprPane.gapsOut = val 
        }
      }

      RowLayout {
        Layout.fillWidth: true
        Text { 
          text: "Border Size"
          color: Theme.colText
          font.family: Theme.fontFamily
          Layout.fillWidth: true 
        }
        StyledInput { 
          text: hyprPane.borderSize
          onUserEdited: (val) => hyprPane.borderSize = val 
        }
      }
    }

    ColumnLayout {
      spacing: 15
      Layout.fillWidth: true
      Layout.alignment: Qt.AlignTop

      Text { 
        text: "Decoration" 
        color: Theme.colAccent
        font.pointSize: 10 
        font.family: Theme.fontFamily
        font.bold: true 
      }

      RowLayout {
        Layout.fillWidth: true
        Text { 
          text: "Rounding"
          color: Theme.colText
          font.family: Theme.fontFamily
          Layout.fillWidth: true 
        }
        StyledInput { 
          text: hyprPane.rounding
          onUserEdited: (val) => hyprPane.rounding = val 
        }
      }

      RowLayout {
        Layout.fillWidth: true
        Text { 
          text: "Active Opacity"
          color: Theme.colText
          font.family: Theme.fontFamily
          Layout.fillWidth: true 
        }
        StyledInput { 
          text: hyprPane.activeOpacity
          onUserEdited: (val) => hyprPane.activeOpacity = val 
        }
      }

      RowLayout {
        Layout.fillWidth: true
        Text { 
          text: "Inactive Opacity"
          color: Theme.colText
          font.family: Theme.fontFamily
          Layout.fillWidth: true 
        }
        StyledInput { 
          text: hyprPane.inactiveOpacity
          onUserEdited: (val) => hyprPane.inactiveOpacity = val 
        }
      }
    }

    ColumnLayout {
      spacing: 15
      Layout.fillWidth: true
      Layout.alignment: Qt.AlignTop

      Text { 
        text: "Blur Settings" 
        color: Theme.colAccent
        font.pointSize: 10 
        font.family: Theme.fontFamily 
        font.bold: true 
      }

      RowLayout {
        Layout.fillWidth: true
        Text { 
          text: "Blur Enabled"
          color: Theme.colText
          font.family: Theme.fontFamily
          Layout.fillWidth: true 
        }
        StyledSwitch { 
          checked: hyprPane.blurEnabled === "true" 
          onToggled: hyprPane.blurEnabled = checked.toString() 
        }
      }

      RowLayout {
        Layout.fillWidth: true
        opacity: hyprPane.blurEnabled === "true" ? 1.0 : 0.4
        enabled: hyprPane.blurEnabled === "true"
        Text { 
          text: "Blur Size"
          color: Theme.colText
          font.family: Theme.fontFamily
          Layout.fillWidth: true 
        }
        StyledInput { 
          text: hyprPane.blurSize
          onUserEdited: (val) => hyprPane.blurSize = val 
        }
      }

      RowLayout {
        Layout.fillWidth: true
        opacity: hyprPane.blurEnabled === "true" ? 1.0 : 0.4
        enabled: hyprPane.blurEnabled === "true"
        Text { 
          text: "Blur Passes"
          color: Theme.colText
          font.family: Theme.fontFamily
          Layout.fillWidth: true 
        }
        StyledInput { 
          text: hyprPane.blurPasses
          onUserEdited: (val) => hyprPane.blurPasses = val 
        }
      }
    }

    ColumnLayout {
      spacing: 15
      Layout.fillWidth: true
      Layout.alignment: Qt.AlignTop

      Text { 
        text: "Miscellaneous" 
        color: Theme.colAccent
        font.pointSize: 10 
        font.family: Theme.fontFamily 
        font.bold: true 
      }

      RowLayout {
        Layout.fillWidth: true
        Text { 
          text: "Tearing"
          color: Theme.colText
          font.family: Theme.fontFamily
          Layout.fillWidth: true 
        }
        StyledSwitch { 
          checked: hyprPane.allowTearing === "true" 
          onToggled: hyprPane.allowTearing = checked.toString() 
        }
      }

      RowLayout {
        Layout.fillWidth: true
        Text { 
          text: "Shadows"
          color: Theme.colText
          font.family: Theme.fontFamily
          Layout.fillWidth: true 
        }
        StyledSwitch {
          checked: hyprPane.shadowEnabled === "true" 
          onToggled: hyprPane.shadowEnabled = checked.toString() 
        }
      }

      RowLayout {
        Layout.fillWidth: true
        Text { 
          text: "Hyprland Logo"
          color: Theme.colText
          font.family: Theme.fontFamily
          Layout.fillWidth: true 
        }
        StyledSwitch { 
          checked: hyprPane.disableHyprlandLogo === "false" 
          onToggled: hyprPane.disableHyprlandLogo = (!checked).toString() 
        } 
      }

      RowLayout {
        Layout.fillWidth: true
        Text { 
          text: "Force Default Wallpaper"
          color: Theme.colText
          font.family: Theme.fontFamily
          Layout.fillWidth: true 
        }
        StyledSwitch { 
          checked: hyprPane.forceDefaultWallpaper === "1" 
          onToggled: hyprPane.forceDefaultWallpaper = checked ? "1" : "0" 
        }
      }
    }
  }

  Item { 
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
        color: applyMa.containsMouse ? Theme.colBg : Theme.colAccent
        font.bold: true
        font.family: Theme.fontFamily
      }

      MouseArea {
        id: applyMa 
        anchors.fill: parent 
        hoverEnabled: true

        onClicked: {
          Config.data.gapsIn = hyprPane.gapsIn
          Config.data.gapsOut = hyprPane.gapsOut
          Config.data.borderSize = hyprPane.borderSize
          Config.data.rounding = hyprPane.rounding
          Config.data.activeOpacity = hyprPane.activeOpacity
          Config.data.inactiveOpacity = hyprPane.inactiveOpacity
          Config.data.blurEnabled = hyprPane.blurEnabled
          Config.data.blurSize = hyprPane.blurSize
          Config.data.blurPasses = hyprPane.blurPasses
          Config.data.allowTearing = hyprPane.allowTearing
          Config.data.shadowEnabled = hyprPane.shadowEnabled
          Config.data.disableHyprlandLogo = hyprPane.disableHyprlandLogo
          Config.data.forceDefaultWallpaper = hyprPane.forceDefaultWallpaper

          Quickshell.execDetached([
            Quickshell.env("HOME") + "/.config/hyprnosis/modules/quickshell/qs_apply_hyprland.sh",
            hyprPane.gapsIn,
            hyprPane.gapsOut,
            hyprPane.borderSize,
            hyprPane.rounding,
            hyprPane.activeOpacity,
            hyprPane.inactiveOpacity,
            hyprPane.allowTearing,
            hyprPane.shadowEnabled,
            hyprPane.blurEnabled,
            hyprPane.blurSize,
            hyprPane.blurPasses,
            hyprPane.disableHyprlandLogo,
            hyprPane.forceDefaultWallpaper
          ]);
        }
      }
    }
  }
}
