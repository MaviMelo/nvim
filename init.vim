
  " ====================================================
  "ARQUIVO DE CONFIGURAÇÃO HÍBRIDO VIM/NEOVIM
  " ====================================================

  " Verifica se está rodando no Neovim (para comportamentos específicos)
  let g:is_nvim = has('nvim') " bite 1 = NeoVim, bite 0 = Vim tradicional
       
  " ====================================================
  "            CONFIGURAÇÕES BÁSICAS
  " ====================================================

  " Ativa recursos visuais básicos e exibição
  syntax enable           " Habilita coloração sintática

if !g:is_nvim         " para Vim

  colorscheme wildcharm    " Define o tema de cores (ex.: pablo, wildcharm, desert, darkblue...)

  " Destaques de sintaxe (certos terminais pode não suportar algumas dessas configurações)

  highlight Comment guifg=#565f89 gui=italic  " Define a cor e o estilo dos comentários no código
  highlight String guifg=#9ece6a              " Cor das STRINGS
  highlight Number guifg=#ff9e64              " Cor dos números no código
  highlight Keyword guifg=#7aa2f7 gui=bold    " Cor e estilo das palavras-chave (como if, for)
  highlight Function guifg=#bb9af7            " Define a cor dos nomes de funções
  highlight Identifier guifg=#73daca          " Cor de identificadores (variáveis, nomes de classes)
  highlight Type guifg=#7aa2f7                " Tipos de dados (como int, string, boolean)
  highlight Delimiter guifg=#00ff00           " Cor de caracteres como {}, (), [], ,, ;, etc
  " highlight CursorLine guibg=#2a2b3d          " Cor da linha do cursor
  highlight LineNr guifg=#565f89              " Cor dos Números de linha
  highlight Visual guibg=#383645              " Destaque de seleção
  " set background=dark                     " Cor de plano de fundo. para claro usar 'light'
  highlight StatusLine guibg=#444444 guifg=#eeeeee   " barra de status (linha inferior do Vim)
  " highlight Normal guibg=#111010 guifg=#ffffff    " cor de fundo e tema geral 
  " highlight Normal guibg=#000120 guifg=#ffffff  " cor de fundo e tema geral azul escuro
  " highlight Normal guibg=#1a1b26 guifg=#a9b1d6   " cor de fundo e tema geral deserto

endif

  highlight MatchParen guifg=#ff6200 guibg=#eff218 gui=bold    " destacar colchetes, chaves e parênteseis com o cursor 
  

  set laststatus=2       " Exibe a barra de status sempre
  set wildmenu           " Exibe menu de sugestões de comandos incompletos
  set termguicolors      " Habilita cores verdadeiras (24-bit) 
  set number             " Mostra números das linhas
  set relativenumber     " Números relativos (distância da linha atual)
  set cursorline         " Destaca linha onde está o cursor
  set mouse=a            " Habilita mouse em todos os modos (a = all)
  set showcmd            " Exibe comandos digitados parcialmente na barra de estatus
  set cmdheight=8        " Altura da barra de comandos em número de linhas

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
  set colorcolumn=90    " Marca visual (guia) na enésima coluna (evitar linhas longas)
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
    plug 'wfxr/minimap.vim'   " Mini mapa lateral da página (:Minimapa<Tab>)
  call plug#end()

    " --- Configurações Opcionais para o Minimapa (ajuste a gosto) ---
  let g:minimap_width = 10              " Largura do minimapa (em colunas de caracteres)
  let g:minimap_auto_start = 1          " Inicia o minimapa automaticamente 
  let g:minimap_highlight_range = 1     " Destaca a área visível do seu código no minimapa
  let g:minimap_enable_animation = 1    " Habilita animação suave de rolagem
  let g:minimap_scroll_delay = 1        " Tempo de atraso para a rolagem (em milissegundos)
  let g:minimap_auto_refresh = 1        " Refresh automático no minimapa quando o buffer muda
  let g:minimap_refresh_interval = 200  " Intervalo de refresh (em milissegundos)


endif

 set runtimepath^=~/.config/nvim  

" ====================================================
"              MAPEAMENTOS DE TECLAS
" ====================================================
let mapleader = '\' " Define a tecla líder (prefixo para atalhos)

" Recarregar configuração (comportamento diferente por editor)
if g:is_nvim
  " neovim: Atualiza plugins Lazy.nvim
  nnoremap <leader>rr :source $MYVIMRC <bar> Lazy sync<CR>
