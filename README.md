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
fisher install plttn/fish-eza

# get the fish config file
mkdir -p ~/.config/fish
curl -sL https://raw.githubusercontent.com/laserson/dotfiles/master/config.fish > ~/.config/fish/config.fish

# especially good for remote machines
set --universal pure_color_hostname green
set --universal pure_color_at_sign green
set --universal pure_color_username_normal green
```


## Update dotfiles

Run `publish-dotfiles.sh`, whose contents is:

```shell
pushd ~/dotfiles
cp config.fish ~/.config/fish/
cp gitconfig ~/.gitconfig
cp gitignore_global ~/.gitignore
cp condarc ~/.condarc
popd
/usr/local/opt/micromamba/bin/micromamba shell init -s fish -p ~/micromamba
```

## Bootstrap micromamba

```shell
bash -c "$(curl https://micromamba.pfx.dev/install.sh)"
micromamba create -n default
micromamba activate default
micromamba install python=3.12 numpy scipy pandas matplotlib bokeh seaborn scikit-learn jupyterlab

# fix the conda prompt when using fish
micromamba config --set changeps1 False
```


## Setting up a new MacOS machine

Go through https://github.com/driesvints/dotfiles/blob/main/.macos to
customize settings or equivalent. See settings in the `macos` file in the repo.

Draw contacts from
- Fastmail
- Gmails/Google contacts
- iPhone/Apple contacts

Install Hack font.

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
cp sshconfig ~/.ssh/config
```

Consider Rectangle instead of Moom. (Config file in mathiasbynens.)




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
