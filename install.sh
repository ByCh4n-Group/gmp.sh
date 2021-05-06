#!/bin/bash

#    Get My Package installer - install.sh for gmp.sh   
#    Copyright (C) 2021  lazypwny751
#
#    This program is free software: you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation, either version 3 of the License, or
#    (at your option) any later version.
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License
#    along with this program.  If not, see <https://www.gnu.org/licenses/>.


maintainer="ByCh4n&LazyPwnt"
version="1"

# Reset
reset='\033[0m'           # Text Reset

red='\033[0;31m'          # Red
green='\033[0;32m'        # Green

checknet() {
    if ! ping -q -c 1 -W 1 google.com >/dev/null ; then
        echo -e "[${red}-${reset}]please check your internet connection."
        exit 1
    fi
}

[ $UID != 0 ] && { echo -e "${red}Run it as Root!${reset}" ; exit 1 ; }

install() {
    [ -e gmp.sh ] && chmod +x gmp.sh || { echo "sorry i can't find the base file. Are it there?" ; exit 1 ; }
    cp ./gmp.sh /usr/bin && echo -e "${green}installed${reset}."
}

## depends

case ${1} in
    [iI][nN][sS][tT][aA][lL][lL]|--[iI][nN][sS][tT][aA][lL][lL]|-[iI])
        if [ -e /etc/debian_version ] ; then
            apt update && apt install -y curl wget
            install
            checknet
        elif [ -e /etc/arch-release ] ; then
            pacman -Syy --noconfirm curl wget
            install
            checknet
        elif [ -e /etc/redhat-release ] ; then
            echo "will come very soon!"
        else
            echo "sorry $USER i don't know your language :("
            exit 1
        fi
    ;;
    [uU][nN][iI][nN][sS][tT][aA][lL][lL]|--[iI][uU][nN][nN][sS][tT][aA][lL][lL]|-[uU][iI])
        [ -e /usr/bin/gmp.sh ] && rm /usr/bin/gmp.sh && echo -e "${green}uninstalled${reset}." || echo "already uninstalled"
    ;;
    *)
        echo -e "if you want to install the script so try --install argument or if you want to\nuninstall the script then try --uninstall argument. Have a good day."
    ;;
esac