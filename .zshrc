# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# MC start reading solution
alias mc="mc --nosubshell"

# RANDOM COLOR SCRIPT ###
colorscript random

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Source Aliases

for file in $HOME/.alias.d/*;
  do
    source $file
  done;

# source plugins
for file in $HOME/zsh-plugins/*;
  do
    source $file;
  done;


# SOURCE ZSH SYNTAX HIGHLIGHTING

source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlight.zsh
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh