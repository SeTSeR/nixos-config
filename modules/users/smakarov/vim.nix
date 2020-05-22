{ config, pkgs, ... }: {
  home-manager.users.smakarov.programs.vim = {
    enable = true;
    settings = {
      background = "light";
      copyindent = false;
      directory = [ "~/.vim" ];
      expandtab = true;
      hidden = true;
      modeline = false;
      number = true;
      relativenumber = true;
      tabstop = 4;
      undodir = [ "~/.vim/undo" ];
    };
    plugins = with pkgs.vimPlugins; [
      auto-pairs
      vim-airline
      vim-airline-themes
      vim-wakatime
      vim-nix
      gruvbox
    ];
    extraConfig = ''
      set nocompatible
      set termguicolors

      set backspace=indent,eol,start

      set autoread
      set clipboard=unnamedplus
      set splitright

      set encoding=utf-8

      set ruler
      set noshowmode

      if !has('packages')
          execute pathogen#infect('pack/plugins/start/{}', 'pack/themes/opt/{}')
      endif

      set laststatus=2
      let g:airline_powerline_fonts = 1
      let g:airline#extensions#tabline#enabled = 1
      let g:airline#extensions#tabline#formatter = 'unique_tail'

      set noswapfile

      set cindent
      set shiftwidth=4
      set softtabstop=4
      set expandtab

      let g:netrw_browse_split = 4
      let g:netrw_winsize = 25

      filetype plugin indent on
      syntax enable
      colorscheme gruvbox

      set spelllang=ru,en
      au BufRead *.md setlocal spell

      autocmd FileType nix setlocal shiftwidth=2 tabstop=2 expandtab

      augroup Binary
          au!
          au BufReadPre  *.bin let &bin=1
          au BufReadPost * if &bin | %!xxd
          au BufReadPost * set ft=xxd | endif
          au BufWritePre * if &bin | %!xxd -r
          au BufWritePre * endif
          au BufWritePost * if &bin | %!xxd
          au BufWritePost * set nomod | endif
      augroup END

      set foldmethod=syntax
          '';
  };
}
