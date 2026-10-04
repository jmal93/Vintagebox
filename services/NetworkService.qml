pragma Singleton

import Quickshell
import Quickshell.Networking
import QtQuick

// import "network_service_functions.js" as Functions

Singleton {
    id: root
    readonly property bool isTurnedOn: Networking.wifiEnabled
    readonly property WifiDevice wifiDevice: {
        const devices = Networking.devices.values;

        for (let i = 0; i < devices.length; i++) {
            if (devices[i].type == DeviceType.Wifi) {
                return devices[i];
            }
        }

        return null;
    }

    readonly property list<Network> networks: {
        if (!root.wifiDevice) {
            return [];
        }

        return getNetworksSorted();
    }

    readonly property Network connectedNetwork: {
        if (!root.wifiDevice)
            return null;

        const networks = root.wifiDevice.networks.values;

        for (let i = 0; i < networks.length; i++) {
            if (networks[i].connected)
                return networks[i];
        }

        return null;
    }

    function enableWifiScan() {
        if (root.wifiDevice)
            root.wifiDevice.scannerEnabled = true;
    }

    function disableWifiScan() {
        if (root.wifiDevice)
            root.wifiDevice.scannerEnabled = false;
    }

    function getNetworksSorted() {
        if (!root.wifiDevice)
            return [];

        const all = [...root.wifiDevice.networks.values];
        const others = all.filter(n => n !== connectedNetwork).sort((a, b) => b.signalStrength - a.signalStrength);

        if (connectedNetwork) {
            others.unshift(connectedNetwork);
        }

        return others;
    }

    function connectTo(network, password) {
        if (!network || !root.WifiDevice)
            return;

        if (network.security == WifiSecurityType.Open) {
            network.connect();
            return;
        }

        network.connectWithPsk(password);
    }

    function disconnectFrom(network) {
        if (network)
            network.disconnect();
    }
}
