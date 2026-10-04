pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Io

Singleton {
    id: root

    readonly property string walPath: "/home/jota/.cache/wal/colors.json"
    readonly property var wal: {
        try {
            const txt = walFile.text();
            return txt ? JSON.parse(txt) : ({});
        } catch (e) {
            console.log("erro lendo pywal: ", e);
            return ({});
        }
    }

    FileView {
        id: walFile
        path: root.walPath
        blockLoading: true
        watchChanges: true

        onFileChanged: reload()
    }

    readonly property var special: wal.special ?? ({})
    readonly property var colors: wal.colors ?? ({})

    readonly property QtObject palette: QtObject {
        readonly property color foregroundColor: root.special.foreground
        readonly property color backgroundColor: root.special.background
        readonly property color cursorColor: root.special.cursor

        readonly property color color0: root.colors.color0
        readonly property color color1: root.colors.color1
        readonly property color color2: root.colors.color2
        readonly property color color3: root.colors.color3
        readonly property color color4: root.colors.color4
        readonly property color color5: root.colors.color5
        readonly property color color6: root.colors.color6
        readonly property color color7: root.colors.color7
        readonly property color color8: root.colors.color8
        readonly property color color9: root.colors.color9
        readonly property color color10: root.colors.color10
        readonly property color color11: root.colors.color11
        readonly property color color12: root.colors.color12
        readonly property color color13: root.colors.color13
        readonly property color color14: root.colors.color14
        readonly property color color15: root.colors.color15
    }

    readonly property QtObject font: QtObject {
        property QtObject family: QtObject {
            property string main: "Jetbrains Mono Nerd Font"
        }
    }
}
