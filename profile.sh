export PS1="\n\d, \t\n\w\n> "

alias rm="rm -vr"
alias c="clear"

updateprof() { source ~/.bash_profile; }
openprof() { code ~/.bash_profile; }

# macOS uses BSD based code and supresses -v functionality when using -p
mkdir() {
    for arg in $@; do
        dir=""
        IFS="/"
        read -ra ADDR <<< "$arg"
        for i in "${ADDR[@]}"; do
            dir+="$i/"
            if [ ! -d "$dir" ]; then
                command mkdir -v "$dir"
            fi
        done
        IFS=" "
    done
}

mkcd() { mkdir "$1" && cd "$1"; }

cra() {
    create-react-app "$1" && cd "$1"
    mkdir src/components/App &&
    mv src/App.js src/App.css src/App.test.js src/components/App &&
    sed -i '' 's;\./App;\./components/App/App;g' src/index.js &&
    sed -i '' 's;\./logo\.svg;\.\./\.\./logo\.svg;g' src/components/App/App.js
    if [ "$#" -eq  "2" ]; then
        git remote add origin "$2"
        git add .
        git commit -m "Reorganizes App files into components directory"
        git push -u origin master
    fi
}

mkcmpnt() {
    command mkdir -v "src/$1" &&
    touch "src/$1/$1.js" && echo "Created new file src/$1/$1.js"
    touch "src/$1/$1.css" && echo "Created new file src/$1/$1.css"
}
