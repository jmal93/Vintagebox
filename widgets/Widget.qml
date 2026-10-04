import QtQuick
import QtQuick.Layouts
import qs.services

Item {
    id: root

    property string icon: ""
    property string text: ""
    property color iconColor: Appearance.palette.color1
    property color textColor: Appearance.palette.foregroundColor

    signal clicked
    signal entered
    signal exited

    implicitWidth: background.implicitWidth
    implicitHeight: background.implicitHeight

    Rectangle {
        id: background

        implicitWidth: row.implicitWidth + 5
        implicitHeight: row.implicitHeight + 5
        color: "transparent"

        RowLayout {
            id: row
            anchors.centerIn: parent

            Text {
                text: root.icon
                font.pixelSize: 14
                color: root.iconColor
                Layout.alignment: Qt.AlignLeft | Qt.AlignHCenter
            }

            Text {
                text: root.text
                visible: root.text !== ""
                color: root.textColor
                font.family: Appearance.font.family.main
                Layout.alignment: Qt.AlignRight | Qt.AlignHCenter
            }
        }
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true
        cursorShape: Qt.PointingHandCursor
        onClicked: root.clicked()
        onEntered: root.entered()
        onExited: root.exited()
    }
}
