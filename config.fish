# set vi-style bindings but keep ctrl-F for autocomplete
function fish_user_key_bindings
    fish_vi_key_bindings
    for mode in insert default visual
        bind -M $mode \cf forward-char
    end
end
set -g fish_key_bindings fish_user_key_bindings


# variable "exports"
set -g -x EDITOR "nvim"
set JAVA_HOME (/usr/libexec/java_home)


# Set path
# homebrew
if test -d /usr/local/bin
    set -g fish_user_paths "/usr/local/sbin" "/usr/local/bin" $fish_user_paths
end
# updated gnu tools
if test -d /usr/local/opt/coreutils/libexec/gnubin
    set -g fish_user_paths "/usr/local/opt/coreutils/libexec/gnubin" $fish_user_paths
    set MANPATH "/usr/local/opt/coreutils/libexec/gnuman:$MANPATH"
end


# functions/aliases
alias g git
alias t todo.sh
alias o open
alias j z  # jump directories with j instead of z
# cd shortcuts
function ...
  ../..
end
function ....
  ../../..
end
function .....
  ../../../..
end
# App shortcuts
function s
    if count $argv > /dev/null
        subl -n $argv
    else
        subl -n .
    end
end
function Rstudio
    if count $argv > /dev/null
        open -na Rstudio $argv
    else
        open -na Rstudio .
    end
end
