import QtQuick
import Quickshell.Hyprland
import qs.services

Item {
    id: root

    Text {
        text: {
            const monitor = Hyprland.monitorFor(bar.screen);
            const workspaces = monitor ? monitor.activeWorkspace : null;
            const window = Hyprland.activeToplevel;

            if (!window || !workspaces)
                return ":)";

            if (!window.workspace || window.workspace.id !== workspaces.id)
                return ":)";

            return window.title || ":)";
        }
        font.pixelSize: 14
        font.family: Appearance.font.family.main
        color: Appearance.palette.foregroundColor
        anchors.centerIn: parent
    }
}
