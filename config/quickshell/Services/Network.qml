pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Io

Singleton {
  id: root

  property var networks: ({})
  property bool scanning: false
  property bool connecting: false
  property bool wifiEnabled: false
  property bool ethernetConnected: false
  property string ethernetInterface: ""
  property string errorMessage: ""

  function isConnected(ssid) {
    const net = networks[ssid]
    return net ? net.connected : false
  }

  function setWifiEnabled(enabled) {
    wifiToggleProcess.enabledState = enabled ? "on" : "off"
    wifiToggleProcess.running = true
  }

  function scan() {
    if (scanning) return
    scanning = true
    scanProcess.running = true
    ethProcess.running = true
  }

  function connect(ssid, password = "") {
    root.errorMessage = ""
    root.connecting = true
    failedTimer.stop()
    connectProcess.targetSsid = ssid
    connectProcess.password = password
    connectProcess.running = true
  }

  function forget(ssid) {
    forgetProcess.targetSsid = ssid
    forgetProcess.running = true
  }

  function signalIcon(signal) {
    if (signal >= 80) return "󰤨"
    if (signal >= 60) return "󰤥"
    if (signal >= 40) return "󰤢"
    if (signal >= 20) return "󰤟"
    return "󰤯"
  }

  Timer {
    id: failedTimer
    interval: 5000
    repeat: false
    onTriggered: {
      if (!root.isConnected(connectProcess.targetSsid)) {
        root.errorMessage = "Connection Failed"
      }
    }
  }

  Process {
    id: ethProcess
    command: ["nmcli", "-t", "-f", "DEVICE,TYPE,STATE", "dev"]
    stdout: StdioCollector {
      onStreamFinished: {
        const lines = text.split("\n")
        let foundEth = false
        for (let line of lines) {
          const parts = line.split(":")
          if (parts[1] === "ethernet" && parts[2] === "connected") {
            root.ethernetInterface = parts[0]
            foundEth = true
            break
          }
        }
        root.ethernetConnected = foundEth
      }
    }
  }

  Process {
    id: wifiStateProcess
    running: true
    command: ["nmcli", "radio", "wifi"]
    stdout: StdioCollector {
      onStreamFinished: root.wifiEnabled = text.trim() === "enabled"
    }
  }

  Process {
    id: wifiToggleProcess
    property string enabledState: "on"
    command: ["nmcli", "radio", "wifi", enabledState]
    onExited: {
      root.wifiEnabled = (enabledState === "on")
      root.scan()
    }
  }

  Process {
    id: scanProcess
    command: ["nmcli", "-t", "-f", "SSID,SIGNAL,IN-USE,SECURITY", "dev", "wifi"]
    stdout: StdioCollector {
      onStreamFinished: {
        const lines = text.split("\n")
        let map = {}
        for (let line of lines) {
          const parts = line.split(":")
          if (parts.length >= 3 && parts[0] !== "") {
            const ssid = parts[0]
            map[ssid] = {
              ssid: ssid,
              signal: parseInt(parts[1]),
              connected: parts[2] === "*",
              secured: parts[3] !== "" && parts[3] !== "--"
            }
          }
        }
        root.networks = map
        root.scanning = false
      }
    }
  }

  Process {
    id: connectProcess
    property string targetSsid: ""
    property string password: ""
    command: password !== "" 
      ? ["nmcli", "device", "wifi", "connect", targetSsid, "password", password]
      : ["nmcli", "device", "wifi", "connect", targetSsid]
    stderr: StdioCollector {
      onStreamFinished: {
        if (text.includes("Error") || text.includes("failed")) {
          failedTimer.start()
        }
      }
    }
    onExited: {
      root.connecting = false
      root.scan()
    }
  }

  Process {
    id: forgetProcess
    property string targetSsid: ""
    command: ["nmcli", "connection", "delete", targetSsid]
    onExited: root.scan()
  }

  Timer {
    interval: 10000
    running: true
    repeat: true
    triggeredOnStart: true
    onTriggered: root.scan()
  }
}
