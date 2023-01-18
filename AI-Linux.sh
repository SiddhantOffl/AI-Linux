#!/bin/bash


# Basha Virus V1.0
# Coded by: SiddhantOffl
# Github: https://github.com/SiddhantOffl

__version__="1.0"


## ANSI colors (FG & BG)
RED="$(printf '\033[31m')"  GREEN="$(printf '\033[32m')"  ORANGE="$(printf '\033[33m')"  BLUE="$(printf '\033[34m')"
MAGENTA="$(printf '\033[35m')"  CYAN="$(printf '\033[36m')"  WHITE="$(printf '\033[37m')" BLACK="$(printf '\033[30m')"
REDBG="$(printf '\033[41m')"  GREENBG="$(printf '\033[42m')"  ORANGEBG="$(printf '\033[43m')"  BLUEBG="$(printf '\033[44m')"
MAGENTABG="$(printf '\033[45m')"  CYANBG="$(printf '\033[46m')"  WHITEBG="$(printf '\033[47m')" BLACKBG="$(printf '\033[40m')"
RESETBG="$(printf '\e[0m\n')"

## Check Internet Status
check_status() {
    echo -ne "\n${GREEN}[${WHITE}+${GREEN}]${CYAN} Internet Status : "
    timeout 3s curl -fIs "https://api.github.com" > /dev/null
    [ $? -eq 0 ] && echo -e "${GREEN}Online${WHITE}" || echo -e "${RED}Offline${WHITE}"
}

## Script termination
exit_on_signal_SIGINT() {
    { printf "\n\n%s\n\n" "${RED}[${WHITE}!${RED}]${RED} Program Interrupted." 2>&1; reset_color; }
    exit 0
}

exit_on_signal_SIGTERM() {
    { printf "\n\n%s\n\n" "${RED}[${WHITE}!${RED}]${RED} Program Terminated." 2>&1; reset_color; }
    exit 0
}

trap exit_on_signal_SIGINT SIGINT
trap exit_on_signal_SIGTERM SIGTERM

## Reset terminal colors
reset_color() {
    tput sgr0   # reset attributes
    tput op     # reset color
    return
}


## Exit message
msg_exit() {
    { clear; banner; echo; }
    echo -e "${GREENBG}${BLACK} Thank you for using this tool. Have a good day.${RESETBG}\n"
    { reset_color; exit 0; }
}

## About
about() {
    { clear; banner; echo; }
	cat <<- EOF
		${GREEN} Author   ${RED}:  ${ORANGE}SIDDHANT ${RED}[ ${ORANGE}SAAHO ${RED}]
		${GREEN} Github   ${RED}:  ${CYAN}https://github.com/SiddhantOffl
		${GREEN} Social   ${RED}:  ${CYAN}https://instagram.com/yadhavoffl
		${GREEN} Version  ${RED}:  ${ORANGE}${__version__}

		${WHITE} ${REDBG}Warning:${RESETBG}
		${CYAN}  This Tool is made for educational purpose
		  only ${RED}!${WHITE}${CYAN} Author will not be responsible for
		  any misuse of this toolkit ${RED}!${WHITE}


		${RED}[${WHITE}00${RED}]${ORANGE} Main Menu     ${RED}[${WHITE}99${RED}]${ORANGE} Exit

	EOF
    
    read -p "${RED}[${WHITE}-${RED}]${GREEN} Select an option : ${BLUE}"
    case $REPLY in
        99)
        msg_exit;;
        0 | 00)
            echo -ne "\n${GREEN}[${WHITE}+${GREEN}]${CYAN} Returning to main menu..."
        { sleep 1; main_menu; };;
        *)
            echo -ne "\n${RED}[${WHITE}!${RED}]${RED} Invalid Option, Try Again..."
        { sleep 1; about; };;
    esac
}

## Directories
directories(){
    
    BASE_DIR=$(realpath "$(dirname "$BASH_SOURCE")")
    
    if [[ ! -d ".tools" ]]; then
        mkdir -p ".tools"
    fi
    
    if [[ ! -d ".Own-Script" ]]; then
        mkdir -p ".Own-Script"
    fi
    
}

## banner
banner(){
    
    cat <<- EOF
		${ORANGE}

		${ORANGE}     ─█▀▀█ ▀█▀ ── ░█─── ▀█▀ ░█▄─░█ ░█─░█ ▀▄░▄▀
		${GREEN}     ░█▄▄█ ░█─ ▀▀ ░█─── ░█─ ░█░█░█ ░█─░█ ─░█──
		${BLUE}     ░█─░█ ▄█▄ ── ░█▄▄█ ▄█▄ ░█──▀█ ─▀▄▄▀ ▄▀░▀▄
        ${RED}                       Version : ${__version__}
${GREEN}           [${WHITE}-${GREEN}]${CYAN} Tool Created by Siddhant (Saaho)${WHITE}
	EOF
}

