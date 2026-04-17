# Steps to run
brew install gh  # then clone repository
gh repo clone camwolff02/dotfiles
cd dotfiles
brew bundle --file .config/brewfile/Brewfile
stow -vt ~ .
