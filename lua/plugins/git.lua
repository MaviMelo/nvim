-- ~/.config/nvim/lua/plugins/git.lua

-- print("DEBUG: Arquivo git.lua está sendo carregado!")

-- Retorna uma tabela de plugins para o Lazy.nvim

return {
  -- Gitsigns: para indicadores de diff na barra lateral (gutter)
 -- print("DEBUG: Arquivo git.lua está sendo carregado!"),
  {
    "lewis6991/gitsigns.nvim",
    -- Evento de carregamento, para carregar o plugin apenas quando necessário.
    -- 'BufReadPre' é um bom ponto para gitsigns, pois ele precisa ser ativo quando um buffer é lido.
    event = "BufReadPre",
    opts = {
      -- Configurações mínimas para gitsigns
      signs = {
        add          = { text = "󰜅", hl = "DiffAdd" }, -- Linha adicionada
        change       = { text = "󱞱", hl = "GitSignsChange" }, -- Linha modificada
        delete       = { text = "-", hl = "GitSignsDelete" }, -- Linha removida
        topdelete    = { text = "󱞧", hl = "GitSignsDelete" }, -- Remoção no topo (como um "deletar para cima")
        changedelete = { text = "≠", hl = "GitSignsChangeDelete" }, -- Modificação + exclusão
        untracked    = { text = "?" } -- Arquivo não rastreado
        --  add = { text = "▎" },
        --  change = { text = "▎" },
        --  delete = { text = "" },
        --  topdelete = { text = "" },
        --  changedelete = { text = "▎" },
      },
      -- Desativa a função on_attach se não for usar mapeamentos específicos aqui
      -- ou se preferir configurar mapeamentos globais em outro lugar.
      -- on_attach = function(bufnr)
      --   -- Você pode adicionar mapeamentos básicos aqui se quiser:
      --   local gs = package.loaded.gitsigns
      --   vim.keymap.set('n', ']h', gs.next_hunk, { buffer = bufnr, desc = "Next Git Hunk" })
      --   vim.keymap.set('n', '[h', gs.prev_hunk, { buffer = bufnr, desc = "Prev Git Hunk" })
      -- end,
    },
  },

  -- Diffview: para a interface visual de comparação de commits
  {
    "sindrets/diffview.nvim",
    -- 'plenary.nvim' é uma dependência comum e necessária para muitos plugins Lua.
    dependencies = { "nvim-lua/plenary.nvim" },
    -- 'cmd' faz com que o plugin seja carregado apenas quando um desses comandos é executado.
    cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggle", "DiffviewFocus" },
    opts = {
      -- Configurações mínimas para diffview
      diff_binaries = false, -- Não tenta fazer diff de arquivos binários
      -- layout = "diff3", -- Exemplo: layout com 3 painéis (original, atual, novo)
    },
    -- Mapeamentos de teclas para facilitar o uso do Diffview
    keys = {
      { "<leader>gd", "<cmd>DiffviewOpen<CR>", desc = "Diffview Open" }, -- Abre o Diffview
      -- <leader>gd (leader + g + d): um atalho comum para "Git Diff"
      -- <cmd>DiffviewOpen<CR>: Comando para abrir o Diffview
      -- desc: Descrição que aparece se você usar um plugin como `which-key.nvim`
    },
  },
  
}


