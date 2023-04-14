local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

-- 保存此文件时自动更新安装插件
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins-setup.lua source <afile> | PackerSync
  augroup end
]])

return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'
  use 'folke/tokyonight.nvim' -- 主题插件
  use {
    'nvim-lualine/lualine.nvim', -- 状态栏
    requires = { 'nvim-tree/nvim-web-devicons', opt = true }
  }
  use {
    'nvim-tree/nvim-tree.lua', -- 文档树
    requires = {
      'nvim-tree/nvim-web-devicons', -- 文档树图标
    },
    config = function()
      require("nvim-tree").setup {}
    end
  }
  use 'christoomey/vim-tmux-navigator' -- 窗口定位
  use 'nvim-treesitter/nvim-treesitter' -- 语法高亮

  use {
    'williamboman/mason.nvim',
    'williamboman/mason-lspconfig.nvim', -- 统一管理mason.nvim和lspconfig
    'neovim/nvim-lspconfig'
  }

  -- 自动补全
  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/cmp-path' -- 文件路径
  use 'hrsh7th/cmp-nvim-lsp'
  use 'L3MON4D3/LuaSnip' -- snippests引擎
  use 'saadparwaiz1/cmp_luasnip'
  use 'rafamadriz/friendly-snippets'

  use "numToStr/Comment.nvim" -- gcc和gc注释
  use "windwp/nvim-autopairs" -- 自动补全括号

  use "akinsho/bufferline.nvim" -- buffer分割线
  use "lewis6991/gitsigns.nvim" -- 左则git提示

  use {
    'nvim-telescope/telescope.nvim', tag = '0.1.1',  -- 文件检索
    requires = { {'nvim-lua/plenary.nvim'} }
  }

  -- install without yarn or npm
  use({
      "iamcco/markdown-preview.nvim",
      run = function() vim.fn["mkdp#util#install"]() end,
  })

  -- markdown浏览器预览
  use({ "iamcco/markdown-preview.nvim",
    run = "cd app && npm install",
    setup = function() vim.g.mkdp_filetypes = { "markdown" } end,
    ft = { "markdown" },
  })

  if packer_bootstrap then
    require('packer').sync()
  end
end)
