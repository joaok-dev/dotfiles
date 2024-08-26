return {
  "nvim-treesitter/nvim-treesitter",
  opts = function(_, opts)
    -- Add new languages to the ensure_installed list
    vim.list_extend(opts.ensure_installed, {
      "cmake",
      "css",
      "devicetree",
      "gitcommit",
      "gitignore",
      "glsl",
      "go",
      "graphql",
      "http",
      "just",
      "kconfig",
      "meson",
      "ninja",
      "nix",
      "org",
      "php",
      "rst",
      "scss",
      "sql",
      "svelte",
      "vue",
      "wgsl",
    })
  end,
}
