import QtQuick
import QtQuick.Controls
import QtQuick.Effects
import QtQuick.Layouts
import Quickshell
import Quickshell.Hyprland
import Quickshell.Widgets
import qs.Components
import qs.Services
import qs.Themes

PopupWindow {
    id: centerMenu
    implicitWidth: 350
    implicitHeight: 225
    color: "transparent"

    HyprlandFocusGrab {
        id: focusGrab
        windows: [centerMenu]
        onCleared: centerMenu.visible = false
    }

    onVisibleChanged: {
        if (visible) {
            focusGrab.active = true
            currentTab = "media"
        } else {
            focusGrab.active = false
        }
    }

    property string currentTab: "media"

    Rectangle {
        id: container
        anchors.fill: parent
        radius: 20
        color: Theme.colBg
        border.color: Theme.colAccent
        border.width: 1
        opacity: centerMenu.visible ? 1.0 : 0.0

        Behavior on opacity {
            NumberAnimation {
                duration: 500
            }
        }

        Keys.onEscapePressed: centerMenu.visible = false

        ColumnLayout {
            anchors.fill: parent
            anchors.margins: 5
            spacing: 5

            RowLayout {
                id: tabBar
                Layout.fillWidth: true
                spacing: 20

                Item {
                    Layout.fillWidth: true
                }

                Text {
                    text: "󰎆"
                    font.family: Theme.fontFamily
                    font.pointSize: 22
                    color: currentTab === "media" ? Theme.colAccent : Theme.colMuted
                    MouseArea {
                        anchors.fill: parent
                        onClicked: currentTab = "media"
                    }
                }

                Text {
                    text: ""
                    font.family: Theme.fontFamily
                    font.pointSize: 22
                    color: currentTab === "calendar" ? Theme.colAccent : Theme.colMuted
                    MouseArea {
                        anchors.fill: parent
                        onClicked: currentTab = "calendar"
                    }
                }

                Item {
                    Layout.fillWidth: true
                }
            }

            DividerLine {
                Layout.fillWidth: true
            }

            Rectangle {
                Layout.fillWidth: true
                Layout.fillHeight: true
                color: "transparent"

                Rectangle {
                    id: mediaContent
                    anchors.fill: parent
                    visible: currentTab === "media"
                    color: "transparent"

                    MultiEffect {
                        id: mediaShadow
                        anchors.fill: playerMain
                        source: playerMain
                        shadowEnabled: true
                        shadowColor: Theme.colAccent
                        shadowBlur: 0.5
                        shadowOpacity: 0.7
                    }

                    Rectangle {
                        id: playerMain
                        anchors.fill: parent
                        anchors.margins: 5
                        color: "transparent"

                        ClippingRectangle {
                            id: bgImageContainer
                            anchors.fill: playerMain
                            opacity: 0.6
                            radius: 15
                            color: "transparent"

                            Image {
                                id: backgroundImage
                                anchors.fill: parent
                                asynchronous: true
                                fillMode: Image.PreserveAspectCrop
                                visible: false
                                source: Players.active?.trackArtUrl || ""
                            }

                            MultiEffect {
                                id: bgImageEffect
                                anchors.fill: parent
                                source: backgroundImage
                                blurEnabled: true
                                blur: 0.8
                            }
                        }

                        Rectangle {
                            id: trackInfo
                            width: 200
                            height: 130
                            anchors.top: parent.top
                            anchors.topMargin: 6
                            anchors.left: parent.left
                            anchors.leftMargin: 20
                            color: Theme.colBg
                            radius: 15
                            clip: true

                            ColumnLayout {
                                anchors.fill: parent
                                anchors.margins: 4
                                spacing: 4

                                Text {
                                    Layout.fillWidth: true
                                    horizontalAlignment: Text.AlignHCenter
                                    color: Theme.colAccent
                                    font.pointSize: 10
                                    font.bold: true
                                    font.family: Theme.fontFamily
                                    text: Players.active ? Players.active.trackTitle : "No Media Playing"
                                    elide: Text.ElideRight
                                }

                                Item {
                                    Layout.fillHeight: true
                                }

                                Text {
                                    Layout.fillWidth: true
                                    horizontalAlignment: Text.AlignHCenter
                                    color: Theme.colAccent
                                    font.pointSize: 10
                                    font.bold: true
                                    font.family: Theme.fontFamily
                                    text: Players.active ? Players.active.trackArtist : ""
                                    elide: Text.ElideRight
                                }
                            }
                        }

                        Rectangle {
                            id: albumArt
                            anchors.centerIn: trackInfo
                            color: "transparent"
                            width: 85
                            height: 85
                            radius: 15

                            RectangularShadow {
                                anchors.fill: parent
                                anchors.margins: 10
                                color: Theme.colAccent
                                blur: 15
                                spread: -3
                                radius: 12
                            }

                            ClippingRectangle {
                                anchors.fill: parent
                                radius: 15
                                color: "transparent"

                                Image {
                                    anchors.fill: parent
                                    asynchronous: true
                                    fillMode: Image.PreserveAspectCrop
                                    source: Players.active?.trackArtUrl || ""
                                }
                            }
                        }

                        ColumnLayout {
                            width: 160
                            anchors.left: parent.left
                            anchors.leftMargin: 40
                            anchors.bottom: parent.bottom
                            anchors.bottomMargin: 5
                            spacing: 2

                            Slider {
                                id: trackBar
                                Layout.fillWidth: true
                                from: 0
                                to: Players.active ? Players.active.length : 0
                                value: Players.active ? Players.active.position : 0
                                onMoved: { if (Players.active?.canSeek) Players.active.position = value }

                                background: Rectangle {
                                    x: trackBar.leftPadding 
                                    y: trackBar.topPadding + trackBar.availableHeight / 2 - height / 2
                                    implicitHeight: 4 
                                    width: trackBar.availableWidth 
                                    height: implicitHeight 
                                    radius: 2 
                                    color: Theme.colBg 
                                    opacity: 0.5

                                    Rectangle { 
                                      width: trackBar.visualPosition * parent.width 
                                      height: parent.height 
                                      color: Theme.colAccent 
                                      radius: 2 
                                    }
                                }

                                handle: Rectangle {
                                    x: trackBar.leftPadding + trackBar.visualPosition * (trackBar.availableWidth - width); y: trackBar.topPadding + trackBar.availableHeight / 2 - height / 2
                                    implicitWidth: 10 
                                    implicitHeight: 10 
                                    radius: 5; color: Theme.colAccent
                                }
                            }
                        }

                        ColumnLayout {
                            id: playerControls
                            anchors.top: parent.top
                            anchors.topMargin: 10
                            anchors.right: parent.right
                            anchors.rightMargin: 35
                            spacing: 5

                            Rectangle {
                                Layout.alignment: Qt.AlignHCenter
                                width: 36
                                height: 36
                                radius: 18
                                color: prevArea.containsMouse ? Theme.colAccent : Theme.colBg

                                Text {
                                    anchors.centerIn: parent
                                    text: "󰒮"
                                    font.pointSize: 14
                                    color: prevArea.containsMouse ? Theme.colBg : Theme.colAccent
                                }

                                MouseArea {
                                    id: prevArea
                                    anchors.fill: parent
                                    hoverEnabled: true
                                    onClicked: Players.active?.previous()
                                }
                            }

                            Rectangle {
                                Layout.alignment: Qt.AlignHCenter
                                width: 44
                                height: 44
                                radius: 22
                                color: playArea.containsMouse ? Theme.colAccent : Theme.colBg

                                Text {
                                    anchors.centerIn: parent
                                    text: Players.active?.isPlaying ? "" : ""
                                    font.pointSize: 16
                                    color: playArea.containsMouse ? Theme.colBg : Theme.colAccent
                                }

                                MouseArea {
                                    id: playArea
                                    anchors.fill: parent
                                    hoverEnabled: true
                                    onClicked: Players.active?.togglePlaying()
                                }
                            }

                            Rectangle {
                                Layout.alignment: Qt.AlignHCenter
                                width: 36
                                height: 36
                                radius: 18
                                color: nextArea.containsMouse ? Theme.colAccent : Theme.colBg

                                Text {
                                    anchors.centerIn: parent
                                    text: "󰒭"
                                    font.pointSize: 14
                                    color: nextArea.containsMouse ? Theme.colBg : Theme.colAccent
                                }

                                MouseArea {
                                    id: nextArea
                                    anchors.fill: parent
                                    hoverEnabled: true
                                    onClicked: Players.active?.next()
                                }
                            }
                        }
                    }
                }

                Rectangle {
                    id: calendarContent
                    anchors.fill: parent
                    visible: currentTab === "calendar"
                    color: "transparent"

                    GridLayout {
                        columns: 1
                        anchors.fill: parent
                        anchors.margins: 5

                        DayOfWeekRow {
                            locale: grid.locale
                            Layout.fillWidth: true
                            delegate: Text {
                                horizontalAlignment: Text.AlignHCenter
                                verticalAlignment: Text.AlignVCenter
                                text: model.shortName
                                font.family: Theme.fontFamily
                                font.pointSize: 10
                                color: Theme.colAccent
                            }
                        }

                        MonthGrid {
                            id: grid
                            readonly property date today: new Date()
                            month: today.getMonth()
                            year: today.getFullYear()
                            locale: Qt.locale("en_US")
                            Layout.fillWidth: true
                            Layout.fillHeight: true
                            delegate: Text {
                                required property var model
                                horizontalAlignment: Text.AlignHCenter
                                verticalAlignment: Text.AlignVCenter
                                text: model.day
                                font.family: Theme.fontFamily
                                font.pointSize: 10
                                color: model.today ? Theme.colHilight : model.month === grid.month
                                        ? Theme.colAccent : "transparent"
                            }
                        }
                    }
                }
            }
        }
    }
}
