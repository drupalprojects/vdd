package "vim" do
  action :install
end

template "/etc/vim/vimrc.local" do
  source "vim/vimrc"
end

vim_config_git "https://github.com/tpope/vim-pathogen"
vim_config_git "https://github.com/scrooloose/syntastic"

link "/etc/vim/autoload" do
  to "/etc/vim/bundle/vim-pathogen/autoload"
end