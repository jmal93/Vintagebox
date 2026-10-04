import QtQuick
import Quickshell
import Quickshell.Wayland

QtObject {
    id: root

    function show() {
        overlayWindow.visible = true
        dimRect.opacity = 0
        fadeIn.restart()
    }

    function hide() {
        fadeOut.restart()
    }

    property var _window: PanelWindow {
        id: overlayWindow
        visible: false
        color: "transparent"

        WlrLayershell.layer: WlrLayer.Overlay
        WlrLayershell.exclusionMode: ExclusionMode.Ignore

        anchors {
            top: true
            bottom: true
            left: true
            right: true
        }

        Rectangle {
            id: dimRect
            anchors.fill: parent
            color: "black"
            opacity: 0

            NumberAnimation {
                id: fadeIn
                target: dimRect
                property: "opacity"
                from: 0
                to: 0.5
                duration: 180
                easing.type: Easing.OutCubic
            }

            NumberAnimation {
                id: fadeOut
                target: dimRect
                property: "opacity"
                from: 0.5
                to: 0
                duration: 180
                easing.type: Easing.OutCubic
                onFinished: overlayWindow.visible = false
            }
        }
    }
}
