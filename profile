# Use location to run in background
cat /dev/location > /dev/null &

function git_branch () {
  local current_branch
  local git_branch
  current_branch=$(git branch 2>/dev/null | grep -e "^*")
  [[ $? == 0 ]] && git_branch=$(printf "${current_branch}" | awk "{print \"[\" \$2 \"]\"}") && printf "%s" "${git_branch}\n"
}

export PS1='$(git_branch) [\w] '

alias ssh-unlock='pass ssh/id_rsa | ssh-add -t 4h -' 
alias ish-switch='cd ~/opt/ish-configs && ./ish-setup.sh'
alias gpsup='git push --set-upstream origin $(git rev-parse --abbrev-ref HEAD)'

# Start ssh-agent
SSH_ENV="$HOME/.ssh/agent-environment"

function start_agent {
    /usr/bin/ssh-agent | sed 's/^echo/#echo/' > "${SSH_ENV}"
    chmod 600 "${SSH_ENV}"
    . "${SSH_ENV}" > /dev/null
}

if [ -f "${SSH_ENV}" ]; then
    . "${SSH_ENV}" > /dev/null
    ps -ef | grep ${SSH_AGENT_PID} | grep ssh-agent$ > /dev/null || {
        start_agent;
    }
else
    start_agent;
fi

# Use ~/.profile.d/custom if it exists
[[ -e ~/.profile.d/custom ]] && source ~/.profile.d/custom

# Start tmux
env | grep -iq tmux
if [[ $? != 0 ]]
then
    tmux
    exit
fi
