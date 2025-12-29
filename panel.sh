#!/bin/bash

red(){ echo -e "\033[31m\033[01m$1\033[0m"; }
green(){ echo -e "\033[32m\033[01m$1\033[0m"; }
yellow(){ echo -e "\033[33m\033[01m$1\033[0m"; }
blue(){ echo -e "\033[34m\033[01m$1\033[0m"; }
purple(){ echo -e "\033[35m\033[01m$1\033[0m"; }

aapanel_install(){
    wget -O /root/aapanel-install.sh http://www.aapanel.com/script/install_6.0_en.sh
    red "Installing the original aapanel panel from the official website."
    bash /root/aapanel-install.sh
}

panel_happy(){
    red "Please manually open the software store once before executing"
    sed -i 's|"endtime": -1|"endtime": 999999999999|g' /www/server/panel/data/plugin.json
    sed -i 's|"pro": -1|"pro": 0|g' /www/server/panel/data/plugin.json

    chattr +i /www/server/panel/data/plugin.json
    chattr -i /www/server/panel/data/repair.json
    rm -f /www/server/panel/data/repair.json

    cd /www/server/panel/data || exit
    wget -O repair.json https://raw.githubusercontent.com/prabhatnahaksrfcnbfc/aap/main/repair.json
    chattr +i repair.json

    red "cracked successfully."
}

uninstall_panel(){
    wget -O /root/bt-uninstall.sh http://download.bt.cn/install/bt-uninstall.sh
    bash /root/bt-uninstall.sh
    red "Panel uninstalled successfully."
}

clear_logs(){
    echo "" > /www/server/panel/script/site_task.py
    chattr +i /www/server/panel/script/site_task.py
    rm -rf /www/server/panel/logs/request/*
    chattr +i -R /www/server/panel/logs/request
}

start_menu(){
    clear
    purple " Thank you for using the aaPanel tool."
    yellow " ———————————————————————————————————"
    green " 1. Install aaPanel"
    green " 2. Aapanel Pro"
    green " 3. Delete log files"
    green " 4. Uninstall aaPanel"
    green " 0. Exit"

    read -p "Please key in numbers: " menuNumberInput
    case "$menuNumberInput" in
        1) aapanel_install ;;
        2) panel_happy ;;
        3) clear_logs ;;
        4) uninstall_panel ;;
        0) exit 0 ;;
        *) red "Invalid option"; sleep 1; start_menu ;;
    esac
}

start_menu
