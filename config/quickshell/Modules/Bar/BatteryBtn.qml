import QtQuick
import Quickshell.Widgets
import qs.Services
import qs.Components
import qs.Themes

Item {
    id: root
    implicitWidth: 55
    implicitHeight: 24
    property real percentage: Battery.percentage
    property bool isCharging: Battery.isCharging
    property bool isFull: Battery.isFull
    property bool available: Battery.available
    visible: available
    
    readonly property color fillCol: percentage <= 0.2 ? Theme.colAccent : percentage <= 0.4 ? Theme.colAccent : Theme.colAccent
    
    readonly property string icon: {
        if (isCharging) return ""
        const icons = ["", "", "", "", ""]
        return icons[Math.min(Math.floor(percentage * 5), 4)]
    }
    
    readonly property string statusText: {
        if (isFull) return "Fully Charged"
        if (isCharging) return "Charging"
        return "On Battery"
    }
    
    Rectangle { 
        anchors.fill: parent
        color: Theme.colMuted 
        radius: height / 2 
    }

    ClippingRectangle {
        anchors.fill: parent
        radius: height / 2
        color: "transparent"
        
        Rectangle {
          color: root.fillCol
          height: parent.height
          width: parent.width * root.percentage
          Behavior on width { 
              NumberAnimation { 
                duration: 250 
                easing.type: Easing.OutCubic 
              } 
          }
        }
    }
    
    Column {
        anchors.centerIn: parent

        Row { 
            spacing: 2
            
            Text {
                id: icon
                text: root.icon
                color: Theme.colBg
                font.bold: true
                font.pointSize: 9
            }
            
            Text {
              id: percentageText
              text: Math.round(root.percentage * 100) + "%" 
              color: Theme.colBg 
              font.bold: true 
              font.pointSize: 9
            }
        }
        
        Text {
          id: statusText
          text: root.statusText 
          color: Theme.colBg 
          font.pointSize: 6 
          opacity: 0.7 
        }         
    }
}
