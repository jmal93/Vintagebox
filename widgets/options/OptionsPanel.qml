import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Hyprland
import qs.services

PopupWindow {
    id: root

    implicitWidth: background.implicitWidth
    implicitHeight: background.implicitHeight
    color: "transparent"

    property bool opened: false
    visible: opened

    onVisibleChanged: {
        if (visible) {
            NetworkService.enableWifiScan();
        } else {
            NetworkService.disableWifiScan();
        }
    }

    Rectangle {
        id: background

        implicitWidth: content.implicitWidth + 10
        implicitHeight: content.implicitHeight + 10
        color: Appearance.palette.backgroundColor
        border.color: Appearance.palette.color8
        anchors.fill: parent

        ColumnLayout {
            id: content
            anchors.centerIn: parent

            OptionsAudio {
                Layout.fillWidth: true
            }

            OptionsNetwork {
                Layout.fillWidth: true
            }
        }
    }

    HyprlandFocusGrab {
        id: focusGrab

        windows: [root]
        active: root.opened
    }
}
