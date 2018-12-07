export NVM_DIR="/Users/mitchconquer/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm

## Ant
export ANT_HOME=/usr/local/bin/ant
export PATH=${PATH}:${ANT_HOME}/bin

## Sublime
# Must first run the following line and be sure ~/bin exists
# ln -s "/Applications/Sublime Text.app/Contents/SharedSupport/bin/subl" ~/bin/subl
export PATH=/bin:/sbin:/usr/bin:/usr/local/sbin:/usr/local/bin:$PATH
alias s='subl'

## VS Code
export EDITOR='code -w'
alias c='code'
alias vs='code'
alias vso='code .'

export PATH=$PATH:/Applications/Postgres.app/Contents/Versions/latest/bin
export PS1="\[\033[32m\]\[\033[1m👾 \[\033[0m\] \[\033[34m\]\w\[\033[0m\] \[\033[33m\]\$(parse_git_branch)\[\033[0m\] ✨  🚀  ✨\[\033[31m\]\n$\[\033[0m\] "
eval "$(thefuck --alias fuck)"

## Yarn
export PATH="$PATH:$HOME/.yarn/bin"

## GIT FUNCTIONS

parse_git_branch() {
   git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'
}

parse_git_branch_fancy() {
   git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ [\1]/'
}

commit_and_add_with_branch_name() {
   msg=$1                                      #pass the message argument along
   git commit -am "$msg - $(parse_git_branch)"                              #now, git command with the variables
}

commit_with_branch_name() {
  #pass the message argument along
  msg=$1
  #now, git command with the variables
  git commit -m "$msg - $(parse_git_branch)"
}

function gitLog() {
  if [ -z "$1" ]
    then
      git log --pretty=format:'%h - %an, %ar : %s'
    else
      git log --pretty=format:'%h - %an, %ar : %s' --since=$1.days
  fi
}

##GIT ALIASES

alias ga='git add .'
alias gst='git status'
alias gcm='git commit -m'
alias gcmbr=commit_with_branch_name $1
alias gcma='git commit -am'
alias gch='git checkout'
alias gpl='git pull'
alias gplro='git pull --rebase origin'
alias gpom='git pull origin master'
alias gpshm='git push heroku master'
alias gps='git push'
alias gdf='git diff'
alias gbr='git branch'
alias gfo='git fetch origin'
alias glg2='git log -p -2'
alias grpo='git remote prune origin'
alias gbw='grunt build; grunt watch'
alias gbclean='git branch --merged ${1-master} | grep -v " ${1-master}$" | xargs git branch -d;'
alias log=gitLog
alias glog='git log --oneline --decorate --graph'
alias gcmabr=commit_and_add_with_branch_name $1
# These have to be after 'gps' and 'gpl' are defined
push_origin_with_branch_name() {
   gps origin $(parse_git_branch)  #now, git command with the variables
}
pull_origin_with_branch_name() {
   gpl origin $(parse_git_branch)  #now, git command with the variables
}
alias gpsob=push_origin_with_branch_name
alias gplob=pull_origin_with_branch_name

##OTHER ALIASES

alias hk='heroku'
alias hkb='heroku run bash'
alias proj='cd ~/Projects'
alias otc='cd ~/Projects/climate-mcdev'
alias appterrain='echo "Launching AppTerrain...📲  🏞 " && vs ~/Projects/adoption-desk/ad-customer-dev &&  vs ~/Projects/adoption-desk/atadmin'
alias insights='cd ~/Projects/gonimbly-insights'
alias warehouse='cd ~/Projects/gonimbly-warehouse-api'
alias o='open'
alias ..='cd ..'
alias sbp='echo "Refreshing bash profile... ⚙️  🛠️  ⚙️  🛠" && source ~/.bash_profile'
alias cs1='ssh clearslide01'
alias cs2='ssh clearslide02'
alias rstcs1='ssh -t clearslide01 sudo /home/ec2-user/cssalesforcesyncnode/restart-clone.sh'
alias rstcs2='ssh -t clearslide02 sudo /home/ec2-user/cssalesforcesyncnode/restart-clone.sh'
alias restartcs='rstcs1 && rstcs2'

../.. () { cd ../..; }

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

# allows you to type sfdx cli commands with spaces instead of colons as separators
function sf {
  ARG_INDEX=0
  INDEX=0
  SFDX_COMMAND=""
  SFDX_COMMAND_PREFIX=""

  # Find index of first 
  for var in "$@"; do

    # If not 0 arg-indx == 0, then add to the sfdx command string
    if [[ $var == "-"* ]] && [ $ARG_INDEX == 0 ]; then

      ARG_INDEX=$INDEX

    fi

    if [[ $var == "help" ]] && [ -z "$SFDX_COMMAND_PREFIX" ] && [[ "$INDEX" < "1" ]]; then

      SFDX_COMMAND_PREFIX=" $var"

    elif [ "$ARG_INDEX" == "0" ] && [ -z $SFDX_COMMAND ]; then

      SFDX_COMMAND=$var

    elif [ "$ARG_INDEX" == "0" ]; then

      SFDX_COMMAND="$SFDX_COMMAND:$var"

    elif [ "$ARG_INDEX" > "0" ]; then
      SFDX_COMMAND="$SFDX_COMMAND $var"
    fi

    INDEX=`expr $INDEX + 1`
  done

  echo -e "\033[2msfdx$SFDX_COMMAND_PREFIX $SFDX_COMMAND\033[0m"
  eval "sfdx$SFDX_COMMAND_PREFIX $SFDX_COMMAND"
}
