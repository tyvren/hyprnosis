import QtQuick
import QtQuick.Controls
import QtQuick.Effects
import QtQuick.Layouts
import Quickshell
import Quickshell.Hyprland
import Quickshell.Io
import Quickshell.Widgets
import qs.Services
import qs.Themes

PanelWindow {
    id: launcherMenu
    visible: false
    focusable: true
    implicitWidth: 400
    implicitHeight: 400
    color: "transparent"
    property string query: ""
    property var filteredApps: DesktopEntries.applications.values
    exclusionMode: ExclusionMode.Ignore

    property bool open: false
    property bool showContent: false

    required property var modelData

    anchors {
        top: Config.data.barLayout === "top" ? true : false
        bottom: Config.data.barLayout === "bottom" ? true : false
    }

    onVisibleChanged: {
        if (visible) {
            open = true
            focusGrab.active = true
        } else {
            open = false
            focusGrab.active = false
        }
        query = ""
    }

    onQueryChanged: {
        if (query === "") {
            filteredApps = DesktopEntries.applications.values
        } else {
            filteredApps = DesktopEntries.applications.values.filter(app =>
                app.name.toLowerCase().includes(query.toLowerCase())
            )
        }
    }

    IpcHandler {
        target: "launcher-menu"

        function toggle(): void {
            if (launcherMenu.visible && launcherMenu.open) {
                launcherMenu.open = false
            } else {
                launcherMenu.visible = true
            }
        }

        function hide(): void {
            launcherMenu.open = false
        }
    }

    Item {
        id: launcherContainer
        width: 400
        height: 400
        anchors.horizontalCenter: parent.horizontalCenter
        state: launcherMenu.open ? "open" : "closed"

        Keys.onEscapePressed: launcherMenu.open = false

        states: [
            State {
                name: "closed"
                PropertyChanges {
                    target: launcherContainer
                    opacity: 0.5
                    y: Config.data.barLayout === "top" ? -369 : 369
                }
            },
            State {
                name: "open"
                PropertyChanges {
                    target: launcherContainer
                    opacity: 1
                    y: Config.data.barLayout === "top" ? -30 : 30
                }
            }
        ]

        transitions: [
            Transition {
                from: "closed"
                to: "open"
                SequentialAnimation {
                    NumberAnimation {
                        properties: "opacity, y"
                        duration: 150
                        easing.type: Easing.OutQuart
                    }
                    ScriptAction { 
                        script: {
                            launcherMenu.showContent = true
                        } 
                    }
                }
            },
            Transition {
                from: "open"
                to: "closed"
                SequentialAnimation {
                    ScriptAction { script: launcherMenu.showContent = false }
                    NumberAnimation {
                        properties: "opacity, y"
                        duration: 250
                        easing.type: Easing.InQuart
                    }
                    ScriptAction { script: launcherMenu.visible = false }
                }
            }
        ]

        Item {
            id: topBackgroundContainer
            anchors.fill: parent
            visible: Config.data.barLayout === "top"
        

            Rectangle {
                id: topBackground
                anchors.fill: parent
                anchors.topMargin: 30
                radius: 5 
                color: Theme.colBg
                border.color: Theme.colAccent
                border.width: 1
                clip: true
                visible: Config.data.barLayout === "top"

                Image {
                    id: logoImage
                    anchors.centerIn: parent
                    width: 400
                    height: 375
                    source: Theme.logoPath
                    mipmap: true
                    asynchronous: true
                    fillMode: Image.PreserveAspectFit
                    opacity: 0.3
                }

                Loader {
                    id: topContentLoader
                    anchors.fill: parent
                    active: launcherMenu.showContent
                    focus: true
                    sourceComponent: launcherContent
                }
            }

            MultiEffect {
                id: topLauncherShadow
                anchors.fill: topBackground
                source: topBackground
                shadowEnabled: true
                shadowColor: Theme.colAccent
                shadowBlur: 0.2
                z: -1
            }
        }

        Item {
            id: bottomBackgroundContainer
            anchors.fill: parent
            visible: Config.data.barLayout === "bottom"
            
            Rectangle {
                id: bottomBackground
                anchors.fill: parent
                anchors.bottomMargin: 30
                radius: 5 
                color: Theme.colBg
                border.color: Theme.colAccent
                border.width: 1
                clip: true
                visible: Config.data.barLayout === "bottom"

                Image {
                    id: bottomLogoImage
                    anchors.centerIn: parent
                    width: 400
                    height: 375
                    source: Theme.logoPath
                    mipmap: true
                    asynchronous: true
                    fillMode: Image.PreserveAspectFit
                    opacity: 0.3
                }

                Loader {
                    id: bottomContentLoader
                    anchors.fill: parent
                    active: launcherMenu.showContent
                    focus: true
                    sourceComponent: launcherContent
                }
            }

            MultiEffect {
                id: bottomLauncherShadow
                anchors.fill: bottomBackground
                source: bottomBackground
                shadowEnabled: true
                shadowColor: Theme.colAccent
                shadowBlur: 0.2
                z: 0
            }
        }
    }

    Component {
        id: launcherContent
        ColumnLayout {
            anchors.fill: parent
            anchors.topMargin: Config.data.barLayout === "top" ? 2 : 10
            anchors.bottomMargin: Config.data.barLayout === "top" ? 10 : 2
            spacing: 5
            opacity: 0
            Component.onCompleted: {
                opacity = 1
                searchField.forceActiveFocus()
            }
            Behavior on opacity { NumberAnimation { duration: 250 } }

            Rectangle {
                Layout.row: Config.data.barLayout === "top" ? 0 : 1
                Layout.alignment: Qt.AlignHCenter
                Layout.preferredWidth: parent.width - 50
                height: 28
                radius: 5
                color: Theme.colBg
                border.color: Theme.colAccent
                border.width: 1

                TextField {
                    id: searchField
                    anchors.centerIn: parent
                    width: parent.width - 20
                    height: parent.height - 2
                    verticalAlignment: TextInput.AlignVCenter
                    placeholderText: "Search apps..."
                    placeholderTextColor: Theme.colAccent
                    color: Theme.colAccent
                    font.family: Theme.fontFamily
                    font.pointSize: 14
                    background: null
                    text: launcherMenu.query

                    onTextChanged: {
                        launcherMenu.query = text
                    }

                    Keys.onPressed: event => {
                        if ((event.key === Qt.Key_Return || event.key === Qt.Key_Enter)
                                && gridview.currentIndex >= 0) {
                            const app = gridview.model[gridview.currentIndex]
                            Quickshell.execDetached({
                                command: ["sh", "-c", app.execute()]
                            })
                            launcherMenu.open = false
                            event.accepted = true
                        }

                        if (event.key === Qt.Key_Down || event.key === Qt.Key_Tab) {
                            gridview.forceActiveFocus()
                            event.accepted = true
                        }
                    }
                }
            }

            GridView {
                id: gridview
                Layout.row: Config.data.barLayout === "top" ? 1 : 0
                Layout.fillHeight: true
                Layout.preferredWidth: 376
                Layout.alignment: Qt.AlignHCenter
                model: launcherMenu.filteredApps
                clip: true
                keyNavigationEnabled: true
                cellWidth: 94
                cellHeight: 105
                currentIndex: launcherMenu.filteredApps.length > 0 ? 0 : -1

                ScrollBar.vertical: ScrollBar {
                    policy: ScrollBar.AsNeeded
                }

                Keys.onPressed: event => {
                    if ((event.key === Qt.Key_Return || event.key === Qt.Key_Enter)
                            && currentIndex >= 0) {
                        const app = model[currentIndex]
                        Quickshell.execDetached({
                            command: ["sh", "-c", app.execute()]
                        })
                        launcherMenu.open = false
                        event.accepted = true
                    }
                }

                delegate: Item {
                    id: appDelegate
                    width: 94
                    height: 105
                    property bool isHighlighted: GridView.isCurrentItem || mouseArea.containsMouse

                    MultiEffect {
                        anchors.fill: delegateRectangle
                        source: delegateRectangle
                        shadowEnabled: true
                        shadowBlur: appDelegate.isHighlighted ? 0.8 : 0
                        shadowColor: Theme.colAccent
                        shadowVerticalOffset: 1
                        shadowHorizontalOffset: 1
                        opacity: appDelegate.isHighlighted ? 1 : 1
                        
                        Behavior on shadowBlur { NumberAnimation { duration: 150 } }
                        Behavior on opacity { NumberAnimation { duration: 150 } }
                    }

                    Rectangle {
                        id: delegateRectangle
                        width: 80
                        height: 80
                        anchors.centerIn: parent
                        radius: 5
                        color: Theme.colBg 
                        border.color: Theme.colAccent
                        border.width: 1
                        
                        Behavior on border.color { ColorAnimation { duration: 150 } }
                        
                        ColumnLayout {
                            anchors.centerIn: parent
                            width: parent.width - 15
                            spacing: 4

                            IconImage {
                                source: Quickshell.iconPath(modelData.icon, true) || ""
                                Layout.preferredWidth: 34
                                Layout.preferredHeight: 34
                                Layout.alignment: Qt.AlignHCenter
                            }

                            Text {
                                text: modelData.name
                                color: mouseArea.containsMouse ? Theme.colAccent : Theme.colText
                                font.family: Theme.fontFamily
                                font.pointSize: 7
                                Layout.fillWidth: true
                                horizontalAlignment: Text.AlignHCenter
                                elide: Text.ElideRight
                                maximumLineCount: 1
                            }
                        }

                        MouseArea {
                            id: mouseArea
                            anchors.fill: parent
                            hoverEnabled: true
                            onClicked: {
                                Quickshell.execDetached({
                                    command: ["sh", "-c", modelData.execute()]
                                })
                                launcherMenu.open = false
                            }
                        }
                    }
                }
            }
        }
    }

    HyprlandFocusGrab {
        id: focusGrab
        windows: [ launcherMenu ]
        
        onCleared: {
            launcherMenu.open = false
        } 
    }
}
