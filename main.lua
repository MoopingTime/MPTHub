-- MPT Hub — WindUI real hub template
-- Buttons use: loadstring(game:HttpGet(url))()

-- ------------------------------------------------------------------
-- Load WindUI (change URL if you use a different raw file)
-- ------------------------------------------------------------------
local windUrl = "https://raw.githubusercontent.com/Footagesus/WindUI/main/Example.lua"
local WindUI = nil
do
    local ok, body = pcall(function() return game:HttpGet(windUrl) end)
    if not ok or not body or #body < 10 then
        error("Failed to fetch WindUI. Check URL or your executor's HTTP support.")
    end
    local loadOk, libOrErr = pcall(loadstring(body))
    if not loadOk then error("Failed to run WindUI code: "..tostring(libOrErr)) end
    WindUI = libOrErr or _G.WindUI
    if type(WindUI) ~= "table" then
        error("WindUI did not return a library table. The Example.lua might not return a table.")
    end
end

-- ------------------------------------------------------------------
-- Helpers
-- ------------------------------------------------------------------
local function safeHttpGet(url)
    local ok, res = pcall(function() return game:HttpGet(url) end)
    if not ok then
        return false, res
    end
    return true, res
end

local function execLoadstringFromUrl(url)
    -- direct behaviour requested: loadstring(game:HttpGet(url))()
    local ok, body = safeHttpGet(url)
    if not ok then
        if type(WindUI) == "table" and WindUI.Notify then
            pcall(function() WindUI:Notify({ Title = "Fetch failed", Content = tostring(body), Duration = 3 }) end)
        end
        warn("HTTP GET failed:", body)
        return
    end

    local fnOk, fnOrErr = pcall(function() return (loadstring or load)(body) end)
    if not fnOk then
        if type(WindUI) == "table" and WindUI.Notify then
            pcall(function() WindUI:Notify({ Title = "Compile failed", Content = tostring(fnOrErr), Duration = 4 }) end)
        end
        warn("loadstring compile failed:", fnOrErr)
        return
    end

    local execOk, execErr = pcall(fnOrErr)
    if not execOk then
        if type(WindUI) == "table" and WindUI.Notify then
            pcall(function() WindUI:Notify({ Title = "Execution error", Content = tostring(execErr), Duration = 4 }) end)
        end
        warn("Script execution error:", execErr)
        return
    end

    if type(WindUI) == "table" and WindUI.Notify then
        pcall(function() WindUI:Notify({ Title = "Loaded", Content = "Script executed successfully", Duration = 2 }) end)
    end
end

-- ------------------------------------------------------------------
-- Create Window + Tabs
-- ------------------------------------------------------------------
local Window = WindUI:CreateWindow({
    Title = "MPT Hub",
    Icon = "palette",
    Author = "by Mooping",
    Folder = "MPT_Hub_Configs",
    Size = UDim2.fromOffset(640, 520),
    Theme = "Dark"
})

local ScriptsTab   = Window:Tab({ Title = "Scripts", Icon = "code" })
local UtilitiesTab = Window:Tab({ Title = "Utilities", Icon = "wrench" })
local SettingsTab  = Window:Tab({ Title = "Settings", Icon = "sliders" })

-- small helper to create a section-like divider (if your WindUI supports Tab:Section you can swap)
local function sectionDivider(tab, title)
    tab:Divider({ Title = title })
    tab:Space()
end

-- ------------------------------------------------------------------
-- SCRIPTS TAB (buttons that run loadstring(game:HttpGet(url))() )
-- ------------------------------------------------------------------
sectionDivider(ScriptsTab, "Main Scripts")

ScriptsTab:Button({
    Title = "🌿 Infinite Yield",
    Description = "Classic admin commands",
    Callback = function()
        execLoadstringFromUrl("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source")
    end
})

ScriptsTab:Button({
    Title = "🧪 Example Pastebin",
    Description = "Replace URL with your paste",
    Callback = function()
        execLoadstringFromUrl("https://pastebin.com/raw/xxxxxxxx") -- change to real link
    end
})

ScriptsTab:Button({
    Title = "🔧 Custom Script (inline)",
    Description = "Runs a small inline script example",
    Callback = function()
        -- inline example executed directly (no HTTP)
        local inline = [[
            print("Hello from inline script!")
            -- put trusted inline code here
        ]]
        local ok, fn = pcall(function() return (loadstring or load)(inline) end)
        if not ok then warn("Inline compile error:", fn); return end
        pcall(fn)
    end
})

