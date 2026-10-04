pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Services.Polkit

Singleton {
    id: root

    readonly property AuthFlow flow: agent.flow
    readonly property bool active: agent.isActive
    readonly property bool registered: agent.isRegistered

    signal authenticationStarted
    signal authenticationFinished

    function submit(response) {
        if (!root.flow)
            return;

        root.flow.submit(response);
    }

    function cancel() {
        if (root.flow)
            root.flow.cancelAuthenticationRequest();
    }

    PolkitAgent {
        id: agent

        onIsActiveChanged: {
            if (isActive)
                root.authenticationStarted();
            else
                root.authenticationFinished();
        }
    }
}
