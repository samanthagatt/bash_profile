export PS1="\n\d, \t\n\w\n> "

alias rm="rm -vr"

# macOS uses BSD based code and supresses -v functionality when using -p
mkdir-pv() {
    for arg in $@; do
        dir=""
        IFS="/"
        read -ra ADDR <<< "$arg"
        for i in "${ADDR[@]}"; do
            dir+="$i/"
            if [ ! -d "$dir" ]; then
                mkdir -v "$dir"
            fi
        done
        IFS=" "
    done
}

mkcd() { mkdir-pv "$1" && cd "$1"; }

cra() { create-react-app "$1" && cd "$1"; }

mkcmpnt() {
    mkdir-pv "$1"
    touch "$1/$1.js" && echo "Created new file $1.js"
    touch "$1/$1.css" && echo "Created new file $1.css"
}
