# Use location to run in background
cat /dev/location > /dev/null &

__git_ps1() {
  local git_branch
  git_branch=$(git rev-parse --abbrev-ref HEAD 2>/dev/null)
  if [[ $? -eq 0 ]]; then
    printf " (%s)" "$git_branch"
  fi
}

export PS1="\xee\x9c\x91 [\w]$(__git_ps1) "

alias ssh-unlock='pass ssh/id_rsa | ssh-add -t 4h -' 
alias switch-ish='cd ~/opt/ish-configs && ./ish-setup.sh'

# Start ssh-agent
SSH_ENV="$HOME/.ssh/agent-environment"

function start_agent {
    echo "Initialising new SSH agent..."
    /usr/bin/ssh-agent | sed 's/^echo/#echo/' > "${SSH_ENV}"
    echo succeeded
    chmod 600 "${SSH_ENV}"
    . "${SSH_ENV}" > /dev/null
    /usr/bin/ssh-add;
}

if [ -f "${SSH_ENV}" ]; then
    . "${SSH_ENV}" > /dev/null
    ps -ef | grep ${SSH_AGENT_PID} | grep ssh-agent$ > /dev/null || {
        start_agent;
    }
else
    start_agent;
fi
