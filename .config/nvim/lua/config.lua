--[[
================================================================================
                    CONFIGURAÇÃO PRINCIPAL DO NEOVIM COM LAZY.NVIM
================================================================================
Este arquivo usa o Lazy.nvim como gerenciador de plugins. Cada seção está comentada
para explicar sua finalidade e funcionamento.
--]]

--[[----------------------------------------------
                INICIALIZAÇÃO
--------------------------------------------------
Verificação inicial e carregamento do Lazy.nvim
--]]
-- Mensagem inicial para verificação de carregamento
print("Iniciando carregamento da configuração...")

-- Define o caminho de instalação do Lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

-- Instala o Lazy.nvim se não estiver presente
if not vim.loop.fs_stat(lazypath) then
  print("Instalando Lazy.nvim...")
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",  -- Otimiza o clone (apenas metadados)
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",     -- Usa versão estável
    lazypath,
  })
end

-- Adiciona o Lazy.nvim ao runtime path do Neovim
vim.opt.rtp:prepend(lazypath)

--[[----------------------------------------------
                CONFIGURAÇÃO DE PLUGINS
--------------------------------------------------
Lista todos os plugins com suas configurações específicas.
Cada plugin é uma tabela com metadados e configurações.
--]]
require("lazy").setup({
  --[[:::::::::::::::::::::::::::::::::::::::::::::
    TEMA VISUAL (TOKYONIGHT)
  ::::::::::::::::::::::::::::::::::::::::::::::::]]
  {
    "folke/tokyonight.nvim",
    lazy = false,    -- Carrega imediatamente
    priority = 1000, -- Prioridade máxima (primeiro plugin a carregar)
    config = function()
      -- Aplica o tema e configurações relacionadas
      vim.cmd.colorscheme("tokyonight-night")
      vim.o.background = "dark"
      vim.o.termguicolors = true -- Ativa cores verdadeiras
      print("Tema Tokyonight aplicado!")
    end,
  },

  --[[:::::::::::::::::::::::::::::::::::::::::::::
    SISTEMA DE AUTOCOMPLETE (NVIDIA-CMP)
  ::::::::::::::::::::::::::::::::::::::::::::::::]]
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter", -- Carrega quando entra no modo de inserção
    dependencies = {      -- Plugins necessários
      "hrsh7th/cmp-nvim-lsp",  -- Integração com LSP
      "hrsh7th/cmp-buffer",    -- Completação do buffer atual
      "hrsh7th/cmp-path",      -- Completação de caminhos de arquivo
      "l3mon4d3/luasnip",      -- Motor de snippets
      "saadparwaiz1/cmp_luasnip" -- Integração de snippets
    },
    config = function()
      local cmp = require("cmp")
      
      -- Configuração principal do nvim-cmp
      cmp.setup({
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body) -- Expande snippets
          end,
        },
        mapping = cmp.mapping.preset.insert({
          -- Atalhos do teclado
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),   -- Rola documentação para cima
          ["<C-f>"] = cmp.mapping.scroll_docs(4),    -- Rola documentação para baixo
          ["<C-Space>"] = cmp.mapping.complete(),    -- Mostra sugestões
          ["<C-e>"] = cmp.mapping.abort(),           -- Fecha menu
          ["<CR>"] = cmp.mapping.confirm({ select = true }), -- Confirma seleção
        }),
        sources = cmp.config.sources({
          -- Ordem de prioridade das fontes
          { name = "nvim_lsp" },  -- Dados do LSP
          { name = "luasnip" },   -- Snippets
          { name = "buffer" },    -- Texto do buffer
          { name = "path" },      -- Caminhos do sistema
        })
      })
      print("Auto-completar configurado!")
    end,
  },

  --[[:::::::::::::::::::::::::::::::::::::::::::::
    EMMET PARA DESENVOLVIMENTO WEB
  ::::::::::::::::::::::::::::::::::::::::::::::::]]
  {
    "mattn/emmet-vim",
    ft = { "html", "css", "javascriptreact", "typescriptreact" }, -- Só carrega nesses arquivos
    config = function()
      -- Configurações específicas do Emmet
      vim.g.user_emmet_mode = "n"        -- Ativa no modo normal
      vim.g.user_emmet_leader_key = ","  -- Tecla líder para expansão
      print("Emmet pronto para HTML/CSS!")
    end,
  },

  --[[:::::::::::::::::::::::::::::::::::::::::::::
    NAVEGADOR DE ARQUIVOS (NVIM-TREE)
  ::::::::::::::::::::::::::::::::::::::::::::::::]]
  {
    "nvim-tree/nvim-tree.lua",
    cmd = "NvimTreeToggle", -- Carrega apenas quando o comando é chamado
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("nvim-tree").setup()
      -- Atalho para abrir/fechar (Ctrl+n)
      vim.keymap.set("n", "<C-n>", ":NvimTreeToggle<CR>", { silent = true })
      print("NvimTree: Use Ctrl+n para toggle")
    end,
  },

  --[[:::::::::::::::::::::::::::::::::::::::::::::
    BARRA DE STATUS (LUALINE)
  ::::::::::::::::::::::::::::::::::::::::::::::::]]
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy", -- Carrega tardiamente para otimização
    dependencies = { "kyazdani42/nvim-web-devicons" },
    config = function()
      require("lualine").setup({
        options = {
          theme = "tokyonight" -- Combina com o tema principal
        }
      })
      print("Barra de status configurada!")
    end,
  },

  --[[:::::::::::::::::::::::::::::::::::::::::::::
    FERRAMENTAS TYPESCRIPT
  ::::::::::::::::::::::::::::::::::::::::::::::::]]
  {
    "pmizio/typescript-tools.nvim",
    ft = "typescript", -- Só carrega em arquivos .ts
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      tsserver_path = "/usr/local/bin/tsserver", -- Caminho do servidor TS
      on_attach = function(client, bufnr)
        -- Atalho para renomear símbolos (leader + rn)
        vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, {
          buffer = bufnr,
          desc = "Renomear símbolo"
        })
      end,
      settings = {
        tsserver = {
          check = {
            redundantAssigns = false, -- Desativa verificações redundantes
          }
        }
      }
    },
  },

  --[[:::::::::::::::::::::::::::::::::::::::::::::
    GERENCIADOR DE LSP (MASON)
  ::::::::::::::::::::::::::::::::::::::::::::::::]]
  {
    "williamboman/mason.nvim",
    cmd = "Mason", -- Carrega quando o comando :Mason é executado
    build = ":MasonUpdate", -- Comando para atualização
    config = true, -- Configuração padrão
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim" },
    config = function()
      require("mason-lspconfig").setup()
      print("Mason: Use :Mason para gerenciar LSPs")
    end,
  },

  --[[:::::::::::::::::::::::::::::::::::::::::::::
    CONFIGURAÇÃO DE LSP
  ::::::::::::::::::::::::::::::::::::::::::::::::]]
  {
    "neovim/nvim-lspconfig",
    event = "BufReadPre", -- Carrega antes de abrir arquivos
    config = function()
      -- Configura LSPs específicos
      require("lspconfig").html.setup({})
      require("lspconfig").cssls.setup({})
      print("LSPs para HTML/CSS carregados!")
    end,
  },

  --[[:::::::::::::::::::::::::::::::::::::::::::::
    FORMATAÇÃO E DIAGNÓSTICO (NULL-LS)
  ::::::::::::::::::::::::::::::::::::::::::::::::]]
  {
    "jose-elias-alvarez/null-ls.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local null_ls = require("null-ls")
      null_ls.setup({
        sources = {
          null_ls.builtins.diagnostics.eslint_d,  -- Verificação de código
          null_ls.builtins.code_actions.eslint_d, -- Correções automáticas
          null_ls.builtins.formatting.prettier,   -- Formatação automática
        }
      })
      print("Prettier/ESlint configurados!")
    end,
  },

  --[[:::::::::::::::::::::::::::::::::::::::::::::
    VERIFICAÇÃO DE CÓDIGO (NVIDIA-LINT)
  ::::::::::::::::::::::::::::::::::::::::::::::::]]
  {
    "mfussenegger/nvim-lint",
    event = "BufWritePost", -- Executa após salvar
    config = function()
      require("lint").linters_by_ft = {
        lua = { "luacheck" },      -- Linter para Lua
        javascript = { "eslint_d" },-- Linter para JS
        typescript = { "eslint_d" },-- Linter para TS
      }
      -- Executa verificação ao salvar arquivos Lua
      vim.api.nvim_create_autocmd("BufWritePost", {
        pattern = "*.lua",
        callback = function()
          require("lint").try_lint()
        end,
      })
      print("Verificação de código ativa!")
    end,
  },
})

