function short_pwd
    pwd | sed -e "s|^$HOME|~|"
end

