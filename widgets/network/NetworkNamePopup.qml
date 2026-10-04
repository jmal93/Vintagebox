import QtQuick
import Quickshell
import qs.services as Services

PopupWindow {
    id: root
    visible: false
    implicitWidth: networkName.implicitWidth + 10
    implicitHeight: networkName.implicitHeight + 10

    function popUpText() {
        if (!Services.NetworkService.isTurnedOn) {
            return "Wifi desligado";
        }

        if (!Services.NetworkService.connectedNetwork) {
            return "Desconectado";
        }

        return Services.NetworkService.connectedNetwork.name;
    }

    Rectangle {
        color: Services.Appearance.palette.backgroundColor
        border.color: Services.Appearance.palette.color8
        anchors.fill: parent
    }

    Text {
        id: networkName
        text: root.popUpText()
        color: Services.Appearance.palette.foregroundColor
        font.family: Services.Appearance.font.family.main

        anchors {
            horizontalCenter: parent.horizontalCenter
            verticalCenter: parent.verticalCenter
        }
    }
}