else
  " vim: Atualiza plugins vim-plug
  nnoremap <leader>rr :source $MYVIMRC <bar> PlugInstall<CR>
  " Carrega arquivo.ts (TypeScript) no buffer atual com ts-node (se estiver instalado) 
  nnoremap <leader>r :!ts-node --compiler-options '{"module":"commonjs"}' %<CR>
endif

" Limpar destaque de buscas
nnoremap  <leader>h :nohlsearch<CR>

" Navegador de arquivos natico (Netrw)
"if !g:is_nvim
  nnoremap <leader>n :Lex 30<CR>
"endif

" ====================================================
"          CONFIGURAÇÕES ADICIONAIS
" ====================================================
filetype on           " Habilita detecção de tipo de arquivo
filetype plugin on    " Carrega plugins específicos por tipo
filetype indent on    " Carrega regras de indentação específicas

if !g:is_nvim         " para Vim

" Altera o cursor dependendo do modo
if &term =~ 'xterm\|rxvt\|kitty'
    let &t_SI = "\<Esc>[6 q"  " Modo Insert: cursor vertical
    let &t_EI = "\<Esc>[3 q"  " Modo Normal: cursor underline piscante
    let &t_SR = "\<Esc>[4 q"  " Modo Replace: cursor underline
endif
"-----------------------------------------------------
  " piscar linha do cursor p/ sinalizar cópia de texto no modo visual
  " Ativa o destaque temporário apenas durante cópias no modo visual
  vnoremap <silent> y :<C-U>call VisualYankWithBlink()<CR>

  " Configuração do efeito visual
  highlight YankFlashLine ctermbg=Yellow guibg=#FFFF00
  let g:yank_flash_duration = 200 " Tempo em milissegundos

  function! VisualYankWithBlink()
      " Salva a posição original do cursor
      let original_pos = getpos(".")

      " Executa a cópia normal
      normal! gvy

      " Adiciona destaque na linha atual
      let current_line = line('.')
      let match_id = matchadd('YankFlashLine', '\%' . current_line . 'l')

      " Força redesenho para mostrar o destaque
      redraw

      " Mantém o destaque por um curto período
      execute 'sleep ' . g:yank_flash_duration . 'm'

      " Remove o destaque e restaura o cursor
      call matchdelete(match_id)
      call setpos('.', original_pos)

      " Redesenho final para limpar
      redraw
  endfunction

endif

" ====================================================
"       CONFIGURAÇÃO LUA (SOMENTE PARA NEOVIM)
" ====================================================
if g:is_nvim

" Sinalizar texto copiado (yank)
au TextYankPost * silent! lua vim.highlight.on_yank { higroup='IncSearch', timeout=300 }


" Configuração do path para módulos Lua
  lua <<EOF
  --[[Adiciona o diretório lua ao package.path]]
    package.path = package.path .. ';' .. vim.env.HOME .. '~/.config/nvim/lua/?.lua'
EOF

  " Configuração do runtimepath
  set runtimepath^=~/.config/nvim

  " Carrega configuração principal
  lua require('config')
endif


" ====================================================
"          MENSAGENS INICIAIS
" ====================================================
autocmd VimEnter * echo "Editor configurado! Comandos úteis:\n"
      \  "  :nmap           - Listar atalhos dessa configuração\n"
      \  "  :e $MYVIMRC     - Editar configuração (VimScript)\n"
      \  (g:is_nvim ? 
      \  "  :Lazy install   - Instalar plugins Lua" :
      \  "  :PlugInstall    - Instalar plugins Vim\n    :checkhealth    - Verificar saúde dos plugins" )

" Confirmação de carregamento
autocmd VimEnter * echo "\nConfiguração VimScript carregada! ✅"

" ====================================================
"          NOTAS DE INSTALAÇÃO
" ====================================================
"
" ESTRUTURA DE ARQUIVOS (Linux/WSL/macOS):
"
" para Neovim:
"  ~/.config/nvim/
"   ├── init.vim          (este VimScript)
"   └── lua/
"       └── config.lua    (configurações em LuaScript)
"
"
" Para Vim tradicional:
"  ~/.vimrc              (este VimScript)
"
"
" APÓS INSTALAR:
" 1. Vim(```bash: vim): Executar :PlugInstall
" 2. Neovim(```bash: nvim): Executar :Lazy install
"