--[[----------------------------------------------
            CONFIGURAÇÕES GERAIS
--------------------------------------------------
Configurações básicas do Neovim que não dependem de plugins
--]]
vim.opt.number = true           -- Mostra números de linha
vim.opt.relativenumber = true   -- Números relativos
vim.opt.tabstop = 2             -- Tabs = 2 espaços
vim.opt.shiftwidth = 2          -- Indentação automática
vim.opt.expandtab = true        -- Converte tabs em espaços
vim.opt.mouse = "a"             -- Mouse em todos os modos

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
        rows = 10 
      }
    },
    snippets = {
      -- Snippet personalizado para HTML5
      ["!"] = [[
<!DOCTYPE html>
<html lang="pt">
<head>
    <meta charset="UTF-8">
    <!-- Define a largura da página como a largura do dispositivo e impede o zoom manual -->
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>
<body>
    <!-- Conteúdo -->
</body>
</html>]],
    }
  }
}

--[[----------------------------------------------
            MENSAGEM FINAL
--------------------------------------------------
Verificação de carregamento completo
--]]
print("Configuração carregada com sucesso! ✅")

--[[----------------------------------------------
            COMANDOS ÚTEIS
--------------------------------------------------
: Lazy       → Gerencia plugins
: Mason      → Instala LSPs
: Lazy update → Atualiza plugins
: NvimTreeToggle → Alterna navegador (Ctrl+n)
--]]