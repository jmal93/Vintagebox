import Quickshell
import QtQuick
import "modules" as Modules

Scope {
    Modules.Bar {}
    property string assetsPath: Qt.resolvedUrl("./assets/")
}
