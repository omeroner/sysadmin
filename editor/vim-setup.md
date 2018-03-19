### Vim Templateleri

Bknz. [http://vimcolors.com/](http://vimcolors.com/)

### Color Shema Kullanımı

`:colorscheme delek`

`:color delek`

### Color Shema Dizini

`/usr/share/vim/vim74/colors/`

### Color Shema Installation

".vim" dosyasını aşağıdaki path'e kopyala

`~/.vim/colors`

Geçici olarak değiştirmek için aşağıdaki komutu kullan

`":colorscheme cobalt"`


### Specifik Colorscheme Set Etme 
`vim ~/.vimrc`

    colo desert
    syntax on

###  örnek .vimrc config dosyası
https://github.com/omeroner/sysadmin/blob/master/configs/.vimrc



https://gist.github.com/ralavay/c4c7750795ccfd72c2db

vim-nginx-conf-highlight.sh

```
#!/bin/bash
#
# Highligh Nginx config file in Vim

# Download syntax highlight
mkdir -p ~/.vim/syntax/
wget http://www.vim.org/scripts/download_script.php?src_id=19394 -O ~/.vim/syntax/nginx.vim

# Set location of Nginx config file
cat > ~/.vim/filetype.vim <<EOF
au BufRead,BufNewFile /etc/nginx/*,/etc/nginx/conf.d/*,/usr/local/nginx/conf/* if &ft == '' | setfiletype nginx | endif
EOF
```
