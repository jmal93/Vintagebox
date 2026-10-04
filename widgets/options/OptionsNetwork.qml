pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import qs.services
import "network_functions.js" as Functions

ColumnLayout {
    id: root

    property string mode: "list"
    property var selectedNetwork: null
    property bool isExpanded: false

    spacing: 0

    Rectangle {
        id: connectedAreaBackground

        color: Appearance.palette.color1
        border.color: Appearance.palette.color9
        radius: 5

        Layout.fillWidth: true
        Layout.preferredHeight: connectedNetworkText.implicitHeight + 2

        RowLayout {
            id: connectedNetworkText

            anchors {
                left: parent.left
                leftMargin: 10
                verticalCenter: parent.verticalCenter
            }

            Text {
                id: networkStrength

                text: {
                    if (!NetworkService.isTurnedOn) {
                        return "󰤭";
                    }
                    const signalStrength = NetworkService.connectedNetwork ? NetworkService.connectedNetwork.signalStrength : 0;
                    return Functions.barToWifi(signalStrength);
                }
                color: Appearance.palette.foregroundColor
                font.pixelSize: 14
                Layout.alignment: Qt.AlignRight
            }

            Text {
                id: wifiText

                text: "Wi-Fi"
                color: Appearance.palette.foregroundColor
                font.pixelSize: 14
                font.family: Appearance.font.family.main
            }
        }

        MouseArea {
            id: mouseArea
            anchors.fill: parent
            hoverEnabled: true
            cursorShape: Qt.PointingHandCursor

            onClicked: {
                root.isExpanded = !root.isExpanded;
                root.mode = "list";
                root.selectedNetwork = null;
            }
        }
    }

    Loader {
        id: contentLoader

        Layout.fillWidth: true
        Layout.preferredHeight: item ? item.implicitHeight : 0

        sourceComponent: root.mode === "detail" ? detailComponent : listComponent
    }

    Component {
        id: listComponent

        NetworkList {}
    }

    Component {
        id: detailComponent

        NetworkConnect {
            id: networkConnect

            property bool connectionAttempted: false

            network: root.selectedNetwork

            onBack: {
                root.mode = "list";
                root.selectedNetwork = null;
            }

            onConnectRequested: password => {
                networkConnect.connectionAttempted = true;
                NetworkService.connectTo(root.selectedNetwork, password);
            }

            onDisconnect: {
                NetworkService.disconnectFrom(root.selectedNetwork);
                root.mode = "list";
                root.selectedNetwork = null;
            }

            Connections {
                target: networkConnect.network
            }
        }
    }
}
