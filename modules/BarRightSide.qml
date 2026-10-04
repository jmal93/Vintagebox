import QtQuick
import QtQuick.Layouts
import qs.widgets

Item {
    id: rightSide

    implicitWidth: rightRow.implicitWidth
    implicitHeight: rightRow.implicitHeight
    anchors {
        right: parent.right
        rightMargin: 4
        verticalCenter: parent.verticalCenter
    }

    RowLayout {
        id: rightRow

        spacing: 10

        OptionsWidget {}
    }
}
