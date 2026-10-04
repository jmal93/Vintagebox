import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell.Networking
import qs.services
import "network_functions.js" as Functions

Rectangle {
    id: root

    required property WifiNetwork network
    property string name: network ? network.name : ""
    property real signalStrength: network ? network.signalStrength : 0
    property bool hasSecurity: network ? network.security !== WifiSecurityType.Open : false
    property bool isKnown: network ? network.known : false
    property bool needPassword: root.hasSecurity && !root.isKnown

    property bool expanded: false
    property bool isConnected: false

    signal toggled

    implicitWidth: content.implicitWidth + border.width * 2
    implicitHeight: content.implicitHeight + border.width * 2

    color: Appearance.palette.color3
    border.color: Appearance.palette.color11

    onExpandedChanged: {
        if (expanded && hasSecurity) {
            Qt.callLater(function () {
                if (expandedArea.visible && passwordField.visible) {
                    passwordField.forceActiveFocus();
                }
            });
        } else if (hasSecurity) {
            passwordField.text = "";
        }
    }

    ColumnLayout {
        id: content
        spacing: 0
        anchors.fill: parent
        anchors.margins: root.border.width

        Rectangle {
            implicitWidth: headerRow.implicitWidth
            implicitHeight: headerRow.implicitHeight
            color: root.color
            Layout.fillWidth: true

            RowLayout {
                id: headerRow

                anchors.fill: parent

                Text {
                    id: networkName
                    text: root.name
                    color: Appearance.palette.foregroundColor
                    font.family: Appearance.font.family.main
                    Layout.alignment: Qt.AlignLeft
                }

                Text {
                    id: networkStrength
                    text: hasSecurity ? Functions.barToWifiSecurity(root.signalStrength) : Functions.barToWifi(root.signalStrength)
                    color: Appearance.palette.foregroundColor
                    font.family: Appearance.font.family.main
                    Layout.alignment: Qt.AlignRight
                }
            }

            MouseArea {
                anchors.fill: parent
                hoverEnabled: true
                cursorShape: Qt.PointingHandCursor
                onClicked: root.toggled()
            }
        }

        FocusScope {
            id: expandedArea

            visible: root.expanded

            Layout.fillWidth: true
            Layout.preferredHeight: root.expanded ? inputColumn.implicitHeight : 0

            Rectangle {
                id: expandedAreaBackground
                color: root.color
                anchors.fill: parent
                anchors.margins: root.border.width

                ColumnLayout {
                    id: inputColumn

                    anchors.fill: parent

                    readonly property bool connecting: root.network && root.network.state === ConnectionState.Connecting

                    ColumnLayout {
                        id: connectionForm

                        visible: !inputColumn.connecting
                        spacing: 5

                        Layout.alignment: Qt.AlignHCenter
                        Layout.topMargin: 5
                        Layout.bottomMargin: 5

                        TextField {
                            id: passwordField

                            visible: root.needPassword

                            placeholderText: "senha"
                            placeholderTextColor: "black"
                            font.family: Appearance.font.family.main

                            echoMode: TextInput.Password
                            passwordCharacter: "*"

                            Layout.alignment: Qt.AlignHCenter
                        }

                        Button {
                            id: connectButton

                            text: "conectar"
                            font.family: Appearance.font.family.main

                            Layout.alignment: Qt.AlignHCenter

                            onClicked: {
                                if (!root.network)
                                    return;

                                if (root.needPassword)
                                    root.network.connectWithPsk(passwordField.text);
                                else
                                    root.network.connect();
                            }
                        }
                    }

                    BusyIndicator {
                        id: connectingIndicator

                        Layout.alignment: Qt.AlignHCenter

                        running: inputColumn.connecting
                        visible: running

                        implicitWidth: 26
                        implicitHeight: 26
                    }
                }
            }
        }
    }
}
