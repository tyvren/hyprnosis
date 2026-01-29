pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Services.UPower

Singleton {
    id: root

    readonly property bool available: UPower.powerProfilesAvailable ?? false

    property int profile: UPower.powerProfile ?? PowerProfile.Balanced
    readonly property bool hasPerformanceProfile: UPower.hasPerformanceProfile ?? false

    function cycleProfile() {
        if (!available) return;

        if (hasPerformanceProfile) {
                switch(profile) {
                        case PowerProfile.PowerSaver: profile = PowerProfile.Balanced; break;
                        case PowerProfile.Balanced: profile = PowerProfile.Performance; break;
                        case PowerProfile.Performance: profile = PowerProfile.PowerSaver; break;
                }
        } else {
                profile = profile === PowerProfile.Balanced ? PowerProfile.PowerSaver : PowerProfile.Balanced;
        }
    }
}

