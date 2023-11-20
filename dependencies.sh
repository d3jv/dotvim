#!/bin/bash

USAGE="Usage: $(basename $0) install|remove|help [-n name]"
ARG="$1"

if [[ $# -lt 1 ]]; then
    echo $USAGE
    exit 1
fi


if [ "$1" = "help" ]; then
    echo $USAGE
    echo "Supported packages: asciidoc, plantuml"
    exit 0
fi

if ! [[ $ARG == 'remove' || $ARG == 'install' ]]; then
    echo $USAGE
    exit 42
fi

shift
getopts 'n:' OPTION
case $OPTION in
    n)
        NAME=$OPTARG
        ;;
    ?)
        echo "Wrong option: $OPTION" >&2
        echo $USAGE
        exit 1
        ;;
esac

asciidoc_install() {
    gem -v >/dev/null 2>/dev/null || sudo apt-get install ruby
    sudo apt-get install asciidoctor ruby-asciidoctor-pdf
    sudo gem install asciidoctor-diagram asciidoctor-rouge
}

asciidoc_remove() {
    sudo apt-get remove asciidoctor ruby-asciidoctor-pdf
    sudo gem remove asciidoctor-diagram asciidoctor-rouge
    echo "Don't forget to remove asciidoc settings from vimrc."
}

plantuml_install() {
    sudo apt install graphviz
}

plantuml_remove() {
    sudo apt remove graphviz
}

# TODO: actually instal it properly
fff_install() {
    echo "cd /usr/local/src"
    echo "git clone https://github.com/dylanaraps/fff.git"
    echo "cd fff"
    echo "make PREFIX=/usr/local/sbin install && mv /usr/local/sbin/bin/fff /usr/local/sbin && rmdir /usr/local/sbin/bin"
}

fff_remove() {
    echo "cd /usr/local/src/fff && make uninstall"
}

case $NAME in
    asciidoc)
        asciidoc_$ARG
        ;;
    plantuml)
        plantuml_$ARG
        ;;
    fff)
        fff_$ARG
        ;;
    *)
        echo "Package $NAME isn't supported by this script."
        exit 1
        ;;
esac

exit 0

