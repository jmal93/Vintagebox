import QtQuick
import Quickshell
import qs.services

PopupWindow {
    id: calendarPopup
    visible: false
    implicitWidth: calendar.implicitWidth + 10
    implicitHeight: calendar.implicitHeight
    color: Appearance.palette.backgroundColor

    Calendar {
        id: calendar
        anchors.centerIn: parent
    }
}
