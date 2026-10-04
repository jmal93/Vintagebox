function buildListOfNetworks(text) {
    const lines = text.split('\n');
    const listOfNetworks = [];

    for (let i = 0; i < lines.length; i++) {
        const line = lines[i].trim();
        if (!line) {
            continue;
        }

        const network = parseNetwork(line);
        if (network) {
            listOfNetworks.push(network);
        }
    }

    applyDiff(listOfNetworks);
}

function parseNetwork(line) {
    const parts = line.split(":");

    const ssid = parts[0];
    const signal = Number(parts[1]);
    const bars = parts[2];
    const security = parts[3];

    if (!ssid || Number.isNaN(signal) || !bars || !security)
        return null;

    const bssid = getBssid(parts);

    if (!bssid) {
        return null;
    }

    return {
        ssid,
        signal,
        bars,
        security,
        bssid
    }
}

function getBssid(text) {
    const bssidEscaped = text.slice(4).join(":");
    return bssidEscaped.replace(/\\:/g, ":");
}

function applyDiff(newList) {
    const incomingNetworks = buildMapOfIncomingNetworks(newList);
    removeNetworksNotInIncoming(incomingNetworks);
    updateExistingNetworks(incomingNetworks);
    addNewNetworks(incomingNetworks);
    sortNetworksBySignalStrength();
}

function buildMapOfIncomingNetworks(newList) {
    const incoming = new Map();

    for (const n of newList) {
        if (n.bssid === bssid) {
            continue;
        }
        if (n.ssid && n.bssid) {
            incoming.set(keyOf(n), n);
        }
    }

    return incoming;
}

function removeNetworksNotInIncoming(incoming) {
    for (let i = networksModel.count - 1; i >= 0; i--) {
        if (!incoming.has(networksModel.get(i).key)) {
            networksModel.remove(i);
        }
    }
}

function buildSetOfKeysOfExistingNetworks(incoming) {
    const existingKeys = new Set();

    for (let i = 0; i < networksModel.count; i++) {
        const item = networksModel.get(i);
        existingKeys.add(item.key);
    }

    return existingKeys;
}

function updateExistingNetworks(incoming) {
    for (let i = 0; i < networksModel.count; i++) {
        const item = networksModel.get(i);
        const updated = incoming.get(item.key);

        if (item.signal !== updated.signal) {
            networksModel.setProperty(i, "signal", updated.signal);
        }
        if (item.bars !== updated.bars) {
            networksModel.setProperty(i, "bars", updated.bars);
        }
    }
}

function addNewNetworks(incoming) {
    const existingKeys = buildSetOfKeysOfExistingNetworks(incoming);

    for (const [key, n] of incoming) {
        if (!existingKeys.has(key)) {
            networksModel.append({
                key,
                ssid: n.ssid,
                bssid: n.bssid,
                signal: n.signal,
                bars: n.bars,
                security: n.security
            });
        }
    }
}

function sortNetworksBySignalStrength() {
    for (let i = 1; i < networksModel.count; i++) {
        let j = i;
        while (j > 0 && networksModel.get(j).signal > networksModel.get(j - 1).signal) {
            networksModel.move(j, j - 1, 1);
            j--;
        }
    }
}

function keyOf(obj) {
    return obj.ssid + "|" + obj.bssid;
}
