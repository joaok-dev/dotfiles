return {

  -- Treesitter
  -- Advanced syntax highlighting and code parsing to improve editing and navigation
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "cmake",
        "cpp",
        "css",
        "dockerfile",
        "go",
        "http",
        "just",
        "php",
        "ruby",
        "rust",
        "scala",
        "scss",
        "sql",
        "svelte",
        "vue",
      },
      auto_install = true,
    },
  },
}
