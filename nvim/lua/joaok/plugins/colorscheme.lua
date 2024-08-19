function ColorMyPencils(color)
  color = color or "default"
  vim.cmd.colorscheme(color)

  vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
  vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

return {
  {
    "joaok-dev/defaultplus",
    lazy = false,
    name = "defaultplus",
    config = function()
      local styles = {
        comments = { italic = false },
        keywords = { italic = false },
      }
      ColorMyPencils()
    end,
  },
}

