import QtQuick
import QtQuick.Layouts
import Quickshell.Hyprland
import qs.services

Item {
    id: root

    implicitWidth: workspacesContainer.implicitWidth
    implicitHeight: workspacesContainer.implicitHeight

    RowLayout {
        id: workspacesContainer

        Repeater {
            model: Hyprland.workspaces.values.length

            Rectangle {
                id: background
                required property int index

                implicitWidth: text.implicitWidth + 10
                implicitHeight: text.implicitHeight
                color: "transparent"

                Behavior on color {
                    ColorAnimation {
                        duration: 200
                    }
                }

                Text {
                    id: text
                    text: Hyprland.workspaces.values[background.index].name
                    font.pixelSize: 14
                    color: Hyprland.workspaces.values[background.index].active ? Appearance.palette.color10 : Appearance.palette.foregroundColor
                    font.family: Appearance.font.family.main

                    anchors {
                        centerIn: parent
                    }
                }
                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true
                    onClicked: {
                        Hyprland.workspaces.values[background.index].activate();
                    }
                }
            }
        }
    }
}
