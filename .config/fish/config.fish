if status is-interactive
    # Commands to run in interactive sessions can go here
end

function fish_greeting
    fastfetch
end

switch (uname)
    case Linux
        set -gx PATH /home/linuxbrew/.linuxbrew/bin $PATH
    case Darwin
        # ...
end

alias vim nvim
