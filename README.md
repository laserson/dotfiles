# Uri’s dotfiles


## Bootstrapping a server for fish shell

Install fish shell.

```shell
# Set the location of the fish executable
export PATH_TO_FISH=$(which fish)

# If not registered in /etc/shells, then add it.
sudo bash -c "echo $PATH_TO_FISH >> /etc/shells"

# If user missing from /etc/passwd, add it (Linux-only?)
# https://serverfault.com/questions/736471/how-do-i-change-my-default-shell-on-a-domain-account
getent passwd "$USER" | sudo tee -a /etc/passwd

# change default login shell
# chsh -s $PATH_TO_FISH
sudo chsh -s $PATH_TO_FISH $USER
```

Then run `fish` or logout/login.

Configure fish shell.

```shell
curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher
fisher install jethrokuan/z
fisher install edc/bass
fisher install pure-fish/pure
# if you have eza installed, install the fish shell wrapper
fisher install plttn/fish-eza

# get the fish config file
mkdir -p ~/.config/fish
curl -sL https://raw.githubusercontent.com/laserson/dotfiles/master/config.fish > ~/.config/fish/config.fish

# For remote machines, execute these options
set --universal pure_color_hostname green
set --universal pure_color_at_sign green
set --universal pure_color_username_normal green
```


## Bootstrap micromamba

```shell
bash -c "$(curl https://micromamba.pfx.dev/install.sh)" < /dev/null
# the above command initializes the shell too, but otherwise run:
# /path/to/micromamba shell init -s fish -p ~/micromamba
# comment the "< /dev/null" to not use default paths etc
source ~/.config/fish/config.fish
micromamba create -n default
micromamba activate default
micromamba install -y python=3.12 numpy scipy pandas matplotlib bokeh seaborn scikit-learn jupyterlab

# fix the conda prompt when using fish
micromamba config set changeps1 False
```

## Bootstrap tmux

```shell
# brew install tmux
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
curl -sL https://raw.githubusercontent.com/laserson/dotfiles/master/tmux.conf > ~/.tmux.conf
```

Start tmux and press `prefix I` to install plugins.


## Setting up a new MacOS machine

Remap CapsLock to Ctrl in System Prefs => Keyboard => Keyboard shortcuts => Modifier keys

Go through https://github.com/driesvints/dotfiles/blob/main/.macos to
customize settings or equivalent. See settings in the `macos` file in the repo.

Install Cursor
Install 1Password
Install Hack font
Install Hidden Bar
Install Rectangle
Install LaunchControl. Set up Tiller cron job.
Download XScreenSaver

Run through MacOS Settings

Transfer stuff in ~/.config using AirDrop

### Terminal-related stuff

- Set up Solarized theme for Terminal
- Set up SSH keys as necessary. Can transfer from other machines.
- Install homebrew
- Install fish shell with homebrew and see instructions for bootstrapping a server for fish
- Install some useful homebrew packages

```
brew update
brew install coreutils
brew install git
brew install jq
brew install qsv
brew install wget
brew install grep
brew install eza
brew install difftastic
brew install ncdu
brew install openssh
brew install ack
brew install watch
brew install gh
```

- Create a `ul-dropbox` symlink
- Set up git/GitHub with `gh auth login`. Then clone this dotfiles repo.
- Set up git config, and edit as necessary

```shell
cp gitconfig ~/.gitconfig
cp gitignore_global ~/.gitignore
```

- Copy over the ssh config and modify the `IdentityFile` line appropriately

```shell
mkdir -p ~/.ssh
chmod 700 ~/.ssh
cp sshconfig ~/.ssh/config
```

### VSCode / Cursor stuff

Get Python to launch IPython: https://stackoverflow.com/questions/52310689/use-ipython-repl-in-vs-code

But I add a `-i`

```
"python.terminal.launchArgs": [
  "-m",
  "IPython",
  "--no-autoindent",
  "-i"
],
```

Dealing with remote editing, you might need to explicitly set these:

```
"remote.SSH.remotePlatform": {
  "172.*": "linux",
  "devenv": "linux"
},
"terminal.integrated.defaultProfile.linux": "bash",
```

GitHub Light Default theme

## ssh agent and config

To add private ssh key to Keychain:

```bash
/usr/bin/ssh-add --apple-use-keychain ~/.ssh/id_rsa
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


## Ancient history

### Bootstrap Neovim config

```shell
mkdir -p ~/.config/nvim/autoload/
curl -fLo ~/.config/nvim/autoload/plug.vim \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
cp ~/dotfiles/init.vim ~/.config/nvim/
nvim +PlugInstall +qall
```
