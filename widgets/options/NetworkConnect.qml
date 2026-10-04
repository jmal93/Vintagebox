import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell.Networking
import qs.services

ColumnLayout {
    id: root

    required property var network

    signal back
    signal connectRequested(string password)
    signal disconnect

    readonly property bool requiresPassword: network && network.security !== WifiSecurityType.Open
    readonly property bool isConnected: root.network && root.network.state === ConnectionState.Connected
    readonly property bool isConnecting: root.network && root.network.state === ConnectionState.Connecting

    state: {
        if (isConnected)
            return "disconnect";
        else if (isConnecting)
            return "connecting";
        else
            return "connect";
    }

    spacing: 0

    implicitWidth: 220

    RowLayout {
        id: header

        Layout.fillWidth: true
        Layout.margins: 6

        Text {
            text: "󰌍"
            color: Appearance.palette.foregroundColor
            font.pixelSize: 14

            MouseArea {
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
                onClicked: root.back()
            }
        }

        Text {
            text: root.network ? root.network.name : ""
            color: Appearance.palette.foregroundColor
            font.family: Appearance.font.family.main

            Layout.fillWidth: true
            Layout.minimumWidth: 0
            elide: Text.ElideRight
        }
    }

    ColumnLayout {
        id: body

        Layout.fillWidth: true

        TextField {
            id: passwordField

            Layout.fillWidth: true
            placeholderText: "Senha"
            echoMode: TextInput.Password
            passwordCharacter: "*"
            color: Appearance.palette.foregroundColor

            Component.onCompleted: if (visible)
                forceActiveFocus()
            onAccepted: if (connectButton.enabled)
                connectButton.clicked()
        }

        Button {
            id: connectButton

            Layout.fillWidth: true
            text: "Conectar"
            enabled: !root.requiresPassword || passwordField.text.length > 0
            onClicked: root.connectRequested(root.requiresPassword ? passwordField.text : "")
        }

        Button {
            id: disconnectButton

            Layout.fillWidth: true
            text: "Desconectar"
            onClicked: root.disconnect()
        }

        BusyIndicator {
            id: connectingIndicator

            running: true
            Layout.fillWidth: true
        }
    }

    states: [
        State {
            name: "connect"
            PropertyChanges {
                passwordField.visible: true
                connectButton.visible: true
                disconnectButton.visible: false
                connectingIndicator.visible: false
            }
        },
        State {
            name: "disconnect"
            PropertyChanges {
                passwordField.visible: false
                connectButton.visible: false
                disconnectButton.visible: true
                connectingIndicator.visible: false
            }
        },
        State {
            name: "connecting"
            PropertyChanges {
                passwordField.visible: false
                connectButton.visible: false
                disconnectButton.visible: false
                connectingIndicator.visible: true
            }
        }
    ]
}