## Dependencies
dependencies() {
    echo -e "\n${GREEN}[${WHITE}+${GREEN}]${CYAN} Installing required packages..."
    
    if [[ -d "/data/data/com.termux/files/home" ]]; then
        if [[ ! $(command -v proot) ]]; then
            echo -e "\n${GREEN}[${WHITE}+${GREEN}]${CYAN} Installing package : ${ORANGE}proot${CYAN}"${WHITE}
            pkg install proot resolv-conf -y
        fi
        
        if [[ ! $(command -v tput) ]]; then
            echo -e "\n${GREEN}[${WHITE}+${GREEN}]${CYAN} Installing package : ${ORANGE}ncurses-utils${CYAN}"${WHITE}
            pkg install ncurses-utils -y
        fi
    fi
    
    if [[ $(command -v git) && $(command -v php) && $(command -v curl) && $(command -v unzip) && $(command -v python3) && $(command -v python2) && $(command -v python-minimal)  ]]; then
        echo -e "\n${GREEN}[${WHITE}+${GREEN}]${GREEN} Packages already installed."
    else
        pkgs=(git php curl unzip python2 python3 python-minimal)
        for pkg in "${pkgs[@]}"; do
            type -p "$pkg" &>/dev/null || {
                echo -e "\n${GREEN}[${WHITE}+${GREEN}]${CYAN} Installing package : ${ORANGE}$pkg${CYAN}"${WHITE}
                if [[ $(command -v pkg) ]]; then
                    pkg install "$pkg" -y
                    elif [[ $(command -v apt) ]]; then
                    sudo apt install "$pkg" -y
                    elif [[ $(command -v apt-get) ]]; then
                    sudo apt-get install "$pkg" -y
                    elif [[ $(command -v pacman) ]]; then
                    sudo pacman -S "$pkg" --noconfirm
                    elif [[ $(command -v dnf) ]]; then
                    sudo dnf -y install "$pkg"
                    elif [[ $(command -v yum) ]]; then
                    sudo yum -y install "$pkg"
                else
                    echo -e "\n${RED}[${WHITE}!${RED}]${RED} Unsupported package manager, Install packages manually."
                    { reset_color; exit 1; }
                fi
            }
        done
    fi
}

## Repositories
repositories() {
    cd && cd /etc/apt && mousepad sources.list
    
}

## install_tools
install_tools() {
    { clear; banner; dependencies; echo; clear; banner; }
    
    echo -e "${ORANGE}Uptating Linux...${GREEN}"
    echo -e ""
    sudo apt-get update
    echo -e ""
    echo -e "${ORANGE}Upgrading...${GREEN}"
    sudo apt-get upgrade -y
    echo -e ""
    echo -e "${ORANGE}Dist Upgrading...${GREEN}"
    sudo apt-get dist-upgrade -y
    echo -e ""
    echo -e "${ORANGE}Auto Removing Linux...${GREEN}"
    sudo apt-get autoremove -y
    echo -e ""
    sleep 5
    echo -e "\e[1;93m Updated!!🙄\e[0m"
    sleep 5
    clear
    sleep 3
    
    ## install_vs code
    echo -e "${ORANGE}Installing VS Code...${GREEN}"
    sudo apt install software-properties-common apt-transport-https wget
    wget -q https://packages.microsoft.com/keys/microsoft.asc -O- | sudo apt-key add -
    sudo add-apt-repository "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main"
    sudo apt install code
    sleep 3
    clear
    
    ## install tor
    echo -e "${ORANGE}Installing Tor...${GREEN}"
    sudo apt install tor torbrowser-launcher -y
    torbrowser-launcher
    sleep 3
    clear
    
    ## install Brave
    echo -e "${ORANGE}Installing Brave...${GREEN}"
    curl -s https://brave-browser-apt-release.s3.brave.com/brave-core.asc | sudo apt-key --keyring /etc/apt/trusted.gpg.d/brave-browser-release.gpg add -
    echo "deb [arch=amd64] https://brave-browser-apt-release.s3.brave.com/ stable main" | sudo tee /etc/apt/sources.list.d/brave-browser-release.list
    sudo apt install brave-browser
    sleep 3
    clear
    
    ## install Tweaks
    echo -e "${ORANGE}Installing Tweaks...${GREEN}"
    sudo apt install gnome-tweaks
    sleep 3
    clear
    
    { sleep 1; main_menu; }
    
}

