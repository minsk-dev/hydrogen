#!/usr/bin/env dash

# TODO add support for bash
# \033[38;2;<R>;<G>;<B>m
red="\033[38;5;1m"
blue="\033[38;5;4m"
reset="\033[m"
green="\033[38;5;2m"
set -eu

. "./dispatch.sh"


error() {
    echo "${red}[!]${reset} $1";
}

system() {
    echo "${blue}[!]${reset} $1"
}


dsample_command_hello () (
    echo "Hello World!"
)

dsample_option_version () ( echo "Version: <git>" )
dsample_option_help () {
    printf "Usage: hydro [OPTIONS] COMMAND [ARGS]...\n"
    printf "\nAuthor: Paulo Elienay <@paulo-e on GitHub>\n"
    printf "\nOptions:\n"
    printf "\tbootstrap\tbootstraps hydro"
    printf "\nFlags:\n"
    printf "\t--help\tshows this message\n"
    printf "\t\tuse 'hydro command --help' to get more info"
    echo
}

dsample_command_bootstrap () {
    HYDRO_FOLDER="${HOME}/.hydro"
    HYDROGENS_GIT="https://www.github.com/paulo-e/hydrogens"

    if [ ! -d "${HYDRO_FOLDER}" ]; then
        system "Hydro is getting set up for the first time..."
        mkdir -p "${HYDRO_FOLDER}/src/"
        mkdir -p "${HYDRO_FOLDER}{bin, lib}"
    else
        system "To bootstrap with hydro already set up the original '${HYDRO_FOLDER}' needs to be deleted"
        ask "Is that ok? [no] "
        read -r input
        if [ "${input-'yes'}" = "yes" ]; then
            rm -rf "$HYDRO_FOLDER"
        else
            error "Nothing left to do"
            exit 1
        fi
    fi

    cmd_exists git

    say "Cloning scripts repository..."
    git clone "${HYDROGENS_GIT}" "$HYDRO_FOLDER/src/.scripts"

    finish "Done!"
}

dsample_command_install () {
    HYDRO_FOLDER="${HOME}/.hydro"
    HYDRO_SCRIPTS="${HYDRO_FOLDER}/src/.scripts"

    ls "${HYDRO_SCRIPTS}"
}

dsample_ () {
    error "no operation specified (use --help)"
}

dsample_call_ () (error "invalid call")

dispatch dsample "$@"
