#!/bin/bash

#    Get My Package - gmp.sh   
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

## Local Variables
maintainer="ByCh4n&LazyPwnt"
version="1"
basedir="/tmp/getmypackage"

# this link just could be your repo of packages to index.sh file as raw
indexlink="https://raw.githubusercontent.com/ByCh4n-Group/bych4n_x86_64_debian/main/index.sh"

## Colors
# Reset
reset='\033[0m'           # Text Reset

# Regular Colors
black='\033[0;30m'        # Black
red='\033[0;31m'          # Red
green='\033[0;32m'        # Green
yellow='\033[0;33m'       # Yellow
blue='\033[0;34m'         # Blue
purple='\033[0;35m'       # Purple
cyan='\033[0;36m'         # Cyan
white='\033[0;37m'        # White

# Bold
Bblack='\033[1;30m'       # Black
Bred='\033[1;31m'         # Red
Bgreen='\033[1;32m'       # Green
Byellow='\033[1;33m'      # Yellow
Bblue='\033[1;34m'        # Blue
Bpurple='\033[1;35m'      # Purple
Bcyan='\033[1;36m'        # Cyan
Bwhite='\033[1;37m'       # White

# Are You Connected?
checknet() {
    if ! ping -q -c 1 -W 1 google.com >/dev/null ; then
        echo -e "[${red}-${reset}]please check your internet connection."
        exit 1
    fi
}

# Check depend
checkdepend() {
    [ $(command -v ${1}) ] || { echo "i require ${1} please install it then try again." ; exit 1 ; }
}

# Check System Base (deb,tar.gz,rpm)
checkbase() {
    if [ -e /etc/debian_version ] ; then
        setbase="deb"
    elif [ -e /etc/arch-release ] ; then
        setbase="tar.gz"
    elif [ -e /etc/redhat-release ] ; then
        setbase="rpm"
    else
        echo -e " Debian - deb\n Arch - tar.gz\n RedHat - rpm"
        read -p "i can't understand your distro's language please tell me which distro base you have?:> " im
        case ${im} in
            [dD][eE][bB][iI][aA][nN]|[dD][eE][bB])
                setbase="deb"
            ;;
            
            [aA][rR][cC][hH]|[tT][aA][rR].[gG][zZ])
                setbase="tar.gz"
            ;;
            
            [rR][eE][dD][hH][aA][tT]|[rR][pP][mM])
                setbase="rpm"
            ;;

            *)
                echo -e "[${red}-${reset}] Unknow Distribution Aborting..\nIf you want to understand what the system is, you can check out this link:\nhttps://www.cyberciti.biz/faq/how-to-check-os-version-in-linux-command-line"
                exit 1
            ;;
        esac
        im=""
    fi
}

# Manage SubSystem Of installer
mssi() {
    case ${1} in
        [sS][tT][aA][rR][tT])
            [ -d ${basedir} ] && rm -rf ${basedir}
            mkdir ${basedir}
        ;;
        [sS][tT][oO][pP])
            [ -d ${basedir} ] && rm -rf ${basedir}
        ;;
        ""|" ")
            [ -d ${basedir} ] && rm -rf ${basedir} || mkdir ${basedir} 
        ;;
    esac
}

# Get The index as Source
getindex() {
    checknet
    checkdepend wget
    mssi start
    wget ${indexlink} -O ${basedir}/index.sh &> /dev/null && echo -e "[${green}*${reset}] ${yellow}index.sh${reset} hit.." || { echo -e "[${red}-${reset}] I can't get the ${yellow}index.sh${reset} file." ; exit 1 ; } 
}

seeyea() {
    mssi stop
    case $(( $RANDOM % 3)) in
        0)
            echo "See yea ('-')"
        ;;
        1)
            echo "https://pnmos.xyz PNM's Not Mac"
        ;;
        2)
            echo "https://github.com/ByCh4n-Group"
        ;;
        3)
            echo "getting packing.."
        ;;
        *)
            echo "boranity diye yazılır $(echo 'Ym9yYW4gaXRpCg==' | base64 -d) diye okunur."
        ;;
    esac
    exit 0
}

trap seeyea INT

