import QtQuick
import Quickshell
import Quickshell.Io
import Quickshell.Services.Pam

Scope {
    id: root

    signal lockRequested()
    signal unlocked()
    signal failed()

    property string currentText: ""
    property bool isLocked: false
    property bool unlockInProgress: false
    property bool showFailure: false

    onCurrentTextChanged: showFailure = false

    function tryUnlock() {
        if (currentText === "") return
        
        fingerprintPam.abort()
        root.unlockInProgress = true
        root.showFailure = false
        passwordPam.start()
    }

    function tryFingerprintUnlock() {
        passwordPam.abort()
        root.unlockInProgress = true
        root.showFailure = false
        fingerprintPam.start()
    }

    function reset() {
        currentText = ""
        unlockInProgress = false
        showFailure = false
        passwordPam.abort()
        fingerprintPam.abort()
    }

    IpcHandler {
        target: "lockscreen"

        function lock(): void {
            root.lockRequested()
        }

        function unlock(): void {
            root.reset()
            root.unlocked()
        }
    }

    PamContext {
        id: passwordPam

        configDirectory: "."
        config: "passwordauth.conf"

        onPamMessage: {
            if (this.responseRequired) {
                this.respond(root.currentText)
            }
        }

        onCompleted: result => {
            root.unlockInProgress = false
            if (result === PamResult.Success) {
                root.currentText = ""
                root.unlocked()
            } else {
                root.currentText = ""
                root.showFailure = true
                root.failed()
            }
        }
    }

    PamContext {
        id: fingerprintPam

        configDirectory: "."
        config: "fingerprintauth.conf"

        onPamMessage: {
            if (this.responseRequired) {
                this.respond("")
            }
        }

        onCompleted: result => {
            root.unlockInProgress = false
            if (result === PamResult.Success) {
                root.currentText = ""
                root.unlocked()
            } else {
                root.showFailure = true
                root.failed()
            }
        }
    }
}
