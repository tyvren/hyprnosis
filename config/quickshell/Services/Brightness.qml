pragma Singleton
import QtQuick
import Quickshell
import Quickshell.Io

QtObject {
    id: root

    property real brightness: 0
    property string device: ""

    function setBrightness(value) {
        if (device === "") return
        const percent = Math.floor(Math.max(0, Math.min(1, value)) * 100)
        Quickshell.execDetached(["brightnessctl", "-d", device, "s", percent + "%"])
        brightness = value
    }

    function initBrightness() {
        initProc.command = ["sh", "-c", `echo a b c $(brightnessctl -d '${root.device}' g) $(brightnessctl -d '${root.device}' m)`]
        initProc.running = true
    }

    onDeviceChanged: {
        if (device !== "") initBrightness()
    }

    readonly property Process detectProc: Process {
        running: true
        command: ["sh", "-c", "brightnessctl -l -c backlight | awk '/Max brightness:/ {print max, dev} {if (/Device/) dev=$2; if (/Max/) max=$NF}' | sort -rn | head -1 | awk '{print $2}' | tr -d \"'\""]
        stdout: StdioCollector {
            onStreamFinished: {
                const name = text.trim()
                if (name !== "") root.device = name
            }
        }
    }

    readonly property Process initProc: Process {
        running: false
        stdout: StdioCollector {
            onStreamFinished: {
                const [, , , cur, max] = text.trim().split(" ")
                const c = parseInt(cur)
                const m = parseInt(max)
                if (m > 0) root.brightness = c / m
            }
        }
    }
}
