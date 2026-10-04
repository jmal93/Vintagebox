import QtQuick
import QtQuick.Layouts
import Quickshell
import qs.services
import "network_functions.js" as Functions

PopupWindow {
    id: root
    visible: false
    implicitWidth: column.implicitWidth + 10
    implicitHeight: column.implicitHeight + 10

    Rectangle {
        id: popUpBackground

        color: Appearance.palette.backgroundColor
        border.color: Appearance.palette.color8
        anchors.fill: parent
    }

    Rectangle {
        id: padding

        implicitWidth: column.implicitWidth
        implicitHeight: column.implicitHeight
        anchors.centerIn: parent
        color: "transparent"

        ColumnLayout {
            id: column

            anchors.centerIn: parent

            RowLayout {
                id: connectedNetworkRow

                Layout.alignment: Qt.AlignCenter

                Text {
                    id: connectedNetworkText
                    text: NetworkService.connectedNetwork ? NetworkService.connectedNetwork.name : "Desconectado"
                    color: Appearance.palette.foregroundColor
                    font.family: Appearance.font.family.main
                    font.pixelSize: 14
                }

                Text {
                    id: connectedNetworkStrength
                    text: {
                        const signalStrength = NetworkService.connectedNetwork ? NetworkService.connectedNetwork.signalStrength : 0;
                        Functions.barToWifi(signalStrength);
                    }
                    color: Appearance.palette.foregroundColor
                    font.family: Appearance.font.family.main
                    font.pixelSize: 14
                }
            }

            Rectangle {
                implicitWidth: Math.max(networkList.implicitWidth, connectedNetworkRow.implicitWidth)
                implicitHeight: networkList.implicitHeight
                color: "transparent"

                NetworkList {
                    id: networkList
                    anchors.centerIn: parent
                }
            }
        }
    }
}
