import QtQuick
import QtQuick.Layouts
import Quickshell
import qs.services
import qs.widgets.options

Item {
    id: root

    property var overlayInstance: null
    property bool hovered: false
    property color backgroundColor: Appearance.palette.foregroundColor

    implicitWidth: background.implicitWidth
    implicitHeight: background.implicitHeight

    function audioVolumeIconLevel(): string {
        const level = Audio.volume;

        if (level > 50) {
            return "";
        } else if (level > 0 && level <= 50) {
            return "";
        } else if (level == 0) {
            return "";
        }
    }

    function networkIcon(): string {
        if (NetworkService.isTurnedOn) {
            const signalStrength = NetworkService.connectedNetwork ? NetworkService.connectedNetwork.signalStrength : 0;
            return barToWifi(signalStrength);
        } else {
            return "󰤭";
        }
    }

    function barToWifi(strength) {
        if (strength > 0.8)
            return "󰤨";
        else if (strength <= 0.8 && strength > 0.6)
            return "󰤥";
        else if (strength <= 0.6 && strength > 0.4)
            return "󰤢";
        else if (strength <= 0.4 && strength > 0.2)
            return "󰤟";
        else
            return "󰤫";
    }

    function batteryIcon() {
        if (Battery.isCharging || Battery.fullyCharged) {
            return "";
        } else if (!Battery.isPresent) {
            return "";
        }
        return root.batteryIconLevel(Battery.percentage * 100);
    }

    function batteryIconLevel(): string {
        let level = Battery.percentage * 100;
        if (level > 90) {
            return "󰁹";
        } else if (level > 80 && level <= 90) {
            return "󰂂";
        } else if (level > 70 && level <= 80) {
            return "󰂁";
        } else if (level > 60 && level <= 70) {
            return "󰂀";
        } else if (level > 50 && level <= 60) {
            return "󰁿";
        } else if (level > 40 && level <= 50) {
            return "󰁾";
        } else if (level > 30 && level <= 40) {
            return "󰁽";
        } else if (level > 20 && level <= 30) {
            return "󰁼";
        } else if (level > 10 && level <= 20) {
            return "󰁻";
        } else if (level <= 10) {
            return "󰁺";
        }
    }

    Rectangle {
        id: background

        implicitWidth: row.implicitWidth + 10
        implicitHeight: row.implicitHeight + 5
        color: Qt.rgba(root.backgroundColor.r, root.backgroundColor.g, root.backgroundColor.b, mouseArea.pressed ? 0.3 : (root.hovered ? 0.2 : 0))
        radius: 5

        Behavior on color {
            ColorAnimation {
                duration: 100
            }
        }

        RowLayout {
            id: row

            anchors.centerIn: parent

            Text {
                text: Audio.isMuted ? "" : root.audioVolumeIconLevel()
                font.pixelSize: 14
                color: Appearance.palette.color1
            }

            Text {
                text: root.networkIcon()
                font.pixelSize: 14
                color: Appearance.palette.color1
            }

            RowLayout {
                Text {
                    text: root.batteryIcon()
                    font.pixelSize: 14
                    color: Appearance.palette.color1
                }

                Text {
                    text: Math.floor(Battery.percentage * 100) + qsTr("%")
                    font.family: Appearance.font.family.main
                    color: Appearance.palette.foregroundColor
                }
            }
        }

        OptionsPanel {
            id: optionsPanel

            anchor {
                item: root
                rect.x: root.width - optionsPanel.width + 4
                rect.y: root.height + 10
            }
        }

        MouseArea {
            id: mouseArea
            anchors.fill: parent
            cursorShape: Qt.PointingHandCursor
            hoverEnabled: true
            onEntered: root.hovered = true
            onExited: root.hovered = false
            onClicked: optionsPanel.opened = !optionsPanel.opened
        }
    }
}
