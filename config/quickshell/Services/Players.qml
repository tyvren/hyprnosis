pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Services.Mpris
import Quickshell.Io

Singleton {
    id: root
    readonly property list<MprisPlayer> players: Mpris.players.values
    property MprisPlayer manualActive
    readonly property MprisPlayer active:
        manualActive
        ?? Mpris.activePlayer
        ?? players[0]
        ?? null

    function identity(player: MprisPlayer): string {
        return player?.identity ?? ""
    }

    function title(player: MprisPlayer): string {
        return player?.trackTitle ?? ""
    }

    function artist(player: MprisPlayer): string {
        return player?.trackArtist ?? ""
    }

    function length(player: MprisPlayer): real {
        return player?.length ?? 0
    }

    function formatTime(seconds: real): string {
        const m = Math.floor(seconds / 60);
        const s = Math.floor(seconds % 60);
        return `${m}:${s < 10 ? "0" : ""}${s}`;
    }

    FrameAnimation {
        running: root.active && root.active.playbackState == MprisPlaybackState.Playing
        onTriggered: root.active.positionChanged()
    }

    IpcHandler {
        target: "mpris"

        function list(): string {
            return root.players.map(p => p.identity).join("\n");
        }

        function activeProp(prop: string): string {
            const p = root.active;
            return p ? (p[prop] ?? "Invalid property") : "No active player";
        }

        function play(): void {
            if (root.active?.canPlay)
                root.active.play();
        }

        function pause(): void {
            if (root.active?.canPause)
                root.active.pause();
        }

        function playPause(): void {
            if (root.active?.canTogglePlaying)
                root.active.togglePlaying();
        }

        function previous(): void {
            if (root.active?.canGoPrevious)
                root.active.previous();
        }

        function next(): void {
            if (root.active?.canGoNext)
                root.active.next();
        }

        function stop(): void {
            root.active?.stop();
        }
    }
}
