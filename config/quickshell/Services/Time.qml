pragma Singleton

import Quickshell
import QtQuick

Singleton {
    id: root

    readonly property string vertical: {
        Qt.formatDateTime(clock.date, "hh\nmm\nAP")
      }

    readonly property string horizontal: {
        Qt.formatDateTime(clock.date, "hh:mm AP")
    }

    SystemClock {
        id: clock
        precision: SystemClock.Seconds
    }
}
