pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick

Singleton {
    id: updates
    property string listOfUpdates: ""
    property string numberOfUpdates: ""
    property bool isThereUpdates: Number(numberOfUpdates) == 0 ? false : true

    function updateSystem() {
        if (!doUpdateInTerminal.running) {
            doUpdateInTerminal.running = true;
        }
    }

    Timer {
        interval: 1000 * 60
        repeat: true
        running: true
        onTriggered: getUpdates.running = true
    }

    Process {
        id: getUpdates
        command: ["sh", "-c", "checkupdates"]
        running: true

        stdout: StdioCollector {
            onStreamFinished: {
                const txt = this.text.trim();
                updates.listOfUpdates = txt;
                updates.numberOfUpdates = txt.length ? String(txt.split("\n").length) : "0";
            }
        }
    }

    Process {
        id: doUpdateInTerminal
        running: false
        command: ["kitty", "sh", "-lc", "sudo pacman -Syu --noconfirm; status=$?; if [ $status -eq 0 ]; then notify-send 'Atualização do sistema' 'Atualização concluída com sucesso'; else notify-send 'Atualização do sistema' 'A atualização terminou com erro'; fi; exit $status"]

        onRunningChanged: {
            if (!running && !getUpdates.running) {
                getUpdates.running = true;
            }
        }
    }
}
