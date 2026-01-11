pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Services.Pipewire

Singleton {
  id: root

  readonly property PwNode sink: Pipewire.ready ? Pipewire.defaultAudioSink : null
  readonly property PwNode source: Pipewire.ready ? Pipewire.defaultAudioSource : null

  readonly property real sinkVolume: sink?.audio?.volume ?? 0
  readonly property bool sinkMuted: sink?.audio?.muted ?? true
  
  readonly property real sourceVolume: source?.audio?.volume ?? 0
  readonly property bool sourceMuted: source?.audio?.muted ?? true

  readonly property var sinkNodes: {
    if (!Pipewire.ready) return [];
    return Pipewire.nodes.values.filter(node => node.audio && node.isSink && !node.isStream);
  }

  readonly property var sourceNodes: {
    if (!Pipewire.ready) return [];
    return Pipewire.nodes.values.filter(node => node.audio && !node.isSink && !node.isStream);
  }

  PwObjectTracker {
    objects: [
      ...root.sinkNodes,
      ...root.sourceNodes,
      ...(root.sink ? [root.sink] : []),
      ...(root.source ? [root.source] : [])
    ]
  }

  function setSinkVolume(value) {
    if (sink?.audio) sink.audio.volume = value
  }

  function setSourceVolume(value) {
    if (source?.audio) source.audio.volume = value
  }

  function toggleSinkMute() {
    if (sink?.audio) sink.audio.muted = !sink.audio.muted
  }

  function toggleSourceMute() {
    if (source?.audio) source.audio.muted = !source.audio.muted
  }

  function selectSink(node) {
    if (node && node.isSink) {
      Pipewire.preferredDefaultAudioSink = node
    }
  }

  function selectSource(node) {
    if (node && !node.isSink) {
      Pipewire.preferredDefaultAudioSource = node
    }
  }
}
