import Quickshell
import QtQuick
import qs.widgets
import qs.services
import qs.modules

Scope {
    Variants {
        model: Quickshell.screens

        delegate: PanelWindow {
            id: bar

            property var modelData
            screen: modelData
            aboveWindows: false
            color: "transparent"
            implicitHeight: 35

            property var windowObject: this

            anchors {
                top: true
                left: true
                right: true
            }

            margins {
                top: 5
                left: 5
                right: 5
            }

            Rectangle {
                id: barBackground

                color: Appearance.palette.backgroundColor
                border.color: Appearance.palette.color8
                anchors.fill: parent

                BarLeftSide {}

                Item {
                    id: barCenter
                    anchors.centerIn: parent

                    ClockWidget {
                        anchors.centerIn: parent
                    }
                }

                BarRightSide {}
            }
        }
    }
}
