import QtQuick
import QtQuick.Layouts
import Quickshell
import qs.services
import qs.widgets.battery

Widget {
    id: root

    icon: {
        if (Battery.isCharging || Battery.fullyCharged) {
            return "";
        } else if (!Battery.isPresent) {
            return "";
        }
        return root.batteryIconLevel(Battery.percentage * 100);
    }
    text: Math.floor(Battery.percentage * 100) + qsTr("%")
    onEntered: batteryTimePopup.visible = true
    onExited: batteryTimePopup.visible = false

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

    RowLayout {
        id: text
        anchors.centerIn: parent

        Text {
            id: iconText
            color: Appearance.palette.color1
        }

        Text {
            id: percentageText
            font.family: Appearance.font.family.main
            color: Appearance.palette.color15
        }
    }

    BatteryTimePopup {
        id: batteryTimePopup

        anchor {
            item: root
            rect.y: root.height
            rect.x: root.width / 2 - width / 2
            margins.top: 4
        }
    }
}
