local st_modules = require "nvchad_ui.statusline.modules"

return {
    cwd = function()
        local present, session = pcall(require, "auto-session-library")

        if not present then
            return st_modules.cwd()
        end

        local present, session_name = pcall(session.current_session_name)

        if not present then
            return st_modules.cwd()
        end

        return st_modules.cwd() .. " (" .. session.current_session_name() .. ") "
    end
}

