pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import qs.services

ScrollView {
    id: listScroll

    implicitWidth: listOfNetworks.implicitWidth
    implicitHeight: Math.min(listOfNetworks.implicitHeight, 300)

    ColumnLayout {
        id: listOfNetworks

        property real maxWidth: 0
        property var expandedNetwork: null

        anchors.centerIn: parent

        Repeater {
            model: NetworkService.networks

            Network {
                required property var modelData

                network: modelData

                expanded: listOfNetworks.expandedNetwork === this
                onToggled: {
                    if (listOfNetworks.expandedNetwork === this) {
                        listOfNetworks.expandedNetwork = null;
                    } else {
                        listOfNetworks.expandedNetwork = this;
                    }
                }

                Layout.preferredWidth: listOfNetworks.maxWidth

                Component.onCompleted: {
                    listOfNetworks.maxWidth = Math.max(listOfNetworks.maxWidth, implicitWidth);
                }
            }
        }
    }
}
