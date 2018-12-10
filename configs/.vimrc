colo cobalt
syntax on
set encoding=utf-8

/usr/share/vim/vim74/colors
/usr/share/vim/vim72/colors


description
nginx.vim highlights configuration files for nginx, the high-performance web server (see http://nginx.net).
 
install details
Download nginx.vim to ~/.vim/syntax/, and then add this line to ~/.vim/filetype.vim: 

au BufRead,BufNewFile /etc/nginx/*,/usr/local/nginx/conf/* if &ft == '' | setfiletype nginx | endif 

(adjust the path to your nginx installation)


$ mkdir -p ~/.vim/syntax/
$ wget http://www.vim.org/scripts/download_script.php?src_id=19394 -O ~/.vim/syntax/nginx.vim
$ cat > ~/.vim/filetype.vim <<EOF
au BufRead,BufNewFile /etc/nginx/*,/etc/nginx/conf.d/*,/usr/local/etc/nginx/* if &ft == '' | setfiletype nginx | endif
EOF
