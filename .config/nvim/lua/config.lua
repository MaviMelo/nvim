
--[[
================================================================================
                    CONFIGURAÇÃO PRINCIPAL DO NEOVIM COM LAZY.NVIM
================================================================================
Este arquivo usa o Lazy.nvim como gerenciador de plugins. Cada seção está comentada
para explicar sua finalidade e funcionamento.
--]]


--[[::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::


=======INSTALAÇÕES BÁSICAS PARA UM HAMBIENTE DE DESENVOLVIMENTO WEB.===========

# (Instalação global ou como dependencias de desenvolvimento de um projeto no linux/WSL)

# Instala o Node.js e o NPM (Node Package Manager), necessários para ferramentas
# como eslint_d e prettier
sudo apt install nodejs npm

# Instala o cURL, uma ferramenta de linha de comando para transferências de dados
# (usada por alguns scripts de instalação)
sudo apt install curl

# Instala globalmente os pacotes do Node: neovim (suporte a plugins Node.js no
# 3 Neovim), eslint_d (linter rápido para JS/TS) e prettier (formatador de código)
sudo npm install -g neovim eslint_d prettier

# (corrigido) Instala globalmente o pacote `vscode-langservers-extracted`, que
# inclui servidores de linguagem como HTML, CSS e JSON
sudo npm install -g vscode-langservers-extracted

# Instala globalmente o `htmlhint`, uma ferramenta para verificar a qualidade do
# código HTML
sudo npm install -g htmlhint

# Instala o gerenciador de pacotes Lua (luarocks), e depois instala o linter
# `luacheck` via apt (usado para checar código Lua)
sudo apt install luarocks && sudo apt install luacheck


--::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
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
		"--filter=blob:none", -- Otimiza o clone (apenas metadados)
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- Usa versão estável
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
		lazy = false, -- Carrega imediatamente
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
    DESTACAR A INDENTAÇÃO COM LINHAS VERTICAIS
  ::::::::::::::::::::::::::::::::::::::::::::::::]]
  {
  "lukas-reineke/indent-blankline.nvim",
  main = "ibl",
  opts = {},
  config = function()
    require("ibl").setup({
      indent = {
        char = "▏", -- ou "┊", "¦", "⎸", "▏", "│"
      },
      scope = {
        enabled = true, -- mostra linhas de escopo (como blocos em if, for, etc)
      },
    })
    print("Linhas de indentação ativadas!")
  end,
},


   --[[:::::::::::::::::::::::::::::::::::::::::::::
   ISERIR EMOJIS, NERD FONTES, UNICODES, ETC.
  ::::::::::::::::::::::::::::::::::::::::::::::::]]
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
    { "<leader>zm", "<cmd>IconPickerInsertEmoji<cr>", desc = "Inserir Emoji" },
    { "<leader>mz", "<cmd>IconPickerInsertIcon<cr>", desc = "Inserir Ícone" },
    { "<leader>zz", "<cmd>IconPickerYank<cr>", desc = "Copiar Emoji/Ícone" },
  }
},

	--[[:::::::::::::::::::::::::::::::::::::::::::::
    TELESCOPE: ITERFACE DE BUSCA.
  ::::::::::::::::::::::::::::::::::::::::::::::::]]