## others
others() {
    { directories; clear; banner; echo; }
    cd .tools/
    
    ## install zphiser
    echo -e "${ORANGE}Installing Zphisher...${GREEN}"
    git clone https://github.com/htr-tech/zphisher.git
    sleep 3
    echo -e "${ORANGE}Done...${GREEN}"
    sleep 3
    clear
    
    ## install seeker
    echo -e "${ORANGE}Installing Seeker...${GREEN}"
    git clone https://github.com/thewhiteh4t/seeker.git
    sleep 3
    echo -e "${ORANGE}Done...${GREEN}"
    sleep 3
    clear
    
    ## install TheFATRAT
    echo -e "${ORANGE}Installing The FatRat...${GREEN}"
    git clone https://github.com/screetsec/TheFatRat.git
    sleep 3
    echo -e "${ORANGE}Done...${GREEN}"
    sleep 3
    clear
    
    ## install Socialbrute
    echo -e "${ORANGE}Installing Socialbrute...${GREEN}"
    git clone https://github.com/5h4d0wb0y/socialbrute.git
    sleep 3
    echo -e "${ORANGE}Done...${GREEN}"
    sleep 3
    clear
    
    ## install Cupp
    echo -e "${ORANGE}Installing Cupp...${GREEN}"
    git clone https://github.com/Mebus/cupp.git
    sleep 3
    echo -e "${ORANGE}Done...${GREEN}"
    sleep 3
    clear
    
    ## install ADB-Toolkit
    echo -e "${ORANGE}Installing ADB-Toolkit...${GREEN}"
    git clone https://github.com/ASHWIN990/ADB-Toolkit.git
    sleep 3
    echo -e "${ORANGE}Done...${GREEN}"
    sleep 3
    clear
    
    ## install Ghost
    echo -e "${ORANGE}Installing Ghost...${GREEN}"
    git clone https://github.com/EntySec/Ghost.git
    sleep 3
    echo -e "${ORANGE}Done...${GREEN}"
    sleep 3
    clear
    
    ## install TBOMB
    echo -e "${ORANGE}Installing TBOMB...${GREEN}"
    git clone https://github.com/TheSpeedX/TBomb.git
    sleep 3
    clear
    brew install git
    brew install python3
    sudo easy_install pip
    sudo pip install --upgrade pip
    clear
    echo -e "${ORANGE}Done...${GREEN}"
    sleep 3
    clear
    
    ## install Ghost
    echo -e "${ORANGE}Installing SpamWa...${GREEN}"
    git clone https://github.com/krypton-byte/SpamWa.git
    sleep 3
    echo -e "${ORANGE}Done...${GREEN}"
    sleep 3
    cd ../
    clear
    
}

## Own Scripts
own_scripts() {
    
    { directories; clear; banner; echo; }
    cd .Own-Script/
    
    ## install MAC-CHANGER
    echo -e "${ORANGE}Installing MAC-CHANGER...${GREEN}"
    git clone https://github.com/SiddhantOffl/mac-changer.git
    sleep 3
    echo -e "${ORANGE}Done...${GREEN}"
    sleep 3
    cd ../
    clear
}

## Updating_Linux
updating() {
{ clear; banner; echo; }
	
	echo -e "${ORANGE}Uptating Linux...${GREEN}"
	echo -e ""
    sudo apt-get update
    sleep 3
    clear
	echo -e ""
	echo -e "${ORANGE}Upgrading...${GREEN}"
	sudo apt-get upgrade -y 
    sleep 3
    clear
	echo -e ""
	echo -e "${ORANGE}Dist Upgrading...${GREEN}"
	sudo apt-get dist-upgrade -y 
    sleep 3
    clear
	echo -e ""
	echo -e "${ORANGE}Auto Removing Linux...${GREEN}"
	sudo apt-get autoremove -y
	echo -e ""
	echo -e "${WHITE}${REDBG} 0 upgraded, 0 newly installed, 0 to remove and 0 not upgraded ${RESETBG}"
	sleep 5
	echo -e "\e[1;93m Updated!!🙄\e[0m"
	{ sleep 1; main_menu; }
}

## Github
github() {
    { clear; banner; }
	cat <<- EOF

		${RED}    [${WHITE}01${RED}]${ORANGE} Others Scripts
		${RED}    [${WHITE}02${RED}]${ORANGE} Own Scripts
    ${RED}[${WHITE}03${RED}]${ORANGE} Main Menu



	EOF
    
    read -p "${RED}[${WHITE}-${RED}]${GREEN} Select an option : ${BLUE}"
    
    case $REPLY in
        1 | 01)
        others;;
        2 | 02)
        own_scripts;;
        3 | 03)
        main_menu;;
        
        *)
            echo -ne "\n${RED}[${WHITE}!${RED}]${RED} Invalid Option, Try Again..."
        { sleep 1; clear; banner; github; };;
    esac
}


## Menu
main_menu() {
    { clear; banner; echo; }
	cat <<- EOF
		${RED}  [${WHITE}::${RED}]${ORANGE} Select A Option For You ${RED}[${WHITE}::${RED}]${ORANGE}

		        ${RED}[${WHITE}01${RED}]${ORANGE} Repositories
        ${RED}[${WHITE}02${RED}]${ORANGE} Dependencies
		        ${RED}[${WHITE}03${RED}]${ORANGE} GitHub
        ${RED}[${WHITE}04${RED}]${ORANGE} Update

		     ${RED}[${WHITE}99${RED}]${ORANGE} About       ${RED}[${WHITE}00${RED}]${ORANGE} Exit

	EOF
    
    read -p "${RED}[${WHITE}-${RED}]${GREEN} Select an option : ${BLUE}"
    
    case $REPLY in
        1 | 01)
        repositories;;
        2 | 02)
        install_tools;;
        3 | 03)
        github;;
        4 | 04)
        updating;;
        99)
        about;;
        0 | 00 )
        msg_exit;;
        *)
            echo -ne "\n${RED}[${WHITE}!${RED}]${RED} Invalid Option, Try Again..."
        { sleep 1; main_menu; };;
        
    esac
}





## Main
check_status
main_menu