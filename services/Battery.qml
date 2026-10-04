pragma Singleton

import Quickshell
import Quickshell.Services.UPower

Singleton {
    property real percentage: UPower.displayDevice.percentage
    property real timeToFull: UPower.displayDevice.timeToFull
    property real timeToEmpty: UPower.displayDevice.timeToEmpty
    property bool isCharging: UPower.displayDevice.state == 1
    property bool isDischarging: UPower.displayDevice.state == 2
    property bool fullyCharged: UPower.displayDevice.state == 4
    property bool isPresent: UPower.displayDevice.isPresent
}
