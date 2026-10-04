import QtQuick
import QtQuick.Layouts
import qs.widgets

Item {
    id: leftSide

    implicitWidth: leftRow.implicitWidth
    implicitHeight: leftRow.implicitHeight

    anchors {
        left: parent.left
        leftMargin: 4
        verticalCenter: parent.verticalCenter
    }

    RowLayout {
        id: leftRow

        SystemShutdownWidget {
            id: shutdownWidget
        }

        Workspaces {}
    }
}
