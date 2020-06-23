# Defined in - @ line 1
function ssh --description 'alias ssh=env TERM=xterm-256color ssh'
	env TERM=xterm-256color ssh $argv;
end
