import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell
import qs.services

PopupWindow {
    implicitWidth: sliderRow.width + 10
    implicitHeight: 30

    Rectangle {
        anchors.fill: parent
        color: Appearance.palette.backgroundColor
        border.color: Appearance.palette.color8
    }

    RowLayout {
        id: sliderRow
        anchors.centerIn: parent

        Text {
            color: Appearance.palette.foregroundColor
            font.family: Appearance.font.family.main
            text: qsTr(" 0 ")
        }

        Slider {
            id: slider
            from: 0
            to: 100
            value: Audio.volume
            stepSize: 1
            snapMode: Slider.SnapAlways
            onMoved: Audio.changeVolume(value / 100)

            background: Rectangle {
                x: slider.leftPadding
                y: slider.topPadding + slider.availableHeight / 2 - height / 2
                implicitWidth: 130
                implicitHeight: 4
                width: slider.availableWidth
                height: implicitHeight
                radius: 10
                color: "white"

                Rectangle {
                    width: slider.visualPosition * parent.width
                    height: parent.height
                    radius: 10
                    color: "grey"
                }
            }
        }

        Text {
            color: Appearance.palette.foregroundColor
            font.family: Appearance.font.family.main
            text: qsTr("100")
        }
    }
}
