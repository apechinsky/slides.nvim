-- Init plugin
-- This file is called automatically

vim.api.nvim_create_user_command("Slides", function ()
    require("apechinsky/slides").start()
end, {})
