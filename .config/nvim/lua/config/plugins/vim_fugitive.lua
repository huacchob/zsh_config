-- File: lua/plugins/git/fugitive.lua
local M = {
    "tpope/vim-fugitive",
    cmd = {
        "Git",
        "Gedit",
        "Gsplit",
        "Gvsplit",
        "Gtabedit",
        "Gdiffsplit",
        "Gread",
        "Gwrite",
        "GMove",
        "GDelete",
        "GBrowse",
    },
    config = function()
        vim.cmd([[
      augroup FugitiveUIEnhancements
      autocmd!

      " Set fugitive status window as scratch (no save, auto-delete)
      autocmd FileType fugitive setlocal bufhidden=delete nobuflisted nowrap cursorline

      " Dim non-active lines in diff view (for focus)
      autocmd FileType fugitiveblame setlocal cursorline number
      autocmd FileType git setlocal cursorline

      " Add conceal to clean up commit messages visually
      autocmd FileType gitcommit setlocal spell textwidth=72 conceallevel=2

      " Better visual layout for Git commit popup
      autocmd FileType gitcommit highlight Comment ctermfg=DarkGrey guifg=#5c6370

      " Auto-close fugitive buffer on certain events (e.g. when entering another buffer)
      autocmd BufEnter * if &filetype == 'fugitive' && winnr('$') > 1 | quit | endif
      augroup END
      ]])
    end,
}

return { M }
