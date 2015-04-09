function status_smiley -a arg_status
    set_color normal
    if [ $arg_status = 0 ]
        set_color -o green
        echo -n ':)'
    else
        set_color -o red
        echo -n ':('
    end
    set_color normal
end

