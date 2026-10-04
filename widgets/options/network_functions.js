function barToWifi(strength) {
    if (strength > 0.8)
        return "󰤨";
    else if (strength <= 0.8 && strength > 0.6)
        return "󰤥";
    else if (strength <= 0.6 && strength > 0.4)
        return "󰤢";
    else if (strength <= 0.4 && strength > 0.2)
        return "󰤟";
    else
        return "󰤫";
}

function barToWifiSecurity(strength) {
    if (strength > 0.8)
        return "󰤪";
    else if (strength <= 0.8 && strength > 0.6)
        return "󰤧";
    else if (strength <= 0.6 && strength > 0.4)
        return "󰤤";
    else if (strength <= 0.4 && strength > 0.2)
        return "󰤡";
    else
        return "󱛏";
}

