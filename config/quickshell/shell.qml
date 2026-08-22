import Quickshell
import Quickshell.Wayland
import qs.Modules
import qs.Modules.Bar
import qs.Modules.LockScreen
import qs.Modules.Menus
import qs.Modules.Menus.BarMenu
import qs.Modules.Menus.Settings
import qs.Modules.OSD

ShellRoot {
    Bar {}
    BluetoothMenu {}
    NetworkMenu {}
    Launcher {}
    LockContext {
        id: lockContext

        onLockRequested: lock.locked = true
		    onUnlocked: lock.locked = false
    }
    WlSessionLock {
        id: lock
        locked: true

        WlSessionLockSurface {
            LockScreen {
                anchors.fill: parent
                context: lockContext
            }
        }
    }
    Settings {}
    SidePane {}
    Wallpaper {}
}
