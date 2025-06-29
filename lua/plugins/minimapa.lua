
--[[MiniMapa lateral para a página.]]


return{
    "echasnovski/mini.map",
    version = "*", -- Ou use `branch = "stable"` para versões estáveis
    config = function()
      require("mini.map").setup({
        -- Todas as configurações são opcionais, aqui estão algumas sugestões:
        integrations = {
          mini_cursorword = nil, -- Integre com mini.cursorword para destacar a palavra sob o cursor
          mini_indentscope = nil, -- Integre com mini.indentscope para destacar blocos de indentação
          -- Adicione integrações com outros plugins, por exemplo:
          -- cmp = nil, -- Se você usa nvim-cmp
          -- lsp = nil, -- Para mostrar diagnósticos LSP no minimapa (erros, warnings)
          -- treesitter = nil, -- Para realce de sintaxe baseado em treesitter (muito bom!)
        },
        -- Configurações gerais do minimapa
        options = {
          direction = "right", -- Posição do minimapa: "left" ou "right"
          width = { closed = 0, opened = 10 }, -- Largura quando fechado e aberto
          offset = 0, -- Espaçamento entre o minimapa e a janela principal
          start_by_events = { "BufReadPost", "BufNewFile" }, -- Eventos para iniciar o minimapa
          -- Outras opções...
          -- show_colors = true, -- Tenta mostrar cores reais do código (pode ser lento em arquivos grandes)
        },
        -- Mapa de teclas (keymaps) padrão para o mini.map
        -- Veja a documentação para mais opções de keymaps
        mappings = {
          -- Toggles minimap
          ["<Leader>mm"] = "toggle",
        },
      })
    end,
  }
