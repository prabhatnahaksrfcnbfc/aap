#!/bin/bash
# By Aaron
# https://github.com/Github-Aiko/aaPanel

red() {
    echo -e "\033[31m\033[01m$1\033[0m"
}
green() {
    echo -e "\033[32m\033[01m$1\033[0m"
}
yellow() {
    echo -e "\033[33m\033[01m$1\033[0m"
}
purple() {
    echo -e "\033[35m\033[01m$1\033[0m"
}

aapanel_install() {
    wget -O "/root/aapanel-install.sh" "http://www.aapanel.com/script/install_6.0_en.sh"
    red "Installing the original aaPanel from the official website."
    bash "/root/aapanel-install.sh"
}

panel_happy() {
    red "Please manually open the software store once before executing"
    sed -i 's|"endtime": -1|"endtime": 999999999999|g' /www/server/panel/data/plugin.json
    sed -i 's|"pro": -1|"pro": 0|g' /www/server/panel/data/plugin.json
    chattr +i /www/server/panel/data/plugin.json

    chattr -i /www/server/panel/data/repair.json
    rm -f /www/server/panel/data/repair.json

    cd /www/server/panel/data || exit 1
    wget https://ghproxy.com/https://raw.githubusercontent.com/Github-Aiko/aaPanel/main/resource/repair.json
    chattr +i /www/server/panel/data/repair.json

    red "Cracked successfully."
}

uninstall_panel() {
    wget -O "/root/bt-uninstall.sh" "http://download.bt.cn/install/bt-uninstall.sh"
    bash "/root/bt-uninstall.sh"
    red "Panel uninstalled successfully."
}

clear_logs() {
    echo "" > /www/server/panel/script/site_task.py
    chattr +i /www/server/panel/script/site_task.py
    rm -rf /www/server/panel/logs/request/*
    chattr +i -R /www/server/panel/logs/request
}

clean_up_trash() {
    rm -rf /tmp/*
    rm -rf /var/tmp/*
    red "Cleanup completed."
}

start_menu() {
    clear
    purple " Thank you for using the aaPanel tool."
    purple " https://github.com/Github-Aiko/aaPanel"
    yellow " ————————————————————————————————————————————————"
    green " 1. Install aaPanel on CentOS/Debian/Ubuntu"
    yellow " ————————————————————————————————————————————————"
    green " 2. aaPanel Pro"
    green " 3. Delete log files, lock file write permissions"
    yellow " ————————————————————————————————————————————————"
    green " 4. Uninstall the aaPanel panel"
    green " 5. Cleanup script produces junk files"
    green " 0. Exit"

    echo
    read -p "Please key in numbers: " menuNumberInput

    case "$menuNumberInput" in
        1) aapanel_install ;;
        2) panel_happy ;;
        3) clear_logs ;;
        4) uninstall_panel ;;
        5) clean_up_trash ;;
        0) exit 0 ;;
        *)
            red "Please enter the correct number!"
            sleep 1
            start_menu
        ;;
    esac
}

start_menu
