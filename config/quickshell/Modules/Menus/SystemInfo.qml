import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell
import Quickshell.Io
import qs.Themes
import qs.Components

ColumnLayout {
  id: infoPane
  spacing: 20

  property bool active: false
  property string osName: "Arch Linux"
  property string kernel: "..."
  property string uptime: "..."
  property string pkgs: "..."
  property string cpu: "..."
  property string gpu: "..."
  property string mem: "..."
  property var disks: []

  onActiveChanged: {
    if (active) {
      sysFetcher.running = false
      sysFetcher.running = true
    }
  }

  Timer {
    interval: 60000
    running: infoPane.active
    repeat: true
    onTriggered: {
      sysFetcher.running = false
      sysFetcher.running = true
    }
  }

  Text {
    text: "About"
    color: Theme.colAccent
    font.pointSize: 16
    font.family: Theme.fontFamily
  }

  DividerLine {
    Layout.fillWidth: true
  }

  ColumnLayout {
    Layout.fillWidth: true
    Layout.alignment: Qt.AlignHCenter
    spacing: 15
    Layout.topMargin: 10

    Item {
      Layout.preferredWidth: 120
      Layout.preferredHeight: 120
      Layout.alignment: Qt.AlignHCenter
      
      Image {
        id: logo
        anchors.fill: parent
        source: Theme.logoPath
        mipmap: true
        asynchronous: true
        fillMode: Image.PreserveAspectFit
      }
    }

    ColumnLayout {
      spacing: 5
      Layout.alignment: Qt.AlignHCenter

      Text {
        text: "hyprnosis"
        font.family: Theme.fontFamily
        font.pointSize: 24
        font.bold: true
        color: Theme.colAccent
        Layout.alignment: Qt.AlignHCenter
      }

      Text {
        text: "A hyprland offering built with quickshell"
        font.family: Theme.fontFamily
        font.pointSize: 12
        color: Theme.colAccent
        opacity: 0.7
        Layout.alignment: Qt.AlignHCenter
      }
    }

    RowLayout {
      spacing: 15
      Layout.alignment: Qt.AlignHCenter
      Layout.topMargin: 10

      Rectangle {
        width: 140
        height: 40
        radius: 8
        color: ghMa.containsMouse ? Theme.colAccent : Theme.colMuted
        
        Text {
          anchors.centerIn: parent
          text: "󰊤 GitHub"
          color: ghMa.containsMouse ? Theme.colBg : Theme.colAccent
          font.family: Theme.fontFamily
          font.bold: true
        }

        MouseArea {
          id: ghMa
          anchors.fill: parent
          hoverEnabled: true
          onClicked: Qt.openUrlExternally("https://github.com/tyvren/hyprnosis")
        }
      }
    }
  }

  Rectangle {
    Layout.fillWidth: true
    Layout.fillHeight: true
    Layout.topMargin: 10
    color: Theme.colMuted
    opacity: 0.8
    radius: 10

    ColumnLayout {
      anchors.fill: parent
      anchors.margins: 20
      spacing: 8

      RowLayout {
        Text { text: "󰻠 OS "; color: Theme.colAccent; font.family: Theme.fontFamily; font.bold: true; Layout.preferredWidth: 100 }
        Text { text: infoPane.osName; color: Theme.colAccent; font.family: Theme.fontFamily; Layout.fillWidth: true; elide: Text.ElideRight }
      }
      RowLayout {
        Text { text: "󰒋 Kernel "; color: Theme.colAccent; font.family: Theme.fontFamily; font.bold: true; Layout.preferredWidth: 100 }
        Text { text: infoPane.kernel; color: Theme.colAccent; font.family: Theme.fontFamily; Layout.fillWidth: true }
      }
      RowLayout {
        Text { text: "󱎫 Uptime "; color: Theme.colAccent; font.family: Theme.fontFamily; font.bold: true; Layout.preferredWidth: 100 }
        Text { text: infoPane.uptime; color: Theme.colAccent; font.family: Theme.fontFamily; Layout.fillWidth: true }
      }
      RowLayout {
        Text { text: "󰏖 Packages "; color: Theme.colAccent; font.family: Theme.fontFamily; font.bold: true; Layout.preferredWidth: 100 }
        Text { text: infoPane.pkgs; color: Theme.colAccent; font.family: Theme.fontFamily; Layout.fillWidth: true }
      }
      RowLayout {
        Text { text: "󰻠 CPU "; color: Theme.colAccent; font.family: Theme.fontFamily; font.bold: true; Layout.preferredWidth: 100 }
        Text { text: infoPane.cpu; color: Theme.colAccent; font.family: Theme.fontFamily; Layout.fillWidth: true; elide: Text.ElideRight }
      }
      RowLayout {
        Text { text: "󰢮 GPU "; color: Theme.colAccent; font.family: Theme.fontFamily; font.bold: true; Layout.preferredWidth: 100 }
        Text { text: infoPane.gpu; color: Theme.colAccent; font.family: Theme.fontFamily; Layout.fillWidth: true; elide: Text.ElideRight }
      }
      RowLayout {
        Text { text: "󰍛 Memory "; color: Theme.colAccent; font.family: Theme.fontFamily; font.bold: true; Layout.preferredWidth: 100 }
        Text { text: infoPane.mem; color: Theme.colAccent; font.family: Theme.fontFamily; Layout.fillWidth: true }
      }
      
      Repeater {
        model: infoPane.disks
        RowLayout {
          Text { 
            text: "󰋊 " + modelData.label
            color: Theme.colAccent
            font.family: Theme.fontFamily
            font.bold: true
            Layout.preferredWidth: 100 
          }
          Text { 
            text: modelData.total
            color: Theme.colAccent
            font.family: Theme.fontFamily
            Layout.fillWidth: true
          }
        }
      }

      Item { Layout.fillHeight: true }
    }
  }

  Process {
    id: sysFetcher
    command: [
      "sh", "-c", 
      "echo \"KERN:$(uname -r)\"; " +
      "echo \"UPTM:$(uptime -p | sed 's/up //')\"; " +
      "echo \"PKGS:$(pacman -Qq | wc -l) (pacman)\"; " +
      "echo \"CPUS:$(lscpu | grep 'Model name' | cut -d: -f2 | xargs)\"; " +
      "echo \"GPUS:$(lspci | grep -i vga | grep 'Navi 31' | sed 's/.*Navi 31 //; s/\\[//; s/\\/.*//; s/XT.*/XTX/; s/ //g' | sed 's/RadeonRX/Radeon RX /; s/RX7/RX 7/')\"; " +
      "echo \"MEMS:$(free --mebi | awk '/^Mem:/ {printf \"%d GB\", ($2/1024)+0.9}')\"; " +
      "lsblk -JO"
    ]
    running: true
    stdout: StdioCollector {
      onStreamFinished: {
        let lines = text.trim().split('\n')
        let diskResults = []
        let jsonStr = ""
        
        lines.forEach(line => {
          if (line.startsWith("{") || jsonStr.length > 0) {
            jsonStr += line
            return
          }

          let tag = line.substring(0, 5)
          let val = line.substring(5).trim()
          
          switch(tag) {
            case "KERN:": infoPane.kernel = val; break;
            case "UPTM:": infoPane.uptime = val; break;
            case "PKGS:": infoPane.pkgs = val; break;
            case "CPUS:": infoPane.cpu = val; break;
            case "GPUS:": infoPane.gpu = val; break;
            case "MEMS:": infoPane.mem = val; break;
          }
        })

        if (jsonStr) {
          try {
            let data = JSON.parse(jsonStr)
            let processDev = function(dev) {
              if (dev.name && dev.name.startsWith("zram")) return
              if (dev.children) dev.children.forEach(processDev)
              
              if (dev.mountpoints) {
                let mpts = dev.mountpoints.filter(m => m !== null)
                if (mpts.length === 0) return

                let label = ""
                if (mpts.includes("/home")) label = "Home"
                else if (mpts.includes("/")) label = "System"
                else if (mpts.some(m => m.includes("/mnt/games"))) label = "Games"
                else return

                label = label.charAt(0).toUpperCase() + label.slice(1)
                if (!diskResults.find(d => d.label === label)) {
                  diskResults.push({ "label": label, "total": dev.size })
                }
              }
            }
            data.blockdevices.forEach(processDev)
          } catch(e) {}
        }

        infoPane.disks = diskResults.sort((a, b) => {
          const order = { "System": 1, "Home": 2, "Games": 3 }
          return (order[a.label] || 99) - (order[b.label] || 99)
        })
      }
    }
  }
}
