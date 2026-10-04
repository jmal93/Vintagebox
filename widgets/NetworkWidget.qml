import QtQuick
import Quickshell
import Quickshell.Hyprland
import qs.services as Services
import qs.widgets.network as NetworkComponents
import "network/network_functions.js" as Functions

Widget {
    id: root

    icon: {
        if (Services.NetworkService.isTurnedOn) {
            const signalStrength = Services.NetworkService.connectedNetwork ? Services.NetworkService.connectedNetwork.signalStrength : 0;
            return Functions.barToWifi(signalStrength);
        } else {
            return "󰤭";
        }
    }

    onClicked: networkPopup.visible = !networkPopup.visible
    onEntered: networkNamePopup.visible = true
    onExited: networkNamePopup.visible = false

    HyprlandFocusGrab {
        id: focusGrab
        active: false
        windows: [networkPopup]
        onCleared: networkPopup.visible = false
    }

    Timer {
        id: focusGrabTimer
        interval: 50
        repeat: false
        onTriggered: focusGrab.active = true
    }

    NetworkComponents.NetworkPopup {
        id: networkPopup
        anchor {
            item: root
            rect.y: root.height
            rect.x: root.width / 2 - width / 2
            margins.top: 4
        }
        onVisibleChanged: {
            if (visible) {
                Services.NetworkService.enableWifiScan();
                focusGrab.active = false;
                focusGrabTimer.restart();
            } else {
                Services.NetworkService.disableWifiScan();
                focusGrabTimer.stop();
                focusGrab.active = false;
            }
        }
    }

    NetworkComponents.NetworkNamePopup {
        id: networkNamePopup
        anchor {
            item: root
            rect.y: root.height
            rect.x: root.width / 2 - width / 2
            margins.top: 4
        }
    }
}
