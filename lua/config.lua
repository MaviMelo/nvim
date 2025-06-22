--[[
  ================================================================================
                      CONFIGURAÇÃO PRINCIPAL DO NEOVIM COM LAZY.NVIM
  ================================================================================
  Este arquivo usa o Lazy.nvim como gerenciador de plugins. Cada seção está comentada
  para explicar sua finalidade e funcionamento afim de ajudar/fcilitar a compreenção
  e customização.
  --]]


--[[::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::


  =======INSTALAÇÕES BÁSICAS PARA UM HAMBIENTE DE DESENVOLVIMENTO WEB.===========

# (Instalação global ou como dependencias de desenvolvimento de um projeto no linux/WSL)
alternativa
# Instala o Node.js e o NPM (Node Package Manager), necessários para ferramentas
# como eslint_d e prettier
sudo apt install nodejs npm

# Instala o cURL, uma ferramenta de linha de comando para transferências de dados
# (usada por alguns scripts de instalação)
sudo apt install curl

# Instala globalmente os pacotes do Node: neovim (suporte a plugins Node.js no
# Neovim), eslint_d (linter rápido para JS/TS) e prettier (formatador de código)
sudo npm install -g neovim eslint_d prettier

# Instala globalmente o pacote `vscode-langservers-extracted`, que
# inclui servidores de linguagem como HTML, CSS e JSON
sudo npm install -g vscode-langservers-extracted

  #Outras opções para HTML e CSS (Linter):
     # Instala globalmente o `htmlhint`, uma ferramenta para
     # verificar a qualidade do código HTML
      sudo npm install -g htmlhint

      # Intala globalmente linter para CSS.
      sudo npm install -g stylelint stylelint-config-standard

      # Instala o gerenciador de pacotes Lua (luarocks), e depois instala o linter
# `luacheck` via apt (usado para checar código Lua)
sudo apt install luarocks && sudo apt install luacheck







===>  IPORTANTE: hÁ DISPONIVEL UM SCRIPT QUE ALTOMATIZA INSTALAÇÕES DE ALGUMAS
DESSAS E OUTRRAS DEPENDENCIAS PARA CONFIGURAÇÃO DE DESENVOLVIMENTO WEB COM O NEOVIM.
EXECUTE NO TERMINAL BASH COMO ADMINISTRADOR (USUÁRIO root):
                  --->  sudo bash -x ~/.config/nvim/setup.sh   <-----
--::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
--]]











--[[----------------------------------------------
         INICIALIZAÇÃO DO GESTOR DE PLUGINS
--------------------------------------------------]]
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

