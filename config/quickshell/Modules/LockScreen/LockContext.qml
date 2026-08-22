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
        if (currentText === "" || unlockInProgress) return

        root.unlockInProgress = true
        pam.start()
    }

    IpcHandler {
        target: "lockscreen"

        function lock(): void {
            root.lockRequested()
        }
    }

    PamContext {
        id: pam

        configDirectory: "."
        config: "authentication.conf"

        onPamMessage: {
            if (this.responseRequired) {
                this.respond(root.currentText);
            }
        }

        onCompleted: result => {
            if (result == PamResult.Success) {
                root.unlocked();
            } else {
                root.currentText = "";
                root.showFailure = true;
            }

            root.unlockInProgress = false;
        }
    }
}