-- ------------------------------------------------------------------
-- UTILITIES TAB
-- ------------------------------------------------------------------
sectionDivider(UtilitiesTab, "General Utilities")

UtilitiesTab:Toggle({
    Title = "Auto-Notify",
    Description = "Automatically notify when a script finishes",
    Value = false,
    Callback = function(state)
        -- store state somewhere if you like
        print("Auto-Notify:", state)
    end
})

UtilitiesTab:Slider({
    Title = "Volume (UI)",
    Description = "Dummy slider for settings",
    Value = { Min = 0, Max = 100, Default = 50 },
    Callback = function(val)
        print("Slider ->", val)
    end
})

UtilitiesTab:Dropdown({
    Title = "Quick Actions",
    Description = "Select a quick action",
    Options = { "Rejoin", "Respawn", "Teleport (example)" },
    Default = "Rejoin",
    Callback = function(choice)
        print("Dropdown ->", choice)
    end
})

UtilitiesTab:Input({
    Title = "Custom URL",
    Description = "Paste a raw URL here and press Run",
    Placeholder = "https://raw.githubusercontent.com/...",
    Text = "",
    Callback = function(text)
        -- use later with a button
        UtilitiesTab:Destroy() -- (example) <- remove if you don't want that behavior
    end
})

-- small row: run custom url (we'll create a button that reads from an Input by storing the value)
local customUrl = ""
-- create Input again but capture value properly
UtilitiesTab:Input({
    Title = "Run URL Now",
    Description = "Type raw script URL then press Run",
    Placeholder = "https://raw.githubusercontent.com/...",
    Text = "",
    Callback = function(text)
        customUrl = tostring(text or "")
        print("Set customUrl:", customUrl)
    end
})
UtilitiesTab:Button({
    Title = "Run Custom URL",
    Description = "Executes the URL typed above",
    Callback = function()
        if customUrl == "" then
            if WindUI and WindUI:Notify then pcall(function() WindUI:Notify({ Title = "Error", Content = "No URL entered", Duration = 2 }) end) end
            return
        end
        execLoadstringFromUrl(customUrl)
    end
})

UtilitiesTab:Button({
    Title = "Toggle UI",
    Description = "Show/hide the whole window",
    Callback = function()
        pcall(function() Window:ToggleUI() end)
    end
})

UtilitiesTab:Button({
    Title = "Clear Notifications",
    Description = "Removes WindUI notifications (if available)",
    Callback = function()
        pcall(function() WindUI:ClearNotifications() end)
    end
})

-- ------------------------------------------------------------------
-- SETTINGS TAB
-- ------------------------------------------------------------------
sectionDivider(SettingsTab, "Appearance & Config")

SettingsTab:ColorPicker({
    Title = "Accent Color",
    Description = "Change UI accent (if supported by your WindUI)",
    Default = {1, 0.5, 0}, -- example; some versions expect Color3 or RGB table
    Callback = function(col)
        print("Color chosen:", col)
        -- apply to theme if WindUI supports runtime theming
        pcall(function() WindUI:SetAccentColor(col) end)
    end
})

SettingsTab:Dropdown({
    Title = "Theme",
    Description = "Select UI theme",
    Options = { "Dark", "Light" },
    Default = "Dark",
    Callback = function(choice)
        print("Theme ->", choice)
        pcall(function() WindUI:SetTheme(choice) end)
    end
})

SettingsTab:Button({
    Title = "Save Config",
    Description = "Saves current settings",
    Callback = function()
        pcall(function() WindUI:SaveConfig("MPT_Default") end)
        pcall(function() WindUI:Notify({ Title = "Config", Content = "Saved", Duration = 2 }) end)
    end
})

SettingsTab:Button({
    Title = "Load Config",
    Description = "Loads saved settings",
    Callback = function()
        pcall(function() WindUI:LoadConfig("MPT_Default") end)
        pcall(function() WindUI:Notify({ Title = "Config", Content = "Loaded", Duration = 2 }) end)
    end
})

SettingsTab:Space()
SettingsTab:Divider({ Title = "About" })
SettingsTab:Paragraph({
    Title = "MPT Hub",
    Content = "Lightweight hub template using WindUI. Replace script URLs with your trusted sources. Use save/load to keep settings."
})

-- ------------------------------------------------------------------
-- End of template
-- ------------------------------------------------------------------

print("MPT Hub loaded. Open the 'Scripts' tab to run scripts.")
