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

    property bool isConnected: {
        if (!network || !network.state) {
            return false;
        }
        return network.state === ConnectionState.Connected;
    }
    property bool hovered: false
    property color backgroundColor: Appearance.palette.color1

    signal toggled

    implicitWidth: content.implicitWidth + 20
    implicitHeight: content.implicitHeight + border.width * 2

    color: Qt.rgba(backgroundColor.r, backgroundColor.g, backgroundColor.b, isConnected ? 1 : (hovered ? 0.2 : 0))
    border.color: Appearance.palette.color9
    border.width: 1
    radius: 5

    Behavior on color {
        ColorAnimation {
            duration: 100
        }
    }

    RowLayout {
        id: content

        anchors {
            left: parent.left
            right: parent.right
            verticalCenter: parent.verticalCenter
        }

        Text {
            id: networkStrength

            text: hasSecurity ? Functions.barToWifiSecurity(root.signalStrength) : Functions.barToWifi(root.signalStrength)
            color: Appearance.palette.foregroundColor
            font.family: Appearance.font.family.main
            Layout.leftMargin: 10
        }

        Text {
            id: networkName

            text: root.name
            color: Appearance.palette.foregroundColor
            font.family: Appearance.font.family.main
            Layout.fillWidth: true
            Layout.preferredWidth: implicitWidth
            Layout.minimumWidth: 0
            elide: Text.ElideRight
        }

        Text {
            id: connectedText

            text: qsTr("conectado")
            color: Appearance.palette.foregroundColor
            font.family: Appearance.font.family.main
            font.pixelSize: 10
            Layout.alignment: Qt.AlignRight
            Layout.rightMargin: 10
            visible: root.isConnected
        }
    }

    MouseArea {
        id: mouseArea

        anchors.fill: parent
        hoverEnabled: true
        cursorShape: Qt.PointingHandCursor
        onEntered: root.hovered = true
        onExited: root.hovered = false
        onClicked: root.toggled()
    }
}
