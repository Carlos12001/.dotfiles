-- lua/plugins/transparent.lua
return {
  {
    -- Any plugin that is always present works; we only need
    -- a place to attach our init function.  Using LazyVim itself,
    -- but in *init* (not config) so we don't clobber its setup.
    "LazyVim/LazyVim",
    init = function()
      local function set_transparent()
        for _, grp in ipairs({
          "Normal", "NormalNC", "NormalFloat", "FloatBorder",
          "Pmenu", "PmenuSel", "StatusLine", "StatusLineNC",
          "VertSplit", "SignColumn", "LineNr", "CursorLine",
          "CursorLineNr", "Folded", "EndOfBuffer", "NonText",
        }) do
          -- use api so we don't rely on :highlight’s string parsing
          vim.api.nvim_set_hl(0, grp, { bg = "none" })
        end
      end

      -- 1.  Run every time a colourscheme is applied
      vim.api.nvim_create_autocmd("ColorScheme", {
        callback = set_transparent,
      })
      -- 2.  Run once at the very end of startup, after all plugins
      vim.api.nvim_create_autocmd("VimEnter", {
        callback = set_transparent,
      })
    end,
  },
}
