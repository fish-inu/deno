set -e

convert() {
    mds=$(find docs -type f -name '*.md')
    eval "arr=($mds)"
    for path in ${arr[@]}; do
        echo "正在转换 ${path}"
        docs_removed=${path##docs/}
        ext2pot=${docs_removed%.md}.pot
        #awk '/; charset=CHARSET/{sub("CHARSET", "UTF-8");print;next} {print}' docs-zh/${docs_removed%.md}.zh.po > temp && mv temp docs-zh/${docs_removed%.md}.zh.po
        #$HOME/Downloads/po4a-0.61/po4a-gettextize --format text -o markdown --master $path --master-charset "UTF-8" --po docs-zh/${ext2pot}
        msgmerge --previous --update docs-zh/runtime/${docs_removed%.md}.zh.po docs-zh/runtime/${ext2pot}
        #cp docs-zh/${ext2pot} docs-zh/${ext2pot%.pot}.zh_Hans.po
        echo "---OK---"
    done
}

updatepo() {
    shopt -s extglob
    while read pot; do
        msgmerge --previous --update ${pot%.pot}.zh.po $pot
    done < <(ls docs-zh/!(getting_started)/*.pot)
}

updatepo