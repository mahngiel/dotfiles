#Autostart Tmux
if [[ ! $TERM =~ screen ]]; then 
   exec tmux 
fi
