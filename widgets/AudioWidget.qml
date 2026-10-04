import QtQuick
import Quickshell
import qs.services
import qs.widgets.audio

Widget {
    id: root

    readonly property real volume: Audio.volume
    property var overlayInstance: null

    icon: Audio.isMuted ? "" : root.audioVolumeIconLevel(root.volume)
    text: root.volume + "%"
    onClicked: sliderPopup.visible = !sliderPopup.visible

    function audioVolumeIconLevel(level: real): string {
        if (level > 50) {
            return "";
        } else if (level > 0 && level <= 50) {
            return "";
        } else if (level == 0) {
            return "";
        }
    }

    AudioPopup {
        id: sliderPopup

        anchor {
            item: root
            rect.x: root.width / 2 - width / 2
            rect.y: root.height
            margins.top: 4
        }
    }
}
