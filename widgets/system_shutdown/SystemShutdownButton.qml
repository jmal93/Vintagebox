import QtQuick
import Qt5Compat.GraphicalEffects
import Quickshell.Io
import qs.services

Item {
    id: root

    implicitWidth: background.implicitWidth
    implicitHeight: background.implicitHeight

    property url iconSource: ""
    property color iconColor: Appearance.palette.color11
    property real iconSize: 32
    property var command: []
    property bool pressed: false
    property bool hovered: false

    Process {
        id: process
    }

    Rectangle {
        id: background
        implicitWidth: icon.implicitWidth + 10
        implicitHeight: icon.implicitHeight + 10
        color: Qt.rgba(root.iconColor.r, root.iconColor.g, root.iconColor.b, root.pressed ? 0.5 : root.hovered ? 0.3 : 0.2)
        border.color: Qt.rgba(root.iconColor.r, root.iconColor.g, root.iconColor.b, 0.8)
        anchors.fill: parent
    }

    Image {
        id: icon
        source: root.iconSource
        sourceSize.height: root.iconSize
        sourceSize.width: root.iconSize
        anchors.centerIn: background

        layer.enabled: true
        layer.effect: ColorOverlay {
            color: root.iconColor
        }
    }

    MouseArea {
        id: mouse
        anchors.fill: background
        cursorShape: Qt.PointingHandCursor
        hoverEnabled: true
        onEntered: root.hovered = true
        onExited: {
            root.hovered = false;
            root.pressed = false;
        }
        onPressed: root.pressed = true
        onReleased: root.pressed = false
        onClicked: {
            if (root.command && root.command.length > 0) {
                process.exec(root.command);
            }
        }
    }
}