--[[----------------------------------------------
               PLUGINS E SUAS CONFIGS
--------------------------------------------------]]
require("lazy").setup({

  -- TEMA
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd.colorscheme("tokyonight-night")
      vim.o.termguicolors = true
    end,
  },

  -- BARRA DE STATUS (LUALINE)
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy", -- Carrega tardiamente para otimização
    dependencies = { "kyazdani42/nvim-web-devicons" },
    config = function()
      require("lualine").setup({
        options = {
          theme = "tokyonight", -- Combina com o tema principal
        },
      })
    end,
  },

  -- INDENTAÇÃO VISUAL
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    opts = { indent = { char = "▏" } } -- ou "┊", "¦", "⎸", "▏", "│"
  },


  -- ISERIR EMOJIS, NERD FONTES, UNICODES, ETC.
  {
    "nvim-tree/nvim-web-devicons",
    lazy = true,
    config = function()
      require("nvim-web-devicons").setup({ default = true })
    end,
  },

  {
    "ziontee113/icon-picker.nvim",
    dependencies = { "stevearc/dressing.nvim" },
    config = function()
      require("icon-picker").setup({
        disable_legacy_commands = true -- para evitar comandos duplicados
      })
    end,
    keys = {
      { "<leader>zm", "<cmd>IconPickerYank emoji<cr>",   noremap = true, silent = false,             desc = "Inserir Emoji" },
      { "<leader>mz", "<cmd>IconPickerYank symbols<cr>", silent = false, desc = "Inserir símbolo" },
      { "<leader>zz", "<cmd>IconPickerYank<cr>",         silent = false, desc = "Inserir caracteres" },
    }
  },

  -- NAVEGADOR DE ARQUIVOS: NVIM-TREE
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("nvim-tree").setup({
        view = {
          width = 30,
          side = "left",
        },
        renderer = {
          group_empty = true,
        },
        filters = {
          dotfiles = false,
        },
        git = {
          enable = true,
        },
      })

      -- Atalho para abrir/fechar o nvim-tree
      vim.keymap.set("n", "<C-n>", "<cmd>NvimTreeToggle<CR>", { desc = "Navegador de diretórios NvimTree" })
    end,
  },
  -- ÍCONES DE ARQUIVOS
  {
    "nvim-tree/nvim-web-devicons",
    lazy = true,
    config = function()
      require("nvim-web-devicons").setup()
    end,
  },

  -- BUSCAS COM TELESCOPE
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.4",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("telescope").setup({
        defaults = {
          layout_strategy = "vertical",
          layout_config = { height = 0.95 }
        }
      })
    end,
    keys = {
      { "<leader>tf", "<cmd>Telescope find_files<cr>", desc = "Procurar Arquivos" },
      { "<leader>tg", "<cmd>Telescope live_grep<cr>",  desc = "Buscar Texto" }
    }
  },

  -- AUTOCOMPLETE COM NVIM-CMP
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "saadparwaiz1/cmp_luasnip",
    },
    config = function()
      local cmp = require("cmp")
      cmp.setup({
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "buffer" },
          { name = "path" }
        }),
      })
    end,
  },

  -- Ordem correta de configuração para funcionamento correto de LSPs e Linters:
  -- 1. mason.nvim
  -- 2. mason-lspconfig.nvim
  -- 3. nvim-lspconfig



  -- Configuração do ecossistema LSP (Language Server Protocol) para Neovim
  -- Ordem de carregamento importante: Mason -> Mason-LSPConfig -> nvim-lspconfig

  -- CONFIGURAÇÃO LSP PARA NEOVIM 0.9.5
  -- Versões compatíveis dos plugins:
  -- Mason.nvim: v1.8.x
  -- mason-lspconfig.nvim: v1.19.x
  -- nvim-lspconfig: v0.1.x

  -- 1. MASON - GERENCIADOR DE PACOTES (versão compatível)
  {
    "williamboman/mason.nvim",
    version = "~1.8.0", -- Versão específica para compatibilidade
    opts = {
      ui = {
        border = "rounded",
      },
      -- Configuração adicional para melhor estabilidade
      max_concurrent_installers = 4,
      pip = {
        upgrade_pip = false -- Evita problemas com atualização do pip
      }
    }
  },

  -- 2. MASON-LSPCONFIG - INTEGRAÇÃO (versão compatível)
  {
    "williamboman/mason-lspconfig.nvim",
    version = "~1.19.0", -- Versão testada com Neovim 0.9.5
    dependencies = {
      "williamboman/mason.nvim",
      "neovim/nvim-lspconfig"
    },
    config = function()
      -- Configuração simplificada para evitar problemas com automatic_installation
      require("mason-lspconfig").setup({
        ensure_installed = {
          "typescript-language-server", -- Nome correto para TypeScript
          "html",
          "cssls",
          "lua-language-server", -- Nome atualizado para Lua
          "pyright"
        },
        -- Desativada instalação automática devido a instabilidade
        automatic_installation = false
      })
    end
  },

  -- 3. NVIM-LSPCONFIG - CLIENTE LSP (configuração básica)
  {
    "neovim/nvim-lspconfig",
    version = "~0.1.7", -- Última versão compatível com 0.9.5
    dependencies = {
      "hrsh7th/cmp-nvim-lsp"
    },
    config = function()
      local lspconfig = require("lspconfig")

      -- Capacidades compatíveis com Neovim 0.9.5
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

      -- Função de atachamento simplificada
      local on_attach = function(client, bufnr)
        -- Mapeamentos básicos (evitar funções não disponíveis em 0.9.5)
        local opts = { buffer = bufnr, silent = true }

        vim.keymap.set('n', 'gd', vim.lsp.buf.definition,
          opts { desc = "Vai para a definição de uma variável, função, etc." })
        vim.keymap.set('n', 'gf', vim.lsp.buf.hover,
          opts { desc = "Mostra uma janela flutuante com a documentação/descrição do item sob o cursor." })
        vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename,
          opts { desc = "Renomeia simbolicamente a variável em todos os lugares (refatoração)." })

        -- Desativa formatação via LSP para evitar conflitos
        -- client.server_capabilities.documentFormattingProvider = false
      end

      -- CONFIGURAÇÕES ESPECÍFICAS DOS SERVIDORES ----------------------------

      -- TypeScript (configuração legacy)
      lspconfig.tsserver.setup({
        on_attach = on_attach,
        capabilities = capabilities,
        -- Evita recursos não suportados
        flags = {
          debounce_text_changes = 150
        }
      })

      -- HTML/CSS (configuração mínima)
      lspconfig.html.setup({ on_attach = on_attach, capabilities = capabilities })
      lspconfig.cssls.setup({ on_attach = on_attach, capabilities = capabilities })

      -- Lua (configuração especial para Neovim 0.9)
      lspconfig.lua_ls.setup({
        on_attach = on_attach,
        capabilities = capabilities,
        settings = {
          Lua = {
            runtime = { version = 'LuaJIT' },
            diagnostics = {
              globals = { 'vim' },
              -- Desativa warnings que podem ser muito verbosos
              disable = { 'different-requires' }
            },
            workspace = {
              library = vim.api.nvim_get_runtime_file("", true),
              -- Configuração adicional para evitar problemas
              checkThirdParty = false
            },
            telemetry = { enable = false }
          }
        }
      })

      -- Python (configuração básica)
      lspconfig.pyright.setup({
        on_attach = on_attach,
        capabilities = capabilities,
        -- Configurações para melhor desempenho
        root_dir = function()
          return vim.loop.cwd()
        end
      })

      -- Habilita bordas arredondadas para todas as janelas LSP
      vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(
        vim.lsp.handlers.hover, {
          border = "rounded"
        }
      )
    end
  },

  --  EMMET PARA DESENVOLVIMENTO WEB
  {
    "mattn/emmet-vim",
    ft = { "html", "css", "javascriptreact", "typescriptreact" }, -- Só carrega nesses arquivos
    config = function()
      noremap = true                                              -- Configuraeões específicas do Emmet
      silent = false
      vim.g.user_emmet_mode = "n"                                 -- Ativa no modo normal
      vim.g.user_emmet_leader_key = ","                           -- Tecla líder para expansão
      print("Emmet pronto para HTML/CSS!")
    end,
  },

  -- LUASNIP: MECANISMO DE SNIPPETS PARA QUALQUER LINGUAGEM
  {
    "L3MON4D3/LuaSnip",
    version = "v2.*",                                  -- Fixa a versão 2, compatível com Neovim 0.9.5
    event = "InsertEnter",                             -- Carrega ao entrar no modo de inserção (lazy load)
    build = "make install_jsregexp",                   -- (opcional) para suporte a regex avançado
    dependencies = { "rafamadriz/friendly-snippets" }, -- Snippets prontos (opcional)
    config = function()
      local luasnip = require("luasnip")

      -- Configuração básica
      luasnip.config.set_config({
        history = true,
        updateevents = "TextChanged,TextChangedI",
        enable_autosnippets = true,
      })

      -- Carrega snippets no formato do VSCode (ex: do friendly-snippets)
      require("luasnip.loaders.from_vscode").lazy_load()
    end,
  },

  -- LINTER COM NVIM-LINT
  {
    "mfussenegger/nvim-lint",
    event = "BufWritePost",
    config = function()
      require("lint").linters_by_ft = {
        lua = { "luacheck" },
        javascript = { "eslint_d" },
        typescript = { "eslint_d" },
        python = { "flake8" },
        css = { "stylelint" },
        html = { "htmlhint" }
      }
      vim.api.nvim_create_autocmd("BufWritePost", {
        callback = function()
          require("lint").try_lint()
        end,
      })
    end,
  },

  --[[ PLUGINS CARREGADOS DO RIRETÓRIOS 'PLUGINS' (./lua/plugins/)]]

  {
    --Pluguins e configurações adicionais para o Git.
    require("plugins.git"),

  }
})

