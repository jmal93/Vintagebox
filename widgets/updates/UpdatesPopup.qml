import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell
import qs.services

PopupWindow {
    id: listOfUpdates
    visible: false
    implicitWidth: column.implicitWidth + 20
    implicitHeight: column.implicitHeight + 10


    Rectangle {
        id: popUpBackground
        color: Appearance.palette.backgroundColor
        border.color: Appearance.palette.color8
        anchors.fill: parent
    }

    ColumnLayout {
        id: column

        anchors {
            centerIn: parent
        }

        Rectangle {
            id: listScrollBackground
            color: "transparent"
            border.color: Appearance.palette.color1
            implicitWidth: listScroll.implicitWidth + 5
            implicitHeight: listScroll.implicitHeight + 10

            ScrollView {
                id: listScroll
                implicitWidth: listOfUpdatesText.implicitWidth
                implicitHeight: {
                    if (listOfUpdatesText.implicitHeight >= 300) {
                        return 300;
                    }

                    return listOfUpdatesText.implicitHeight;
                }

                anchors {
                    centerIn: parent
                }

                Label {
                    id: listOfUpdatesText
                    text: {
                        if (!UpdatesService.isThereUpdates) {
                            return "Tudo atualizado :)";
                        }

                        return UpdatesService.listOfUpdates;
                    }
                    color: Appearance.palette.foregroundColor
                    font.family: Appearance.font.family.main
                }
            }
        }

        Rectangle {
            id: updateButton
            implicitWidth: updateButtonText.implicitWidth + 8
            implicitHeight: updateButtonText.implicitHeight
            Layout.alignment: Qt.AlignCenter
            color: "transparent"
            visible: UpdatesService.isThereUpdates ? true : false

            Behavior on color {
                ColorAnimation {
                    duration: 200
                }
            }

            Text {
                id: updateButtonText
                text: "Atualizar"
                color: Appearance.palette.foregroundColor
                font.family: Appearance.font.family.main
                anchors.centerIn: parent
            }

            MouseArea {
                anchors.fill: parent
                hoverEnabled: true
                onClicked: {
                    UpdatesService.updateSystem();
                    listOfUpdates.visible = false;
                }
            }
        }
    }
}
