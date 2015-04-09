function my-packages
    aptitude search '~i !~M !~pimportant !~prequired' -F '%p' --disable-columns | sort -u
end

