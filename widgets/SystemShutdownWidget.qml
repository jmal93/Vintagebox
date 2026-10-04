import QtQuick
import qs.services
import qs.widgets.system_shutdown

Item {
    id: root
    implicitWidth: background.implicitWidth
    implicitHeight: background.implicitHeight

    Rectangle {
        id: background
        implicitWidth: text.implicitWidth + 8
        implicitHeight: text.implicitHeight
        color: "transparent"
        anchors.fill: parent

        Behavior on color {
            ColorAnimation {
                duration: 200
            }
        }

        Text {
            id: text
            text: "󰣇"
            font.pixelSize: 20
            color: Appearance.palette.color13
            anchors.centerIn: parent
        }
    }

    SystemShutdownDashboard {
        id: systemShutdownDashboard

        anchor {
            item: root
            rect.x: root.width / 2 - width / 2
            rect.y: root.height
            margins.top: 10
        }
    }

    MouseArea {
        anchors.fill: parent
        hoverEnabled: true
        cursorShape: Qt.PointingHandCursor
        enabled: true
        onClicked: systemShutdownDashboard.visible = !systemShutdownDashboard.visible
    }
}
