-- lua/user/plugins.lua

-- lazy.nvim 자동 설치 스크립트 (Bootstrap)
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath) -- Neovim에게 lazy.nvim 경로 알려주기

-- Lazy.nvim 설정 시작
require("lazy").setup({
    -- 플러그인 목록 (Specifications) 위치 지정
    -- lua/plugins/ 폴더 안의 .lua 파일들을 자동으로 로드합니다.
    spec = {
        { import = "plugins" },
    },

    -- Lazy.nvim 자체 설정 (선택 사항)
    install = { colorscheme = { "tokyonight", "habamax" } }, -- 설치 시 사용할 임시 색상 테마
    checker = { enabled = true, notify = false }, -- 업데이트 자동 확인 활성화 (알림은 끔)
    performance = {
        rtp = {
            -- Neovim 시작 시 로드할 플러그인 수를 줄여 속도 향상 (필요 시 활성화)
            disabled_plugins = {
                "gzip",
                -- "matchit",
                -- "matchparen",
                -- "netrwPlugin",
                "tarPlugin",
                "tohtml",
                "tutor",
                "zipPlugin",
            },
        },
    },
})

-- print("Lazy plugin manager configured!")
