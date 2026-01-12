import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import QtQuick.Effects
import Quickshell
import qs.Themes
import qs.Services

ColumnLayout {
  id: audioPane
  spacing: 25

  ColumnLayout {
    spacing: 10
    Layout.fillWidth: true

    Text {
      text: "Audio Configuration"
      color: Theme.colAccent
      font.pointSize: 16
      font.family: Theme.fontFamily
    }

    Rectangle {
      Layout.fillWidth: true
      height: 1
      color: Theme.colMuted
      opacity: 0.3
    }
  }

  ColumnLayout {
    spacing: 20
    Layout.fillWidth: true

    AudioControlRow {
      title: "Output Device"
      currentDevice: Audio.sink
      deviceList: Audio.sinkNodes
      volume: Audio.sinkVolume
      isMuted: Audio.sinkMuted
      icon: Audio.sinkMuted ? "󰝟" : "󰓃"
      onVolumeSet: (val) => Audio.setSinkVolume(val)
      onToggleMute: Audio.toggleSinkMute()
      onDeviceSelected: (node) => Audio.selectSink(node)
    }

    Rectangle {
      Layout.fillWidth: true
      height: 1
      color: Theme.colMuted
      opacity: 0.15
    }

    AudioControlRow {
      title: "Input Device"
      currentDevice: Audio.source
      deviceList: Audio.sourceNodes
      volume: Audio.sourceVolume
      isMuted: Audio.sourceMuted
      icon: Audio.sourceMuted ? "󰍭" : "󰍬"
      onVolumeSet: (val) => Audio.setSourceVolume(val)
      onToggleMute: Audio.toggleSourceMute()
      onDeviceSelected: (node) => Audio.selectSource(node)
    }
  }

  Item { Layout.fillHeight: true }

  component AudioControlRow : ColumnLayout {
    property string title
    property var currentDevice
    property var deviceList
    property real volume
    property bool isMuted
    property string icon
    
    signal volumeSet(real val)
    signal toggleMute()
    signal deviceSelected(var node)

    spacing: 12
    Layout.fillWidth: true

    RowLayout {
      Layout.fillWidth: true
      
      ColumnLayout {
        spacing: 5
        Text {
          text: title
          color: Theme.colAccent
          font.pointSize: 10
          font.family: Theme.fontFamily
        }

        Item {
          Layout.preferredWidth: 350
          Layout.preferredHeight: 45

          MultiEffect {
            anchors.fill: comboBackground
            source: comboBackground
            shadowEnabled: true
            shadowBlur: 0.2
            shadowColor: Theme.colAccent
            shadowVerticalOffset: 1
            shadowHorizontalOffset: 0
            opacity: 0.8
          }

          ComboBox {
            id: deviceSelector
            anchors.fill: parent
            model: deviceList
            textRole: "description"

            currentIndex: {
              if (!currentDevice || !deviceList || deviceList.length === 0) return -1;
              for (let i = 0; i < deviceList.length; i++) {
                if (deviceList[i] && deviceList[i].id === currentDevice.id) return i;
              }
              return -1;
            }

            onActivated: (index) => {
              const node = deviceList[index];
              if (node) deviceSelected(node);
            }

            delegate: ItemDelegate {
              width: deviceSelector.width

              contentItem: Text {
                text: modelData.description || "Unknown Device"
                color: highlighted ? Theme.colBg : Theme.colAccent
                font.pointSize: 10
                font.family: Theme.fontFamily
                verticalAlignment: Text.AlignVCenter
                elide: Text.ElideRight
              }

              background: Rectangle {
                color: highlighted ? Theme.colAccent : "transparent"
                radius: 10
              }
            }

            contentItem: Text {
              leftPadding: 15
              rightPadding: 30
              text: deviceSelector.displayText
              font.pointSize: 11
              font.family: Theme.fontFamily
              color: Theme.colAccent
              verticalAlignment: Text.AlignVCenter
              elide: Text.ElideRight
            }

            background: Rectangle {
              id: comboBackground
              color: Theme.colMuted
              opacity: 0.2
              radius: 10
              border.color: deviceSelector.activeFocus ? Theme.colAccent : "transparent"
              border.width: 1
            }

            popup: Popup {
              y: deviceSelector.height + 5
              width: deviceSelector.width
              implicitHeight: Math.min(contentItem.implicitHeight, 250)
              padding: 1

              contentItem: ListView {
                clip: true
                implicitHeight: contentHeight
                model: deviceSelector.popup.visible ? deviceSelector.delegateModel : null
                currentIndex: deviceSelector.highlightedIndex
                ScrollIndicator.vertical: ScrollIndicator { }
              }

              background: Rectangle {
                color: Theme.colBg
                border.color: Theme.colAccent
                border.width: 1
                radius: 10
              }
            }
          }
        }
      }

      Item { Layout.fillWidth: true }

      Text {
        text: Math.round(volume * 100) + "%"
        color: isMuted ? Theme.colMuted : Theme.colAccent
        font.pointSize: 11
        font.family: Theme.fontFamily
        font.bold: true
        Layout.alignment: Qt.AlignBottom
        Layout.bottomMargin: 10
      }
    }

    RowLayout {
      spacing: 15
      Layout.fillWidth: true

      Item {
        Layout.preferredWidth: 45
        Layout.preferredHeight: 45

        MultiEffect {
          anchors.fill: muteBtnBg
          source: muteBtnBg
          shadowEnabled: true
          shadowBlur: 0.2
          shadowColor: Theme.colAccent
          shadowVerticalOffset: 1
          shadowHorizontalOffset: 0
          opacity: 0.8
        }

        Rectangle {
          id: muteBtnBg
          anchors.fill: parent
          radius: 10
          color: muteMa.containsMouse ? Theme.colAccent : Theme.colMuted
          
          Text {
            anchors.centerIn: parent
            text: icon
            font.pointSize: 16
            color: muteMa.containsMouse ? Theme.colBg : (isMuted ? Theme.colMuted : Theme.colAccent)
          }

          MouseArea {
            id: muteMa
            anchors.fill: parent
            hoverEnabled: true
            onClicked: toggleMute()
          }
        }
      }

      Slider {
        id: volSlider
        Layout.fillWidth: true
        value: volume || 0
        from: 0
        to: 1
        
        background: Rectangle {
          x: volSlider.leftPadding
          y: volSlider.topPadding + volSlider.availableHeight / 2 - height / 2
          implicitWidth: 200
          implicitHeight: 6
          width: volSlider.availableWidth
          height: implicitHeight
          radius: 3
          color: Theme.colMuted
          opacity: 0.5

          Rectangle {
            width: volSlider.visualPosition * parent.width
            height: parent.height
            color: isMuted ? Theme.colMuted : Theme.colAccent
            radius: 3
          }
        }

        handle: Rectangle {
          x: volSlider.leftPadding + volSlider.visualPosition * (volSlider.availableWidth - width)
          y: volSlider.topPadding + volSlider.availableHeight / 2 - height / 2
          implicitWidth: 16
          implicitHeight: 16
          radius: 8
          color: volSlider.pressed ? Theme.colAccent : Theme.colBg
          border.color: Theme.colAccent
          border.width: 2
        }

        onMoved: volumeSet(value)
      }
    }
  }
}
