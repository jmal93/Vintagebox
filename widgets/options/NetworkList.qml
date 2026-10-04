import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import qs.services

ScrollView {
    id: listScroll

    readonly property int visibleNetworksCount: 6
    readonly property real sampleItemHeight: repeater.count > 0 ? repeater.itemAt(0).implicitHeight : 0
    readonly property real minVisibleHeight: repeater.count > 0 ? (sampleItemHeight * Math.min(repeater.count, visibleNetworksCount)) + listOfNetworks.spacing * (Math.min(repeater.count, visibleNetworksCount) - 1) + topPadding : 0

    implicitWidth: contentLoader.implicitWidth
    implicitHeight: root.isExpanded ? Math.min(listOfNetworks.implicitHeight + topPadding, minVisibleHeight) : 0
    clip: true
    topPadding: 10

    function toggle() {
        root.isExpanded = !root.isExpanded;
    }

    ColumnLayout {
        id: listOfNetworks

        width: listScroll.availableWidth

        Repeater {
            id: repeater

            model: NetworkService.networks

            Network {
                required property var modelData
                required property int index

                network: modelData
                implicitWidth: connectedAreaBackground.width - 10
                Layout.fillWidth: true
                Layout.leftMargin: 5
                Layout.rightMargin: 5

                onToggled: {
                    root.selectedNetwork = modelData;
                    root.mode = "detail";
                }
            }
        }
    }
}
