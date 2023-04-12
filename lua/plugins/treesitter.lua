require'nvim-treesitter.configs'.setup {
  -- 添加不同语言
  ensure_installed = { "vim", "bash", "c", "cpp", "javascript", "json", "lua", "java", "go", "rust" }, 

  highlight = { enable = true },
  indent = { enable = true }
}