--[[::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::]]

-- VERIFICAÇÃO DE SAÚDE DO LSP
vim.api.nvim_create_autocmd('User', {
  pattern = 'MasonUpdateCompleted',
  callback = function()
    vim.schedule(function()
      local mr = require('mason-registry')
      for _, pkg_name in ipairs({ 'typescript-language-server', 'lua-language-server' }) do
        if mr.is_installed(pkg_name) then
          vim.notify(string.format('[Mason] %s instalado com sucesso!', pkg_name), vim.log.levels.INFO)
        else
          vim.notify(string.format('[Mason] %s NÃO instalado!', pkg_name), vim.log.levels.ERROR)
        end
      end
    end)
  end
})

--[[----------------------------------------------
            CONFIGURAÇÃO AVANÇADA DO EMMET
--------------------------------------------------
Personalização de snippets e comportamentos do Emmet
--]]
vim.g.user_emmet_settings = {
  html = {
    default_attributes = {
      option = { value = nil },
      textarea = {
        id = nil,
        name = nil,
        cols = 10,
        rows = 10,
      },
    },
    snippets = {
      -- Snippet personalizado para HTML5
      ["!"] = [[
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <!-- Define a largura da página como a largura do dispositivo e impede o zoom manual -->
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
  <!-- link CSS
   <link rel="stylesheet" href="css/styles.css">
  -->
</head>
<body>
    <!-- Conteúdo -->

    <footer>
    </footer>

    <!-- link JavaScript
     <script src="js/scripts.js" defer></script>
    -->
</body>
</html>]],
    },
  },
}

