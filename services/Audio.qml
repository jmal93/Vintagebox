pragma Singleton

import Quickshell
import Quickshell.Services.Pipewire
import QtQuick

Singleton {
    id: root

    readonly property PwNode sink: Pipewire.defaultAudioSink
    readonly property PwNode source: Pipewire.defaultAudioSource

    readonly property bool isMuted: sink ? sink.audio.muted : false
    readonly property real volume: sink ? Math.floor(sink.audio.volume * 100) : 0

    function changeVolume(newVolume: real): void {
        sink.audio.volume = newVolume;
    }

    PwObjectTracker {
        objects: [root.sink, root.source]
    }
}
