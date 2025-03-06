" ====================================================
" ARQUIVO DE CONFIGURAÇÃO HÍBRIDO VIM/NEOVIM
" ====================================================

" Verifica se está rodando no Neovim (para comportamentos específicos)
let g:is_nvim = has('nvim') " 1 = NeoVim, 0 = Vim tradicional

" ====================================================
"            CONFIGURAÇÕES BÁSICAS
" ====================================================

" Ativa recursos visuais básicos
syntax on               " Habilita coloração sintática
set number             " Mostra números das linhas
set relativenumber     " Números relativos (distância da linha atual)
set cursorline         " Destaca linha onde está o cursor
set mouse=a            " Habilita mouse em todos os modos (a = all)

" Configuração de indentação e tabs
set tabstop=4          " Cada TAB mostra 4 espaços visuais
set softtabstop=4      " Número de espaços ao pressionar TAB/BACKSPACE
set shiftwidth=2       " Número de espaços para indentação automática
set expandtab          " Converte TABs em espaços físicos
set smarttab           " Indentação inteligente em diferentes contextos
set autoindent         " Mantém indentação da linha anterior
set smartindent        " Indentação inteligente baseada na sintaxe

" Configuração de busca
set incsearch          " Busca incremental (mostra resultados enquanto digita)
set ignorecase         " Ignora maiúsculas/minúsculas nas buscas
set smartcase          " Se a busca tiver maiúsculas, torna-se case-sensitive
set hlsearch           " Destaca todos os resultados da busca

" Outras configurações importantes
set hidden             " Permite trocar buffers sem salvar
set scrolloff=8        " Mantém 8 linhas de margem ao rolar
set colorcolumn=100    " Marca visual na coluna 100 (evita linhas longas)
set signcolumn=yes     " Coluna lateral para sinais (erros, avisos)
set cmdheight=2        " Altura da área de comandos (para mensagens)
set updatetime=100     " Tempo (ms) para operações assíncronas (ex: LSP)
set nobackup           " Não cria arquivos de backup (~)
set nowritebackup      " Não cria backup durante edição
set splitright         " Divide janelas verticais à direita
set splitbelow         " Divide janelas horizontais abaixo
set autoread           " Recarrega arquivos modificados externamente
set history=1000       " Aumenta histórico de comandos
set encoding=utf-8     " Codificação interna
set fileencoding=utf-8 " Codificação dos arquivos

" Configuração de clipboard integrado (copiar e colar com ambiente externo ao aditor)
if has('clipboard')
  if has('unnamedplus') " Linux/Windows com suporte a clipboard
    set clipboard=unnamedplus
  else                " macOS ou sistemas mais antigos
    set clipboard=unnamed
  endif
endif

" ====================================================
"           GERENCIAMENTO DE PLUGINS (VIM)
" ====================================================
if !g:is_nvim " Configuração específica para Vim tradicional

  " Instala o vim-plug se não existir
  if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
      \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
  endif

  " Lista de plugins (exemplos básicos)
  call plug#begin('~/.vim/plugged')
    Plug 'tpope/vim-fugitive' " Integração com Git
    Plug 'preservim/nerdtree' " Navegador de arquivos
  call plug#end()

endif

" ====================================================
"       CONFIGURAÇÃO LUA (SOMENTE PARA NEOVIM)
" ====================================================
if g:is_nvim
  " Adiciona caminho para módulos Lua
  lua package.path = package.path .. ';' .. vim.fn.expand('~/.config/nvim/lua/?.lua')

  " Carrega configuração principal em Lua
  lua require('config') " Arquivo: ~/.config/nvim/lua/config.lua

  " Garante caminhos corretos para configuração do Neovim
  set runtimepath^=~/.config/nvim
endif

" ====================================================
"              MAPEAMENTOS DE TECLAS
" ====================================================
let mapleader = '\' " Define a tecla líder (prefixo para atalhos)

" Recarregar configuração (comportamento diferente por editor)
if g:is_nvim
  " Neovim: Atualiza plugins Lazy.nvim
  nnoremap <leader>rr :source $MYVIMRC <bar> Lazy sync<CR>
else
  " Vim: Atualiza plugins vim-plug
  nnoremap <leader>rr :source $MYVIMRC <bar> PlugInstall<CR>
endif

" Limpar destaque de buscas
nnoremap <silent> <leader>h :nohlsearch<CR>

" Navegador de arquivos (apenas no Vim com NERDTree)
if !g:is_nvim
  nnoremap <leader>n :NERDTreeToggle<CR>
endif

" ====================================================
"          CONFIGURAÇÕES ADICIONAIS
" ====================================================
filetype on           " Habilita detecção de tipo de arquivo
filetype plugin on    " Carrega plugins específicos por tipo
filetype indent on    " Carrega regras de indentação específicas

" ====================================================
"          MENSAGENS INICIAIS
" ====================================================
autocmd VimEnter * echo "Editor configurado! Comandos úteis:\n"
      \ . "  :nmap          - Listar atalhos\n"
      \ . "  :e $MYVIMRC    - Editar configuração\n"
      \ . (g:is_nvim ? 
      \   "  :Lazy install  - Instalar plugins Lua" : 
      \   "  :PlugInstall   - Instalar plugins Vim")

" Confirmação de carregamento
autocmd VimEnter * echo "\nConfiguração carregada com sucesso! ✅"

" ====================================================
"          NOTAS DE INSTALAÇÃO
" ====================================================
"
" ESTRUTURA DE ARQUIVOS (Linux):
" Para Neovim:
"   ~/.config/nvim/
"   ├── init.vim          (este arquivo)
"   └── lua/
"       └── config.lua    (configurações em Lua)
"
" Para Vim tradicional:
"   ~/.vimrc              (este arquivo)
"
" APÓS INSTALAR:
" 1. Vim: Executar :PlugInstall
" 2. Neovim: Executar :Lazy install
" ==================================================== 