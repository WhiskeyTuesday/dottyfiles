function ll --wraps='ls -l' --wraps='ls -lh' --description 'alias ll ls -lh'
  ls -lh $argv; 
end