--[[----------------------------------------------
            CONFIGURAÇÕES GERAIS
--------------------------------------------------
Configurações básicas do Neovim que não dependem de plugins
--]]
vim.opt.number = true         -- Mostra números de linha
vim.opt.relativenumber = true -- Números relativos
vim.opt.tabstop = 2           -- Tabs = 2 espaços
vim.opt.shiftwidth = 2        -- Indentação automática
vim.opt.expandtab = true      -- Converte tabs em espaços
vim.opt.mouse = "a"           -- Mouse em todos os modos

--[[----------------------------------------------
           ATALHOS PERSONALIZADOS
--------------------------------------------------]]
vim.keymap.set("n", "<leader>ff", vim.lsp.buf.format, {
  noremap = true,
  silent = false,
  desc =
  "Formatar identação do código"
})

vim.keymap.set("n", "<leader>mn", function()
    local file = vim.fn.expand("%")
    vim.cmd("! for i in {1..5}; do echo; done && ts-node --compiler-options '{\"module\":\"commonjs\"}' " .. file)
  end,
  {
    noremap = true,
    silent = true,
    desc =
    "Carrega arquivo.ts (TypeScript) no buffer atual com ts-node (se estiver instalado)"
  })


-- Mostrar diagnóstico
vim.keymap.set("n", "<leader>l", function() require("lint").try_lint() end, { desc = "Diagnóstico Lint" })

-- Limpar diagnóstico
vim.keymap.set("n", "<leader>lk", function()
  vim.diagnostic.reset()
end, { desc = "Limpar diagnósticos" })

-- Ir para o próximo diagnóstico
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Próximo diagnóstico" })

-- Ir para o diagnóstico anterior
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Diagnóstico anterior" })

-- Abrir o flutuante com detalhes do erro
vim.keymap.set("n", "<leader>k", vim.diagnostic.open_float, { desc = "Ver diagnóstico atual" })

vim.keymap.set("n", "<C-k>", ":resize -2<CR>", { noremap = true, silent = false, desc = "Diminuição vertical de janela" })

vim.keymap.set("n", "<C-j>", ":resize +2<CR>", { noremap = true, silent = false, desc = "Aumento vertical de janela" })

vim.keymap.set("n", "<C-h>", ":vertical resize -2<CR>",
  { noremap = true, silent = false, desc = "Diminuição hrizontal de janela" })

vim.keymap.set("n", "<C-l>", ":vertical resize +2<CR>", {
  noremap = true,
  silent = false,
  desc =
  "Aumento hrizontal de janela"
})



--[[----------------------------------------------
     VERIFICAÇÃO DE BINÁRIOS GLOBAIS DISPONÍVEIS
--------------------------------------------------]]
vim.schedule(function()
  local global_binaries = { "node", "npm", "eslint_d", "prettier", "luacheck" }
  for _, bin in ipairs(global_binaries) do
    if vim.fn.executable(bin) == 1 then
      print("✅ Binário global disponível: " .. bin)
    else
      print("❌ Binário não encontrado: " .. bin)
    end
  end
  print("Configuração em LuaScript carregada! ✅")
end)

--[[----------------------------------------------
            COMANDOS ÚTEIS
--------------------------------------------------
: Lazy       → Gerencia plugins
: Mason      → Instala LSPs
: Lazy update → Atualiza plugins
: NvimTreeToggle → Alterna navegador (Ctrl+n)
--]]
