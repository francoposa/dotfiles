# Show current directory in command prompt, truncating where it can
# https://stackoverflow.com/questions/25090295/how-to-you-configure-the-command-prompt-in-linux-to-show-current-directory
export PS1="[%~]%% "

# PYENV
export PYENV_VERSION=3.8.3
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi  # adds ~/.pyenv/shims to the beginning of PATH

# VIRTUALENVWRAPPER
# Initalize virtualenvwrapper so commands are available
pyenv virtualenvwrapper
# This is the default, but prefer explicit over implicit
export WORKON_HOME=$HOME/.virtualenvs

# POETRY
export PATH=$PATH:$HOME/.poetry/bin

# This is the default, but prefer explicit over implicit
export GOPATH=$HOME/go

# Make your binary executables available anywhere on the machine 
export PATH=$PATH:$GOPATH/bin

# THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
# Added automatically by sdkman
# Seems to work fine even if it is not at the end of .zshrc, I assume it just doesn't want the PATH
# getting pre-empted by something else that would put another SDK ahead of the sdkman ones
export SDKMAN_DIR="/Users/franco/.sdkman"
[[ -s "/Users/franco/.sdkman/bin/sdkman-init.sh" ]] && source "/Users/franco/.sdkman/bin/sdkman-init.sh"

echo $PATH
