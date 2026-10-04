import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell
import qs.services

PopupWindow {
    id: root
    color: "transparent"
    implicitWidth: background.implicitWidth
    implicitHeight: background.implicitHeight
    visible: false

    SystemShutdownOverlay {
        id: dimOverlay
    }

    function showWidget() {
        dimOverlay.show();
        background.opacity = 0;
        background.scale = 0.85;
        appearAnimation.restart();
        scaleAnimation.restart();
    }

    function hideWidget() {
        dimOverlay.hide();
    }

    onVisibleChanged: {
        if (visible) {
            root.showWidget();
        } else {
            root.hideWidget();
        }
    }

    Rectangle {
        id: background
        implicitWidth: contentColumn.implicitWidth + 20
        implicitHeight: contentColumn.implicitHeight + 20
        anchors.verticalCenter: parent.verticalCenter
        color: Appearance.palette.backgroundColor
        border.color: Appearance.palette.color8

        NumberAnimation {
            id: appearAnimation
            target: background
            property: "opacity"
            from: 0
            to: 1
            duration: 180
            easing.type: Easing.OutCubic
        }
        NumberAnimation {
            id: scaleAnimation
            target: background
            property: "scale"
            from: 0.85
            to: 1
            duration: 180
            easing.type: Easing.OutCubic
        }

        ColumnLayout {
            id: contentColumn
            anchors.centerIn: parent
            spacing: 7

            Item {
                Layout.fillWidth: true
                implicitHeight: closeButton.implicitHeight

                Button {
                    id: closeButton
                    icon.source: assetsPath + "close.svg"
                    icon.color: Appearance.palette.color3
                    background: Rectangle {
                        color: "transparent"
                    }
                    scale: 0.8
                    anchors.right: parent.right
                    onClicked: root.visible = false
                }
            }

            RowLayout {
                id: iconsRow
                Layout.alignment: Qt.AlignHCenter
                Layout.bottomMargin: 10
                spacing: 50

                SystemShutdownButton {
                    iconSource: assetsPath + "power.svg"
                    command: ["sh", "-c", "systemctl poweroff"]
                    Layout.alignment: Qt.AlignHCenter
                }
                SystemShutdownButton {
                    iconSource: assetsPath + "pause.svg"
                    command: ["sh", "-c", "systemctl suspend & hyprlock -q"]
                    Layout.alignment: Qt.AlignHCenter
                }
                SystemShutdownButton {
                    iconSource: assetsPath + "reboot.svg"
                    command: ["systemctl", "reboot"]
                    Layout.alignment: Qt.AlignHCenter
                }
            }
        }
    }
}
