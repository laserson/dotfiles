# set vi-style bindings but keep ctrl-F for autocomplete
function fish_user_key_bindings
    fish_vi_key_bindings
    for mode in insert default visual
        bind -M $mode \cf forward-char
    end
end
set -g fish_key_bindings fish_user_key_bindings


# variable "exports"
if test (which nvim)
    set -g -x EDITOR "nvim"
else
    set -g -x EDITOR "vim"
end


# add homebrew to path
if test -x /opt/homebrew/bin/brew
    set -g HOMEBREW_EXEC /opt/homebrew/bin/brew
else if test -x /usr/local/bin/brew
    set -g HOMEBREW_EXEC /usr/local/bin/brew
end
if set -q HOMEBREW_EXEC
    set -g HOMEBREW_PREFIX ($HOMEBREW_EXEC --prefix)
    set -g fish_user_paths "$HOMEBREW_PREFIX/sbin" "$HOMEBREW_PREFIX/bin" $fish_user_paths
    # updated gnu tools (brew install coreutils)
    if test -d $HOMEBREW_PREFIX/opt/coreutils/libexec/gnubin
        set -g fish_user_paths "$HOMEBREW_PREFIX/opt/coreutils/libexec/gnubin" $fish_user_paths
        set MANPATH "$HOMEBREW_PREFIX/opt/coreutils/libexec/gnuman:$MANPATH"
    end
end


# functions/aliases
alias g git
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

alias mad="micromamba activate default"
alias mm="micromamba"
