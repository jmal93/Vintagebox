import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell
import qs.services

FloatingWindow {
    id: root

    readonly property var flow: PolkitService.flow

    visible: PolkitService.active && flow !== null;

    function submitAuth() {
        if (!root.flow || !root.flow.isResponseRequired)
            return;

        const response = passwordField.text;
        passwordField.text = "";

        PolkitService.submit(response);
    }

    Rectangle {
        anchors.fill: parent

        color: Appearance.palette.background
    }

    TextField {
        id: passwordField

        placeholderText: "senha"
    }
}
