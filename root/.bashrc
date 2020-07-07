export EDITOR=/usr/bin/vim

alias ssh-add='ssh-add -t 28800'
alias rgrep='grep --color -i -R'
alias dayssinceepoch='echo $(($(date --utc --date "$1" +%s)/86400))'
alias wwget='wget --no-check-certificate --no-hsts --no-cache --header "User-Agent: wwget" -SO /dev/null'
alias ccurl='curl -H "Cache-Control: no-cache" -A "ccurl" -Lvsk -o /dev/null'
alias req='openssl req -noout -text -in'
alias x509='openssl x509 -noout -text -in'
alias rsa='openssl rsa -noout -text -in'
alias mv="`which mv` -iv"
alias pwg='pwgen -s 16 1'
alias cp="cp -i"                          # confirm before overwriting something
alias df='df -h'                          # human-readable sizes
alias free='free -m'                      # show sizes in MB
alias gitp='git add . && git commit --amend --no-edit --allow-empty && git push --force-with-lease'

alias ipt='ipt_function'
function ipt_function () {
while true; do nc -zv ${1} ${2} -w 1 ${3}; sleep 1; done
}

