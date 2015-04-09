function bigfiles -a directory -a numfiles
    find $directory \
    -printf '%s %p\n' \
    -xdev \
    2>/dev/null \
        | sort -n -r \
        | head -n $numfiles \
        | numfmt --to=iec
end

