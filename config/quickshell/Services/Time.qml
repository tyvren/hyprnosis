pragma Singleton

import Quickshell
import QtQuick

Singleton {
  id: root

  readonly property string time: {
    Qt.formatDateTime(clock.date, "ddd\nMMM\nd\n\nhh\nmm\nAP")
  }

  SystemClock {
    id: clock
    precision: SystemClock.Seconds
  }
}
