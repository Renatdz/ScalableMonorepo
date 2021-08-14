#!/bin/sh

# Jump to repository root
cd "$(git rev-parse --show-toplevel)"

# Install Oh My Zash
# sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Install Homebrew dependencies
installHomebrew='/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"'
command -v brew >/dev/null 2>&1 || eval $installHomebrew

brew update

brew install swiftgen || (brew upgrade swiftgen && brew cleanup swiftgen)
brew install swiftlint || (brew upgrade swiftlint && brew cleanup swiftlint)
brew install sourcery || (brew upgrade sourcery && brew cleanup sourcery)
brew install rbenv || (brew upgrade rbenv && brew cleanup rbenv)

sh -c "$(curl -Ls https://install.tuist.io)"

# Install Ruby
rbenv init
rbenv install `cat ./.ruby-version`

# Install bundler dependencies
gem install bundler
bundle install

# Install architecture template
echo "\Installing template..."
make template

# Generate project with Xcodegen
echo "\nGenerating project..."
make generate