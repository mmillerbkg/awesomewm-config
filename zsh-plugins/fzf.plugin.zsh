FZF_BASE="/usr/share/fzf"


function setup_using_base_dir() {
    local fzf_base fzf_shell fzfdirs dir

    test -d "${FZF_BASE}" && fzf_base="${FZF_BASE}"

    if [[ -z "${fzf_base}" ]]; then
        fzfdirs=(
          "${HOME}/.fzf"
          "${HOME}/.nix-profile/share/fzf"
          "${XDG_DATA_HOME:-$HOME/.local/share}/fzf"
          "/usr/local/opt/fzf"
          "/usr/share/fzf"
          "/usr/local/share/examples/fzf"
        )
        for dir in ${fzfdirs}; do
            if [[ -d "${dir}" ]]; then
                fzf_base="${dir}"
                break
            fi
        done

        if [[ -z "${fzf_base}" ]]; then
            if (( ${+commands[brew]} )) && dir="$(brew --prefix fzf 2>/dev/null)"; then
                if [[ -d "${dir}" ]]; then
                    fzf_base="${dir}"
                fi
            fi
        fi
    fi

    if [[ ! -d "${fzf_base}" ]]; then
        return 1
    fi

    # Fix fzf shell directory for Arch Linux, NixOS or Void Linux packages
    if [[ ! -d "${fzf_base}/shell" ]]; then
        fzf_shell="${fzf_base}"
    else
        fzf_shell="${fzf_base}/shell"
    fi

    # Setup fzf binary path
    if (( ! ${+commands[fzf]} )) && [[ "$PATH" != *$fzf_base/bin* ]]; then
        export PATH="$PATH:$fzf_base/bin"
    fi

    # Auto-completion
    if [[ -o interactive && "$DISABLE_FZF_AUTO_COMPLETION" != "true" ]]; then
        source "${fzf_shell}/completion.zsh" 2> /dev/null
    fi

    # Key bindings
    if [[ "$DISABLE_FZF_KEY_BINDINGS" != "true" ]]; then
        source "${fzf_shell}/key-bindings.zsh"
    fi
}



if [[ -z "$FZF_DEFAULT_COMMAND" ]]; then
    if (( $+commands[rg] )); then
        export FZF_DEFAULT_COMMAND='rg --files --hidden --glob "!.git/*"'
    elif (( $+commands[fd] )); then
        export FZF_DEFAULT_COMMAND='fd --type f --hidden --exclude .git'
    elif (( $+commands[ag] )); then
        export FZF_DEFAULT_COMMAND='ag -l --hidden -g "" --ignore .git'
    fi
fi