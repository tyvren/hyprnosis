pragma Singleton

import Quickshell
import Quickshell.Services.UPower
import QtQuick

Singleton {
  id: root

  readonly property real percentage: UPower.displayDevice?.percentage ?? 0

  readonly property bool isCharging: UPower.displayDevice?.state === UPowerDeviceState.Charging
  readonly property bool isPluggedIn: isCharging || UPower.displayDevice?.state === UPowerDeviceState.PendingCharge
  readonly property bool available: UPower.displayDevice?.isLaptopBattery ?? false
}

