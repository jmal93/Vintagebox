import QtQuick
import QtQuick.Layouts
import qs.services

ColumnLayout {
    id: calendar

    property date currendDate: new Date()

    function getMonthModel() {
        const year = currendDate.getFullYear();
        const month = currendDate.getMonth();
        const totalDays = getDaysInMonth(year, month);

        const offset = getFirstDayOffset(year, month);

        let days = [];
        for (let i = 1; i <= offset; i++) {
            days.push("");
        }
        for (let i = 1; i <= totalDays; i++) {
            days.push(i.toString());
        }

        return days;
    }

    function getDaysInMonth(year, month) {
        return new Date(year, month + 1, 0).getDate();
    }

    function getFirstDayOffset(year, month) {
        return new Date(year, month, 1).getDay();
    }

    function getCurrentMonth() {
        const locale = Qt.locale();
        return locale.monthName(currendDate.getMonth());
    }

    Text {
        text: calendar.getCurrentMonth()
        color: Appearance.palette.foregroundColor
        font.family: Appearance.font.family.main
    }

    GridLayout {
        columns: 7

        Text {
            text: "do"
            color: "white"
        }
        Text {
            text: "se"
            color: "white"
        }
        Text {
            text: "te"
            color: "white"
        }
        Text {
            text: "qu"
            color: "white"
        }
        Text {
            text: "qu"
            color: "white"
        }
        Text {
            text: "se"
            color: "white"
        }
        Text {
            text: "sá"
            color: "white"
        }

        Repeater {
            model: calendar.getMonthModel()

            Rectangle {
                required property string modelData
                implicitWidth: 16
                implicitHeight: dayText.implicitHeight
                color: Appearance.palette.color2
                Layout.alignment: Qt.AlignCenter

                Text {
                    id: dayText
                    text: parent.modelData
                    color: Appearance.palette.foregroundColor
                    font.family: Appearance.font.family.main
                    anchors.centerIn: parent
                }
            }
        }
    }
}
