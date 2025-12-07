import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Services.Pipewire
import Quickshell.Widgets
import "../.."

Scope {
	id: root

	PwObjectTracker {
		objects: [ Pipewire.defaultAudioSink ]
	}

	Connections {
		target: Pipewire.defaultAudioSink?.audio

		function onVolumeChanged() {
			root.shouldShowOsd = true;
			hideTimer.restart();
		}
	}

	property bool shouldShowOsd: false

	Timer {
		id: hideTimer
		interval: 1000
		onTriggered: root.shouldShowOsd = false
	}

	LazyLoader {
		active: root.shouldShowOsd

		PanelWindow {

      anchors.top: true
      anchors.right: true
			exclusiveZone: 0
			implicitWidth: 300
      implicitHeight: 50

      property var theme: Theme {}
			color: "transparent"

			mask: Region {}

			Rectangle {
				anchors.fill: parent
				radius: height / 2
				color: theme.colTransB

				RowLayout {
					anchors {
						fill: parent
						leftMargin: 10
						rightMargin: 15
					}

					IconImage {
            implicitSize: 30
						source: Quickshell.iconPath("/usr/share/icons/Tela-circle-dracula/22/actions/audio-volume-high.svg", true)
					}

					Rectangle {
						Layout.fillWidth: true

						implicitHeight: 10
						radius: 20
						color: theme.colBg 

            Rectangle {
              color: theme.colAccent

							anchors {
								left: parent.left
								top: parent.top
								bottom: parent.bottom
							}

							implicitWidth: parent.width * (Pipewire.defaultAudioSink?.audio.volume ?? 0)
							radius: parent.radius
						}
					}
				}
			}
		}
	}
}
