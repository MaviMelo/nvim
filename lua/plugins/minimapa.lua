-- codewindow
return {
  "gorbit99/codewindow.nvim",
  event = "VeryLazy",
  keys = {
    {
      "<leader>mm",
      "<cmd>lua require('codewindow').toggle_minimap()<CR>",
      desc = "Alternar Minimapa (CodeWindow)",
      noremap = true,
      silent = false, 
    },
  },
  config = function()
    require("codewindow").setup({
      width = 11,
      win_position = "right",
      syntax_highlight = true,  -- Requer Tree-sitter para funcionar bem
      exclude_filetypes = {
        "help",
        "NvimTree",
        "lazy",
        "mason",
        "TelescopePrompt",
      },
    })
  end,
}








--[[
return {

  "echasnovski/mini.map",
  version = false,
  event = "VeryLazy",
  config = function()
    local minimap = require("mini.map")

    minimap.setup({
      window = {
        side = "right",
        width = 15,
        zindex = 20,
        show_integration_count = false,
      },

      integrations = {
        minimap.gen_integration.diagnostic(), -- Chame a função geradora
--      minimap.gen_integration.location(), -- Chame a função geradora
--      minimap.gen_integration.git(),  -- Chame a função geradora (se tiver gitsigns.nvim)
      },

      vim.keymap.set("n", "<leader>mm", function()
        require("mini.map").toggle()
      end, { desc = "Alternar Minimapa (mini.map)", noremap = true, silent = true }),

      vim.keymap.set("n", "<leader>mf", function()
        require("mini.map").toggle_focus()
      end, { desc = "Focar no Minimapa (mini.map)", noremap = true, silent = true })

    })
  end,
}
]]
