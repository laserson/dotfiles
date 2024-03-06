# Uri’s dotfiles


## Bootstrapping a server for fish shell

Install fish shell, then set it as the default shell:

```shell
# NEED TO SET
PATH_TO_FISH=/usr/local/bin/fish
PATH_TO_FISH=/opt/homebrew/bin/fish

sudo bash -c "echo $PATH_TO_FISH >> /etc/shells"
chsh -s $PATH_TO_FISH

fish

curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher
fisher install jethrokuan/z
fisher install edc/bass
fisher install pure-fish/pure

# or copy the config.fish file from here
mkdir -p ~/.config/fish
curl -sL https://raw.githubusercontent.com/laserson/dotfiles/master/config.fish > ~/.config/fish/config.fish

# especially good for remote machines
set --universal pure_color_hostname green
set --universal pure_color_at_sign green
set --universal pure_color_username_normal green

# if lsd installed
if test (which lsd)
    alias -s ls="lsd"
    alias -s l="ls -l"
    alias -s ll="ls -l"
    alias -s la="ls -a"
    alias -s lla="ls -la"
    alias -s lt="ls --tree"
end
```

## Fix conda prompt with fish

```shell
conda config --set changeps1 False
```

## Bootstrap Neovim config

```shell
mkdir -p ~/.config/nvim/autoload/
curl -fLo ~/.config/nvim/autoload/plug.vim \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
cp ~/dotfiles/init.vim ~/.config/nvim/
nvim +PlugInstall +qall
```
## Update dotfiles

Run `publish-dotfiles.sh`, whose contents is:

```shell
pushd ~/dotfiles
cp config.fish ~/.config/fish/
cp gitconfig ~/.gitconfig
cp gitignore_global ~/.gitignore
cp init.vim ~/.config/nvim
cp condarc ~/.condarc
popd
/usr/local/opt/micromamba/bin/micromamba shell init -s fish -p ~/micromamba
```



## Setting up a new MacOS machine

Terminal-related stuff

- Set up Solarized theme for Terminal
- Set up SSH keys as necessary. Can transfer from other machines.
- Install homebrew
- Install fish shell and see instructions for bootstrapping a server for fish


1.  Set computer name (under Sharing in System Preferences)
2.  Install homebrew (see reqs there for installing Xcode).
3.  Create ~/.ssh (700) and transfer ssh keys if necessary. (You can scp the
    files from one to the other.  Also transfer config.)
4.  Checkout this repo into ~/dotfiles
5.  Install whatever homebrew and homebrew cask packages listed below.
6.  Install Python using `install_conda.sh`.
7.  Install R and Rstudio.
8.  Install the "Hack" font.
9.  `mkdir ~/tmp`
10. Go through https://github.com/mathiasbynens/dotfiles/blob/master/.macos to
    customize and execute. Diff it against the `macos` file currently in the
    repo.
11. Apply Solarized theme for Terminal in this directory.
12. Install Dropbox
13. Create symlink to Dropbox called `ul-dropbox`
14. Remap CAPS to Esc (using System Preferences)

Useful homebrew commands

```shell
brew update
brew install coreutils
brew install bash
brew install fish
brew install wget
brew install neovim
brew install git
brew install glib
brew install gfortran
brew install iftop
brew install jq
brew install grep
brew install openssh
brew install ack
brew install boost # LONG TIME
brew install cmake
brew install csshx
brew install fftw
brew install libffi
brew install llvm --with-clang --with-rtti --with-python  # LONG TIME
brew install lsd
brew install imagemagick --with-webp
brew install maven
brew install mercurial
brew install protobuf
brew install pup
brew install readline
brew install ruby
brew install sbt
brew install scala # needs Java first
brew install snappy
brew install thrift
brew install tmux
brew install tree
brew install vbindiff
brew install watch
brew install webkit2png
brew install xz
brew install zinc
```

Useful homebrew cask commands

```shell
brew cask install dozer
brew cask install dropbox
brew cask install firefox
brew cask install google-chrome
brew cask install intellij-idea
brew cask install java
brew cask install mendeley-desktop
brew cask install moom
brew cask install rstudio
brew cask install seil
brew cask install slack
brew cask install spotify
brew cask install sublime-text
brew cask install transmission
brew cask install vlc
```

Consider Spectacle instead of Moom. (Config file in mathiasbynens.)

Get Material theme for Sublime.

Consider diff-so-fancy for git.


## ssh agent

To add private ssh key to Keychain:

```bash
/usr/bin/ssh-add -K ~/.ssh/id_rsa
```

Note the absolute path to use the OS X-supplied ssh-add which integrates with
Keychain.  If you installed openssh with homebrew, make sure that it's not
linked, or the homebrewed version will be run by default.

Modify the ~/.ssh/config file to add

```
Host *
  UseKeychain yes
  AddKeysToAgent yes
  IdentityFile ~/.ssh/id_rsa
```

with an `IdentityFile` line for each private key you want attempted.

See StackOverflow: https://apple.stackexchange.com/questions/48502


## Insert ISO8601 date

Use the following Applescript in Automator with no input.

```applescript
on run {input, parameters}
	set date_string to do shell script "date +'%Y-%m-%d'"
	tell application "System Events" to keystroke date_string
	return input
end run
```

# launchd

Remember to check all the regular jobs with LaunchControl
