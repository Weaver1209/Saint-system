-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Sync Neovim unnamed register with system clipboard (Wayland / wl-clipboard)
vim.opt.clipboard = "unnamedplus"

-- Load aether theme from generated file
local ok, aether_spec = pcall(dofile, os.getenv("HOME") .. "/.config/aether/theme/neovim.lua")

require("lazy").setup(ok and aether_spec or {}, {
  change_detection = { notify = false },
})

-- Apply aether colorscheme if available
if ok then
  pcall(vim.cmd.colorscheme, "aether")
end
