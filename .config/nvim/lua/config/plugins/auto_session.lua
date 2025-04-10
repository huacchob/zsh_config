local M = {
    "rmagatti/auto-session",
    config = function()
        require("auto-session").setup({
            log_level = "error",
            auto_session_enable_last_session = false,
            auto_session_root_dir = vim.fn.stdpath("data") .. "/sessions/",
            auto_session_enabled = true,
            auto_save_enabled = true,
            auto_restore_enabled = true,
            auto_session_suppress_dirs = { "~/", "~/Downloads" },
            pre_save_cmds = { "Neotree close" },
            post_restore_cmds = { "Neotree filesystem reveal left" },
            auto_session_use_git_branch = false,
        })
    end,
}

return { M }
