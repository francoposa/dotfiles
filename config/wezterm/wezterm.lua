local wezterm = require "wezterm"

--
-- Basic Config
--

local config = wezterm.config_builder()

config.color_scheme = "Monokai"
config.color_scheme_dirs = {"~/.config/wezterm/colors"}
config.color_scheme = "Kitty Low Contrast"

config.font = wezterm.font "Hack"
config.font_size = 18.0

config.default_cursor_style = "BlinkingBlock"

--
-- Custom Scripting
--

local function get_cwd(tab)
    return tab.active_pane.current_working_dir.file_path or ""
end

local function truncate_path(path, max_length)
    if #path <= max_length then
        return path
    end
    local truncation_marker = "..."
    local available_length = max_length - #truncation_marker
    return truncation_marker .. path:sub(-available_length)
end

local function format_cwd(cwd)
    local HOME_DIR = string.format("file://%s", os.getenv("HOME"))
    return cwd == HOME_DIR and "~/" or truncate_path(cwd, 32)
end

-- Pretty format the tab title
-- This only utilizes the current working dir for now
local function format_title(tab)
    local cwd = get_cwd(tab)
    cwd = format_cwd(cwd)
    return cwd
end

-- Returns title set from `tab:set_title()` or `wezterm cli set-tab-title`;
-- otherwise creates title with our preferred custom format
local function get_tab_title(tab)
    local title = tab.tab_title
    if title and #title > 0 then
        return title
    end
    return format_title(tab)
end

-- On format tab title events, override the default handling to return a custom title
wezterm.on(
    "format-tab-title",
    function(tab)
        local title = get_tab_title(tab)
        return title
    end
)

-- SpawnTab next to current tab
-- https://github.com/wez/wezterm/issues/909
config.keys = {
    {
        key = "t",
        mods = "CTRL|SHIFT",
        action = wezterm.action_callback(
            function(win, pane)
                local mux_win = win:mux_window()
                local tabs_with_info = mux_win:tabs_with_info()
                for _, item in ipairs(tabs_with_info) do
                    if item.is_active then
                        -- spawned tab will automatically become the active tab
                        mux_win:spawn_tab({})
                        -- MoveTab operates on the active tab
                        win:perform_action(wezterm.action.MoveTab(item.index + 1), pane)
                        return
                    end
                end
            end
        )
    }
}

return config
