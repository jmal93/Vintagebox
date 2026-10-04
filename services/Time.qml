pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick

Singleton {
    id: root
    property string calendar: ""

    function getDateTime() {
        return clock.date;
    }

    SystemClock {
        id: clock
        precision: SystemClock.Seconds
    }

    Process {
      id: calendarProcess
      running: true
      command: ["cal"]
      stdout: StdioCollector {
        onStreamFinished: root.calendar = text
      }
    }
}
