pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Bluetooth
import Quickshell.Io

Singleton {
  id: root

  readonly property BluetoothAdapter adapter: Bluetooth.defaultAdapter
  readonly property bool enabled: adapter ? adapter.enabled : false
  readonly property bool scanning: adapter ? adapter.discovering : false
  
  property var devices: []

  function togglePower() {
    if (adapter) adapter.enabled = !adapter.enabled
  }

  function toggleScan() {
    if (!adapter) return
    adapter.discovering = !adapter.discovering
  }

  function connectDevice(device) {
    if (device.connected) {
      device.disconnect()
    } else {
      device.trusted = true
      device.connect()
    }
  }

  function forgetDevice(device) {
    device.forget()
  }

  function getIcon(device) {
    if (device.connected) return "󰂱"
    return "󰂯"
  }

  function updateDevices() {
    if (!adapter || !adapter.devices) return
    let devList = []
    const values = adapter.devices.values
    for (let key in values) {
      let dev = values[key]
      if (dev && dev.name && dev.name !== "") {
        devList.push(dev)
      }
    }
    root.devices = devList.sort((a, b) => b.connected - a.connected)
  }

  Timer {
    interval: 2000
    running: root.enabled
    repeat: true
    triggeredOnStart: true
    onTriggered: root.updateDevices()
  }
}
