function bigdirs -a directory -a numfiles
    du -ah $directory ^/dev/null \
        | sort -r -h \
        | head -n $numfiles
end
