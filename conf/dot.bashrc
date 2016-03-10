## Custom: Everything below this line is auto-edited by vagrant setup.sh scripts

# for golang
export PATH=$PATH:./bin:/usr/local/go/bin

# for autoenv (used to setup golang GOPATH if a .env file is found)
source `which activate.sh`

# source a bash aliases file if it exists
if [ -f ~/.bash_aliases ] ; then
   source ~/.bash_aliases
fi
