bass source ~/.bashrc

set -x PATH /usr/local/bin $PATH

if status is-interactive
    # Commands to run in interactive sessions can go here
end

export SHELL=/usr/local/bin/fish

function peco_select_history_order
  if test (count $argv) = 0
    set peco_flags --layout=top-down
  else
    set peco_flags --layout=bottom-up --query "$argv"
  end

  history|peco $peco_flags|read foo

  if [ $foo ]
    commandline $foo
  else
    commandline ''
  end
end

function fish_user_key_bindings
  bind /cr 'peco_select_history_order' # Ctrl + R
end



pyenv init - | source

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/satsuta/libs/google-cloud-sdk/path.fish.inc' ]; . '/Users/satsuta/libs/google-cloud-sdk/path.fish.inc'; end

eval (nodenv init - | source)
eval (gh completion -s fish| source)

alias prsearch='gh pr list | fzf --prompt "pr preview>" --preview "echo {} | awk \'{print \$1}\' | xargs gh pr view" | awk "{print \$1}" | xargs gh pr view -w'