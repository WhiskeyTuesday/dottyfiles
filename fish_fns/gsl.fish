function gsl --wraps='git stash list' --wraps='gs && gl' --wraps='clear && gs && gl' --description 'alias gsl clear && gs && gl'
  clear && gs && gl $argv; 
end
