#!/usr/bin/env bash

# Install command-line tools using Homebrew.

# Make sure we’re using the latest Homebrew.
brew update

# Upgrade any already-installed formulae.
brew upgrade

# Install GNU core utilities (those that come with macOS are outdated).
# Don’t forget to add `$(brew --prefix coreutils)/libexec/gnubin` to `$PATH`.
brew install coreutils

# Install some other useful utilities like `sponge`.
brew install moreutils
# Install GNU `find`, `locate`, `updatedb`, and `xargs`, `g`-prefixed.
brew install findutils
# Install GNU `sed`, overwriting the built-in `sed`.
brew install gnu-sed --with-default-names
# Install Bash 4.
# Note: don’t forget to add `/usr/local/bin/bash` to `/etc/shells` before
# running `chsh`.
brew install bash
brew install bash-completion2

# Switch to using brew-installed bash as default shell
if ! fgrep -q '/usr/local/bin/bash' /etc/shells; then
  echo '/usr/local/bin/bash' | sudo tee -a /etc/shells;
  chsh -s /usr/local/bin/bash;
fi;

# Install `wget` with IRI support.
brew install wget --with-iri

# Install GnuPG to enable PGP-signing commits.
brew install gnupg

# Install more recent versions of some macOS tools.
brew install vim --with-override-system-vi
brew install grep
brew install openssh
brew install screen
brew install homebrew/php/php56 --with-gmp

# Install other useful binaries.
brew install ack
brew install boost # LONG TIME
brew install cmake
brew install csshx
brew install dark-mode
#brew install exiv2
brew install fftw
brew install gfortran
brew install git
brew install git-lfs
brew install glib
brew install iftop
brew install imagemagick --with-webp
brew install jq
brew install libffi
brew install llvm --with-clang --with-rtti --with-python  # LONG TIME
brew install lua
brew install lynx
brew install maven
brew install mercurial
brew install openssl
brew install p7zip
brew install pigz
brew install protobuf
brew install pv
brew install r
brew install readline
brew install rename
brew install rlwrap
brew install rhino
brew install ruby
brew install sbt
brew install scala  # needs Java first
brew install snappy
brew install speedtest_cli
brew install ssh-copy-id
brew install testssl
brew install thrift
brew install tmux
brew install tree
brew install vbindiff
brew install watch
brew install webkit2png
brew install xz
brew install zinc
brew install zopfli

# some improvements from https://remysharp.com/2018/08/23/cli-improved
brew install fzf
$(brew --prefix)/opt/fzf/install
brew install diff-so-fancy
git config --global core.pager "diff-so-fancy | less --tabs=4 -RFX"
brew install fd
brew install ncdu
brew install tldr


# Remove outdated versions from the cellar.
brew cleanup