{
  "nvim-telescope/telescope.nvim",
  tag = "0.1.4",
  dependencies = {
    "nvim-lua/plenary.nvim", -- dependência obrigatória
    "nvim-telescope/telescope-fzf-native.nvim", -- extensão para busca mais rápida (opcional, mas recomendada)
    build = "make", -- precisa de make instalado
  },
  config = function()
    require("telescope").setup({
      defaults = {
        layout_strategy = "vertical",
        layout_config = {
          height = 0.95,
          preview_cutoff = 10,
        },
      },
    })

    -- Carrega extensão fzf se estiver instalada
    pcall(require("telescope").load_extension, "fzf")
  end,
  keys = {
    { "<leader>tf", "<cmd>Telescope find_files<cr>", desc = "Procurar arquivos" },
    { "<leader>tg", "<cmd>Telescope live_grep<cr>", desc = "Procurar texto (grep)" },
    { "<leader>tb", "<cmd>Telescope buffers<cr>", desc = "Listar buffers" },
    { "<leader>th", "<cmd>Telescope help_tags<cr>", desc = "Ajuda" },
  }
},

	--[[:::::::::::::::::::::::::::::::::::::::::::::
    SISTEMA DE AUTOCOMPLETE (NVIDIA-CMP)
  ::::::::::::::::::::::::::::::::::::::::::::::::]]
	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter", -- Carrega quando entra no modo de inserção
		dependencies = { -- Plugins necessários
			"hrsh7th/cmp-nvim-lsp", -- Integração com LSP
			"hrsh7th/cmp-buffer", -- Completação do buffer atual
			"hrsh7th/cmp-path", -- Completação de caminhos de arquivo
			"l3mon4d3/luasnip", -- Motor de snippets
			"saadparwaiz1/cmp_luasnip", -- Integração de snippets
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
					["<C-b>"] = cmp.mapping.scroll_docs(-4), -- Rola documentação para cima
					["<C-f>"] = cmp.mapping.scroll_docs(4), -- Rola documentação para baixo
					["<C-Space>"] = cmp.mapping.complete(), -- Mostra sugestões
					["<C-e>"] = cmp.mapping.abort(), -- Fecha menu
					["<CR>"] = cmp.mapping.confirm({ select = true }), -- Confirma seleção
				}),
				sources = cmp.config.sources({
					-- Ordem de prioridade das fontes
					{ name = "nvim_lsp" }, -- Dados do LSP
					{ name = "luasnip" }, -- Snippets
					{ name = "buffer" }, -- Texto do buffer
					{ name = "path" }, -- Caminhos do sistema
				}),
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
			vim.g.user_emmet_mode = "n" -- Ativa no modo normal
			vim.g.user_emmet_leader_key = "," -- Tecla líder para expansão
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
					theme = "tokyonight", -- Combina com o tema principal
				},
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
		config = {
			tsserver_path = "/usr/local/bin/tsserver", -- Caminho do servidor TS
			on_attach = function(client, bufnr)
				-- Atalho para renomear símbolos (leader + rn)
				vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, {
					buffer = bufnr,
					desc = "Renomear símbolo",
				})
			end,
			settings = {
				tsserver = {
					check = {
						redundantAssigns = false, -- Desativa verificações redundantes
					},
				},
			},
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
			require("mason-lspconfig").setup({
         ensure_installed = {
    "tsserver",     -- TypeScript/JavaScript
    "html",         -- HTML
    "cssls",        -- CSS (já inclui variáveis)
    "eslint",       -- Opcional
    -- "tailwindcss" -- Se usar Tailwind
  }
      })
			print("Mason: Use :Mason para gerenciar LSPs")
		end,
	},

	--[[:::::::::::::::::::::::::::::::::::::::::::::
    CONFIGURAÇÃO DE LSP
  ::::::::::::::::::::::::::::::::::::::::::::::::]]
	{
		"neovim/nvim-lspconfig",
    version = "0.1.7",  -- Última versão compatível com Neovim 0.9
    lock = true, -- Força o Lazy a respeitar a versão
		event = "BufReadPre", -- Carrega antes de abrir arquivos
		config = function()
			-- Configura LSPs específicos
			require("lspconfig").html.setup({

                on_attach = function(client, bufnr)
        -- Ativa diagnósticos visíveis para HTML
        vim.diagnostic.config({
          virtual_text = true,
          signs = true,
          underline = true,
          update_in_insert = false,
          severity_sort = true,
        })
      end
            })
			require("lspconfig").cssls.setup({})
			print("LSPs para HTML/CSS carregados!")
		end,
	},

	--[[:::::::::::::::::::::::::::::::::::::::::::::
    VERIFICAÇÃO DE CÓDIGO (NVIM-LINT)
  ::::::::::::::::::::::::::::::::::::::::::::::::]]
	{
		"mfussenegger/nvim-lint",
		event = "BufWritePost", -- Executa após salvar
		config = function()
			require("lint").linters_by_ft = {
				lua = { "luacheck" }, -- Linter para Lua
                html = { "htmlhint" }, -- Adiciona o linter para HTML
				javascript = { "eslint_d" }, -- Linter para JS
				typescript = { "eslint_d" }, -- Linter para TS
                python = {'flake8'}, --Linter para python

			}
			-- Executa verificação ao salvar arquivos Lua
			vim.api.nvim_create_autocmd("BufWritePost", {
				pattern = "*",
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
vim.opt.number = true -- Mostra números de linha
vim.opt.relativenumber = true -- Números relativos
vim.opt.tabstop = 2 -- Tabs = 2 espaços
vim.opt.shiftwidth = 2 -- Indentação automática
vim.opt.expandtab = true -- Converte tabs em espaços
vim.opt.mouse = "a" -- Mouse em todos os modos

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
		},
	},
},

--[[----------------------------------------------
            ÁTALHOS PERSONALIZADOS
--------------------------------------------------]]
vim.keymap.set('n', '<leader>ff', function()
  vim.lsp.buf.format()
end, { desc = 'Formatação/identação' }),

vim.keymap.set('n', '<leader>l', function()
  require("lint").try_lint()
end, { desc = "Executa linter manualmente" })


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

