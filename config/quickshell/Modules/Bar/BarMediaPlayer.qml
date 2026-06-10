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
    implicitWidth: 400
    implicitHeight: 28

    OSD {
        id: playerMain
        anchors.fill: parent
        active: Players.active !== null

        ClippingRectangle {
            id: bgImageContainer
            anchors.fill: parent 
            anchors.topMargin: 2
            anchors.bottomMargin: 2
            anchors.rightMargin: 2
            anchors.leftMargin: 2
            opacity: 0.2
            radius: 2
            color: "transparent"

            Image {
                id: backgroundImage
                anchors.fill: parent
                asynchronous: true
                fillMode: Image.PreserveAspectCrop
                visible: false
                source: {
                    const url = Players.active?.trackArtUrl;
                    if (!url) return "";
                    return (url.startsWith("/") && !url.startsWith("file://")) ? "file://" + url : url;
                }
            }

            MultiEffect {
                id: bgImageEffect
                anchors.fill: parent
                source: backgroundImage
                blurEnabled: true
                blur: 0.5
            }
        }

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
                spacing: 10

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

                    StyledText {
                        id: prevText
                        anchors.centerIn: parent
                        text: "󰒮"
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

                    StyledText {
                        id: playText
                        anchors.centerIn: parent
                        text: Players.active && Players.active.isPlaying ? "" : ""
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

                    StyledText {
                        id: nextText
                        anchors.centerIn: parent
                        text: "󰒭"
                        color: nextBtn.containsMouse ? Theme.colAccent : Theme.colText

                        Behavior on color { ColorAnimation { duration: 150 } }
                    }
                }
            }

            StyledText {
                id: artistText
                Layout.alignment: Qt.AlignVCenter
                color: Theme.colAccent
                textSize: 10
                text: Players.active ? (Players.active.trackArtist) : ""
                elide: Text.ElideRight
            }

            StyledText {
                id: titleText
                Layout.fillWidth: true
                Layout.alignment: Qt.AlignVCenter
                color: Theme.colAccent
                textSize: 10
                bold: true
                text: Players.active ? (Players.active.trackTitle) : ""
                elide: Text.ElideRight
            }
        }
    }
}
