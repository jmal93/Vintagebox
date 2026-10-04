import QtQuick
import Quickshell.Hyprland
import qs.services
import qs.widgets.updates

Widget {
    id: root

    icon: UpdatesService.isThereUpdates ? "󰚰" : ""
    text: UpdatesService.isThereUpdates ? UpdatesService.numberOfUpdates : ""
    onClicked: listOfUpdates.visible = !listOfUpdates.visible

    HyprlandFocusGrab {
        active: listOfUpdates.visible
        windows: [listOfUpdates]
        onCleared: listOfUpdates.visible = false
    }

    UpdatesPopup {
        id: listOfUpdates

        anchor {
            item: root
            rect.y: root.height
            rect.x: root.width / 2 - width / 2
            margins.top: 4
        }
    }
}
