set -e
mds=$(find docs -type f -name '*.md')
eval "arr=($mds)"

for path in ${arr[@]}; do
    echo "正在转换 ${path}"
    docs_removed=${path##docs/}
    ext2pot=${docs_removed%.md}.pot
    $HOME/Downloads/po4a-0.61/po4a-gettextize --format text --master $path --master-charset "UTF-8" --po docs-zh/${ext2pot}
    #cp docs-zh/${ext2pot} docs-zh/${ext2pot%.pot}.zh_Hans.po
    echo "---OK---"
done    
