import QtQuick
import Quickshell
import qs.services

PopupWindow {
    id: root

    visible: false
    implicitWidth: batteryTimeText.implicitWidth + 10
    implicitHeight: batteryTimeText.implicitHeight + 10

    function secondsToHourMinutes(seconds: real): string {
        const hours = Math.floor(seconds / 3600);
        const minutes = Math.floor((seconds % 3600) / 60);

        return hours > 0 ? `${hours}h ${minutes}m` : `${minutes}m`;
    }

    Rectangle {
        color: Appearance.palette.backgroundColor
        border.color: Appearance.palette.color8
        anchors.fill: parent
    }

    Text {
        id: batteryTimeText
        color: Appearance.palette.foregroundColor
        font.family: Appearance.font.family.main
        text: {
            if (Battery.fullyCharged) {
                return "Carga cheia";
            }
            if (Battery.isDischarging) {
                const text = "Tempo restante: " + root.secondsToHourMinutes(Battery.timeToEmpty);
                return text;
            } else if (Battery.isCharging) {
                const text = "Tempo para carga: " + root.secondsToHourMinutes(Battery.timeToFull);
                return text;
            }

            return "Erro ao determinar tempo";
        }

        anchors {
            horizontalCenter: parent.horizontalCenter
            verticalCenter: parent.verticalCenter
        }
    }
}
