pragma Singleton

import qs.Services
import QtQuick
import Quickshell

QtObject {
        id: theme
        readonly property string activeId: Config.data.theme
        readonly property var themes: ({
            mocha: {
                colBg: "#1e1e2e",
                colText: "#cdd6f4",
                colSelect: "#2a2a44",
                colHilight: "#cdd6f4",
                colAccent: "#b4befe",
                colMuted: "#404063",
                colTransB: "#80000000",
                fontFamily: "JetBrainsMono Nerd Font",
                fontSize: 14,
                logo: "spiral_mocha.png",
                wall: "mocha.png"
            },
            arcadia: {
                colBg: "#403E44",
                colText: "#f2eff5",
                colHilight: "#AC4262",
                colSelect: "#505154",
                colAccent: "#B3A3AD",
                colMuted: "#67636E",
                colTransB: "#80000000",
                fontFamily: "JetBrainsMono Nerd Font",
                fontSize: 14,
                logo: "spiral_arcadia.png",
                wall: "arcadia.png"
            },
            dracula: {
                colBg: "#282a36",
                colText: "#F8F8F2",
                colHilight: "#50fa7b",
                colSelect: "#44475a",
                colAccent: "#bd93f9",
                colMuted: "#44475a",
                colTransB: "#80000000",
                fontFamily: "JetBrainsMono Nerd Font",
                fontSize: 14,
                logo: "spiral_dracula.png",
                wall: "oni.png"
            },
            eden: {
                colBg: "#D1CDC2",
                colText: "#1a1a1a",
                colHilight: "#feffff",
                colSelect: "#E0DED6",
                colAccent: "#0D0D0D",
                colMuted: "#B9B3A2",
                colTransB: "#80000000",
                fontFamily: "JetBrainsMono Nerd Font",
                fontSize: 14,
                logo: "spiral_eden.png",
                wall: "10_rain.png"
            },
            emberforge: {
                colBg: "#3B3B3B",
                colText: "#fff1eb",
                colHilight: "#626262",
                colSelect: "#626262",
                colAccent: "#FD5001",
                colMuted: "#696969",
                colTransB: "#80000000",
                fontFamily: "JetBrainsMono Nerd Font",
                fontSize: 14,
                logo: "spiral_emberforge.png",
                wall: "emberforge.jpg"
            },
            hyprnosis: {
                colBg: "#0c0c27",
                colText: "#e0def4",
                colHilight: "#517187",
                colSelect: "#214154",
                colAccent: "#01A2FC",
                colMuted: "#444b6a",
                colTransB: "#80000000",
                fontFamily: "JetBrainsMono Nerd Font",
                fontSize: 14,
                logo: "spiral_hyprnosis.png",
                wall: "hyprnosis.jpg"
            }
        })

        readonly property var active: themes[activeId] || themes["hyprnosis"]

        readonly property color colBg: active.colBg
        readonly property color colText: active.colText
        readonly property color colHilight: active.colHilight
        readonly property color colSelect: active.colSelect
        readonly property color colAccent: active.colAccent
        readonly property color colMuted: active.colMuted
        readonly property color colTransB: active.colTransB

        readonly property string fontFamily: active.fontFamily
        readonly property int fontSize: active.fontSize

        readonly property string wallpaperPath: {
            if (Config.data.wallpaper) {
                return "file://" + Config.data.wallpaper
            }
                
            let folder = activeId.charAt(0).toUpperCase() + activeId.slice(1)
            return "file://" + Quickshell.env("HOME") + "/.config/hyprnosis/wallpapers/" + folder + "/" + active.wall
        }

        readonly property url logoPath: Quickshell.env("HOME") + "/.config/hyprnosis/config/quickshell/Assets/" + active.logo
}