case ${1} in
    [lL][iI][sS][tT]|--[lL][iI][sS][tT]|-[lL][sS])
        getindex
        source ${basedir}/index.sh
        [ ! -z ${author} ] && echo -e "\nOwner(s) Of Repository: ${yellow}${author}${reset}\n"

        for i in $( seq 1 $((${#packages[@]} - 1)) ) 
        do
            echo -e "[${Bwhite}${i}${reset}] ${purple}${packages[i]}${reset}"
        done

        echo -e "\nthere are ${blue}$((${#packages[@]} - 1))${reset} packages in ${cyan}${packages[0]}${reset} repository\n"
        mssi stop
    ;;

    [cC][hH][eE][cC][kK]|--[cC][hH][eE][cC][kK]|-[cC])
        checkinrepo() {
            checkdepend curl
            checkbase

            case ${2} in
                [dD][eE][bB]|--[dD][eE][bB])
                    setbase="deb"
                ;;
                [tT][aA][rR].[gG][zZ]|--[tT][aA][rR].[gG][zZ])
                    setbase="tar.gz"
                ;;
                [rR][pP][mM]|--[rR][pP][mM])
                    setbase="rpm"
                ;;
            esac

            checklink="${packages[0]}/${packages[${1}]}.${setbase}"
            if curl --output /dev/null --silent --head --fail "$checklink" ; then
                echo -e "Nice! File ${yellow}${packages[${1}]}.${setbase}${reset} was found in repository ${blue}${packages[0]}${reset}!"
            else
                echo -e "Sorry. i can't see ${red}${packages[${1}]}.${setbase}${reset} in repository ${blue}${packages[0]}${reset}."
            fi
        }

        [ -z ${2} ] && { echo -e "[${red}-${reset}] please enter the name of the package you want to search as the 2nd argument, 2nd argument cannot be blank." ; exit 1 ; }
        getindex
        source ${basedir}/index.sh
        for i in $( seq 1 $((${#packages[@]} - 1)) ) 
        do
            [[ ${packages[i]} == ${2}_*_x86_64 ]] && { echo -e "${Bgreen}${2}${reset}: found!" ; checkinrepo ${i} ${3} ; pkfound="true" ; }
        done
        [ -z ${pkfound} ] && { echo -e "${red}${2}${reset}: i can't see the package!" ; exit 1 ; }
        mssi stop
    ;;
    
    # Note that this is not a package manager, so it is recommended 
    # that you download the packages you will download one by one,
    # as we do not have multiple download infrastructure already.

    [iI][nN][sS][tT][aA][lL][lL]|--[iI][nN][sS][tT][aA][lL][lL]|-[iI])
        [ $UID != 0 ] && { echo -e "${red}Run it as Root!${reset} '${yellow}sudo ${0} --install <package>${reset}'" ; exit 1 ; }
       
        getpackage() {
            checkdepend curl
            checkdepend wget
            checkbase
            mssi start

            checklink="${packages[0]}/${packages[${1}]}.${setbase}"
            if curl --output /dev/null --silent --head --fail "$checklink" ; then
                cd ${basedir}
                echo -e "Getting ${yellow}${packages[${1}]}.${setbase}${reset}.."
                { [ -e ${packages[${1}]}.${setbase} ] || wget ${checklink} ; } && installpackage ${packages[${1}]}.${setbase} || { echo -e "Sorry i can't get the package: ${yellow}${packages[${1}]}.${setbase}${reset}" ; exit 1 ; }
            else
                echo -e "Sorry. i can't see ${red}${packages[${1}]}.${setbase}${reset} in repository ${blue}${packages[0]}${reset}."
            fi            
        }

        installpackage() {
            checkbase
            [ -d ${basedir} ] && cd ${basedir} || { echo -e "Where are the base? What happened to base!" ; exit 1 ; }
            case ${setbase} in
                deb)
                    apt install ./${1}
                ;;
                tar.gz)
                    pacman -U ./${1}
                ;;
                rpm)
                    echo "this feature is not ready yet!"
                    exit 1
                ;;
            esac
        }
 
        [ -z ${2} ] && { echo -e "[${red}-${reset}] please enter the name of the package you want to install as the 2nd argument, 2nd argument cannot be blank." ; exit 1 ; }
        getindex
        source ${basedir}/index.sh

        for i in $( seq 1 $((${#packages[@]} - 1)) ) 
        do
            [[ ${packages[i]} == ${2}_*_x86_64 ]] && { echo -e "${Bgreen}${2}${reset}: found!" ; getpackage ${i} ; pkfound="true" ; }
        done
        [ -z ${pkfound} ] && { echo -e "${red}${2}${reset}: i can't see the package!" ; exit 1 ; }
        mssi stop
    ;;

    [uU][nN][iI][nN][sS][tT][aA][lL][lL]|--[iI][uU][nN][nN][sS][tT][aA][lL][lL]|-[uU][iI])
        [ $UID != 0 ] && { echo -e "${red}Run it as Root!${reset} '${yellow}sudo ${0} --uninstall <package>${reset}'" ; exit 1 ; }

        uninstallpackage() {
            checkbase
            case ${setbase} in
                deb)
                    apt remove ${packagenames[${1}]}
                ;;
                tar.gz)
                    pacman -R ${packagenames[${1}]}
                ;;
                rpm)
                    echo "this feature is not ready yet!"
                    exit 1
                ;;
            esac
        }

        [ -z ${2} ] && { echo -e "[${red}-${reset}] please enter the name of the package you want to install as the 2nd argument, 2nd argument cannot be blank." ; exit 1 ; }
        getindex
        source ${basedir}/index.sh
        for i in $( seq 1 $((${#packages[@]} - 1)) ) 
        do
            [[ ${packages[i]} == ${2}_*_x86_64 ]] && { echo -e "${Bgreen}${2}${reset}: found!" ; uninstallpackage ${i} ; pkfound="true" ; }
        done
        [ -z ${pkfound} ] && { echo -e "${red}${2}${reset}: i can't see the package!" ; exit 1 ; }
        mssi stop
    ;;

    [gG][eE][tT]|--[gG][eE][tT]|-[gG])
        getpackage() {
            checkdepend curl
            checkdepend wget
            checkbase

            case ${2} in
                [dD][eE][bB]|--[dD][eE][bB])
                    setbase="deb"
                ;;
                [tT][aA][rR].[gG][zZ]|--[tT][aA][rR].[gG][zZ])
                    setbase="tar.gz"
                ;;
                [rR][pP][mM]|--[rR][pP][mM])
                    setbase="rpm"
                ;;
            esac

            checklink="${packages[0]}/${packages[${1}]}.${setbase}"
            if curl --output /dev/null --silent --head --fail "$checklink" ; then
                echo -e "Getting ${yellow}${packages[${1}]}.${setbase}${reset}.."
                wget ${checklink}
            else
                echo -e "Sorry. i can't see ${red}${packages[${1}]}.${setbase}${reset} in repository ${blue}${packages[0]}${reset}."
            fi
        }

        [ -z ${2} ] && { echo -e "[${red}-${reset}] please enter the name of the package you want to get as the 2nd argument, 2nd argument cannot be blank." ; exit 1 ; }
        getindex
        source ${basedir}/index.sh

        for i in $( seq 1 $((${#packages[@]} - 1)) ) 
        do
            [[ ${packages[i]} == ${2}_*_x86_64 ]] && { echo -e "${Bgreen}${2}${reset}: found!" ; getpackage ${i} ${3} ; pkfound="true" ; }
        done
        [ -z ${pkfound} ] && { echo -e "${red}${2}${reset}: i can't see the package!" ; exit 1 ; }
        mssi stop
    ;;

    [vV][eE][rR][sS][iI][oO][nN]|--[vV][eE][rR][sS][iI][oO][nN]|-[vV])
        echo -e "version: ${version}\nmaintainer: ${maintainer}\nset index link: ${indexlink}"
        exit 0
    ;;

    [hH][eE][lL][pP]|--[hH][eE][lL][pP]|-[hH])
        echo -e "flags: ${blue}--list${reset}, ${blue}--check${reset}, ${blue}--install${reset}, ${blue}--uninstall${reset}, ${blue}--get${reset}, ${blue}--version${reset}, ${blue}--help${reset}

${yellow}--list${reset}: This argument is used simply and what it does is bring the 
    index.sh file and show the content to the user.

${yellow}--check${reset}: To use the check argument, enter the name of the package
    you want to search in the next parameter. Optionally, you can specify the 3rd argument
    for other distributions. You can control up to 1 package and 1 system base at a time.

${purple}${0} --check mypackage --rpm${reset}

${yellow}--install${reset}: After the install argument, specify which package you want to install
    as a parameter. The package will be automatically downloaded and directed to the
    installation according to your system infrastructure.

${purple}${0} --install mypackage${reset}

${yellow}--uninstall${reset}: Specify the package you want to delete as the parameter after the
    uninstall argument, your system will automatically be detected and you will be automatically
    directed to delete the package.

${purple}${0} --uninstall mypackage${reset}

${yellow}--get${reset}: It is used with a parameter next to the get argument.
    You must enter which package you want to download in this parameter.
    You can bring a maximum of 1 package
    each time.You can download a custom package as 3 arguments.
    Normally, it is automatically detected that you do not use this argument.

${purple}${0} --get mypackage --tar.gz${reset}

${yellow}--version${reset}: shows version, maintainer and main repository.

${yellow}--help${reset}: this shows the help menu.

Get My Package is not a package manager, it does not store metadata files,
it pulls all the data from the config files manually assigned in the git repository
and asks the package manager to install or remove the retrieved package that is compatible
with your system. This GMP has super unicorn powers. 
(also this unicorn emphasizes 'written as boranity but emphasizes the phrase pronounced as boraniti')
"
    exit 0
    ;;

    *)
        echo "unknown option use the '${0} --help' argument for detailed information."
        exit 1
    ;;
esac
seeyea
