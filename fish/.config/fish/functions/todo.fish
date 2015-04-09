function todo -a dir
    egrep --before-context=3 \
          --after-context=5 \
          --directories=recurse \
          --group-separator=(hr -) \
          --line-number \
          'TODO' $dir
end

