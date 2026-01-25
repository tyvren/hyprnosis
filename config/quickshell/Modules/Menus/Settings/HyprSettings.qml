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

    DividerLine { Layout.fillWidth: true }
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
      Text { text: "General Layout"; color: Theme.colAccent; font.pointSize: 10; font.family: Theme.fontFamily; font.bold: true }
      SettingRow { label: "Gaps In"; StyledInput { text: hyprPane.gapsIn; onUserEdited: (val) => hyprPane.gapsIn = val } }
      SettingRow { label: "Gaps Out"; StyledInput { text: hyprPane.gapsOut; onUserEdited: (val) => hyprPane.gapsOut = val } }
      SettingRow { label: "Border Size"; StyledInput { text: hyprPane.borderSize; onUserEdited: (val) => hyprPane.borderSize = val } }
    }

    ColumnLayout {
      spacing: 15
      Layout.fillWidth: true
      Layout.alignment: Qt.AlignTop
      Text { text: "Decoration"; color: Theme.colAccent; font.pointSize: 10; font.family: Theme.fontFamily; font.bold: true }
      SettingRow { label: "Rounding"; StyledInput { text: hyprPane.rounding; onUserEdited: (val) => hyprPane.rounding = val } }
      SettingRow { label: "Active Opacity"; StyledInput { text: hyprPane.activeOpacity; onUserEdited: (val) => hyprPane.activeOpacity = val } }
      SettingRow { label: "Inactive Opacity"; StyledInput { text: hyprPane.inactiveOpacity; onUserEdited: (val) => hyprPane.inactiveOpacity = val } }
    }

    ColumnLayout {
      spacing: 15
      Layout.fillWidth: true
      Layout.alignment: Qt.AlignTop
      Text { text: "Blur Settings"; color: Theme.colAccent; font.pointSize: 10; font.family: Theme.fontFamily; font.bold: true }
      SettingRow { label: "Blur Enabled"; CustomSwitch { checked: hyprPane.blurEnabled === "true"; onToggled: hyprPane.blurEnabled = checked.toString() } }
      SettingRow { label: "Blur Size"; enabled: hyprPane.blurEnabled === "true"; StyledInput { text: hyprPane.blurSize; onUserEdited: (val) => hyprPane.blurSize = val } }
      SettingRow { label: "Blur Passes"; enabled: hyprPane.blurEnabled === "true"; StyledInput { text: hyprPane.blurPasses; onUserEdited: (val) => hyprPane.blurPasses = val } }
    }

    ColumnLayout {
      spacing: 15
      Layout.fillWidth: true
      Layout.alignment: Qt.AlignTop
      Text { text: "Miscellaneous"; color: Theme.colAccent; font.pointSize: 10; font.family: Theme.fontFamily; font.bold: true }
      SettingRow { label: "Tearing"; CustomSwitch { checked: hyprPane.allowTearing === "true"; onToggled: hyprPane.allowTearing = checked.toString() } }
      SettingRow { label: "Shadows"; CustomSwitch { checked: hyprPane.shadowEnabled === "true"; onToggled: hyprPane.shadowEnabled = checked.toString() } }
      SettingRow { label: "Hyprland Logo"; CustomSwitch { checked: hyprPane.disableHyprlandLogo === "false"; onToggled: hyprPane.disableHyprlandLogo = (!checked).toString() } }
      SettingRow { label: "Force Default Wallpaper"; CustomSwitch { checked: hyprPane.forceDefaultWallpaper === "1"; onToggled: hyprPane.forceDefaultWallpaper = checked ? "1" : "0" } }
    }
  }

  Item { Layout.fillHeight: true }

  Item {
    id: applyBtn
    Layout.alignment: Qt.AlignRight
    Layout.preferredWidth: 160
    Layout.preferredHeight: 40

    MultiEffect {
      anchors.fill: applyBtnRect; source: applyBtnRect
      shadowEnabled: true; shadowBlur: 0.2; shadowColor: Theme.colAccent
      shadowVerticalOffset: 1; shadowHorizontalOffset: 0; opacity: 0.8
    }

    Rectangle {
      id: applyBtnRect
      anchors.fill: parent; radius: 10
      color: applyMa.containsMouse ? Theme.colAccent : Theme.colMuted

      Text {
        anchors.centerIn: parent
        text: "Apply Changes"
        color: applyMa.containsMouse ? Theme.colBg : Theme.colAccent
        font.bold: true; font.family: Theme.fontFamily
      }

      MouseArea {
        id: applyMa; anchors.fill: parent; hoverEnabled: true
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
            Quickshell.env("HOME") + "/.config/hyprnosis/modules/style/qs_apply_hyprland.sh",
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

  component StyledInput : TextField {
    id: input
    signal userEdited(string val)
    color: Theme.colAccent; font.family: Theme.fontFamily; font.pointSize: 10
    verticalAlignment: TextInput.AlignVCenter; horizontalAlignment: TextInput.AlignHCenter
    onTextEdited: userEdited(text)
    background: Rectangle {
      implicitWidth: 80; implicitHeight: 30; radius: 8; color: Theme.colMuted; opacity: 0.3
      border.color: input.activeFocus ? Theme.colAccent : "transparent"; border.width: 1
    }
  }

  component SettingRow : RowLayout {
    property string label: ""
    default property alias content: container.data
    Layout.fillWidth: true; opacity: enabled ? 1.0 : 0.4
    Text { text: label; color: Theme.colAccent; font.family: Theme.fontFamily; Layout.fillWidth: true }
    Item { id: container; Layout.preferredWidth: 80; Layout.preferredHeight: 30 }
  }

  component CustomSwitch : Switch {
    id: control
    indicator: Rectangle {
      implicitWidth: 44; implicitHeight: 22; radius: 11; color: control.checked ? Theme.colAccent : Theme.colMuted; opacity: control.checked ? 1.0 : 0.5
      Rectangle {
        x: control.checked ? parent.width - width - 2 : 2; y: 2; width: 18; height: 18; radius: 9
        color: control.checked ? Theme.colBg : Theme.colAccent
        Behavior on x { NumberAnimation { duration: 150; easing.type: Easing.OutQuad } }
      }
    }
  }
}
