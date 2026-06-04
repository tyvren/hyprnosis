import QtQuick
import QtQuick.Controls
import QtQuick.Effects
import QtQuick.Layouts
import Quickshell
import Quickshell.Widgets
import qs.Components
import qs.Modules.OSD
import qs.Services
import qs.Themes

Item {
    id: root
    implicitWidth: 350
    implicitHeight: 28

    OSD {
        anchors.fill: parent
        active: Players.active !== null

        RowLayout {
            anchors.fill: parent
            anchors.leftMargin: 6
            anchors.rightMargin: 15
            spacing: 12

            Item {
                id: albumArt
                width: 20
                height: 20
                Layout.alignment: Qt.AlignVCenter

                ClippingRectangle {
                    anchors.fill: parent
                    radius: 4
                    color: "transparent"

                    Image {
                        id: albumImage
                        anchors.fill: parent
                        asynchronous: true
                        fillMode: Image.PreserveAspectCrop
                        source: {
                            const url = Players.active ? Players.active.trackArtUrl : "";
                            if (!url || url === "") {
                                return albumImage.source;
                            }
                            return (url.startsWith("/") && !url.startsWith("file://")) ? "file://" + url : url;
                        }
                    }
                }
            }

            RowLayout {
                id: playerControls
                spacing: 14

                MouseArea {
                    id: prevBtn
                    implicitWidth: 16
                    implicitHeight: 16
                    Layout.alignment: Qt.AlignVCenter
                    hoverEnabled: true
                    onClicked: Players.active?.previous()

                    MultiEffect {
                        anchors.fill: prevText
                        source: prevText
                        shadowEnabled: true
                        shadowBlur: prevBtn.containsMouse ? 0.5 : 0.2
                        shadowColor: Theme.colAccent
                        shadowVerticalOffset: 1
                        shadowHorizontalOffset: 1
                        opacity: prevBtn.containsMouse ? 1.0 : 0.5

                        Behavior on shadowBlur { NumberAnimation { duration: 150 } }
                        Behavior on opacity { NumberAnimation { duration: 150 } }
                    }

                    Text {
                        id: prevText
                        anchors.centerIn: parent
                        text: "󰒮"
                        font.family: Theme.fontFamily
                        font.pointSize: 11
                        color: prevBtn.containsMouse ? Theme.colAccent : Theme.colText

                        Behavior on color { ColorAnimation { duration: 150 } }
                    }
                }

                MouseArea {
                    id: playBtn
                    implicitWidth: 16
                    implicitHeight: 16
                    Layout.alignment: Qt.AlignVCenter
                    hoverEnabled: true
                    onClicked: Players.active?.togglePlaying()

                    MultiEffect {
                        anchors.fill: playText
                        source: playText
                        shadowEnabled: true
                        shadowBlur: playBtn.containsMouse ? 0.5 : 0.2
                        shadowColor: Theme.colAccent
                        shadowVerticalOffset: 1
                        shadowHorizontalOffset: 1
                        opacity: playBtn.containsMouse ? 1.0 : 0.5

                        Behavior on shadowBlur { NumberAnimation { duration: 150 } }
                        Behavior on opacity { NumberAnimation { duration: 150 } }
                    }

                    Text {
                        id: playText
                        anchors.centerIn: parent
                        text: Players.active && Players.active.isPlaying ? "" : ""
                        font.family: Theme.fontFamily
                        font.pointSize: 11
                        color: playBtn.containsMouse ? Theme.colAccent : Theme.colText

                        Behavior on color { ColorAnimation { duration: 150 } }
                    }
                }

                MouseArea {
                    id: nextBtn
                    implicitWidth: 16
                    implicitHeight: 16
                    Layout.alignment: Qt.AlignVCenter
                    hoverEnabled: true
                    onClicked: Players.active?.next()

                    MultiEffect {
                        anchors.fill: nextText
                        source: nextText
                        shadowEnabled: true
                        shadowBlur: nextBtn.containsMouse ? 0.5 : 0.2
                        shadowColor: Theme.colAccent
                        shadowVerticalOffset: 1
                        shadowHorizontalOffset: 1
                        opacity: nextBtn.containsMouse ? 1.0 : 0.5

                        Behavior on shadowBlur { NumberAnimation { duration: 150 } }
                        Behavior on opacity { NumberAnimation { duration: 150 } }
                    }

                    Text {
                        id: nextText
                        anchors.centerIn: parent
                        text: "󰒭"
                        font.family: Theme.fontFamily
                        font.pointSize: 11
                        color: nextBtn.containsMouse ? Theme.colAccent : Theme.colText

                        Behavior on color { ColorAnimation { duration: 150 } }
                    }
                }
            }

            Text {
                id: trackText
                Layout.fillWidth: true
                Layout.alignment: Qt.AlignVCenter
                color: Theme.colAccent
                font.pointSize: 10
                font.bold: true
                font.family: Theme.fontFamily
                text: Players.active ? (Players.active.trackTitle + " — " + Players.active.trackArtist) : ""
                elide: Text.ElideRight
            }
        }
    }
}
