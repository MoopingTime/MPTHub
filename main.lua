-- 🌀 Load WindUI Library
local WindUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/Footagesus/WindUI/main/Example.lua"))()

-- 🪟 Create Main Window
local Window = WindUI:CreateWindow({
    Title = "MPT Hub",
    Icon = "palette",
    Author = "by Mooping",
    Folder = "ScriptLoaderHub",  -- folder to save configs
    Size = UDim2.fromOffset(580, 460),
    Theme = "Dark",
})

-- 🧭 Tabs
local ScriptsTab = Window:Tab({ Title = "Scripts", Icon = "code" })
local UtilitiesTab = Window:Tab({ Title = "Utilities", Icon = "wrench" })
local ConfigTab = Window:Tab({ Title = "Config", Icon = "save" })

---------------------------------------------------------------------
-- ⚡ Helper Function: Safe Loadstring Runner
---------------------------------------------------------------------
local function runScript(url)
    WindUI:Notify({
        Title = "Loading...",
        Content = "Fetching script from:\n" .. url,
        Duration = 2,
        Icon = "cloud-download",
    })

    task.spawn(function()
        local ok, result = pcall(game.HttpGet, game, url)
        if not ok then
            WindUI:Notify({
                Title = "Error",
                Content = "Failed to fetch script:\n" .. tostring(result),
                Duration = 3,
                Icon = "x-circle",
            })
            return
        end

        local func, loadErr = loadstring(result)
        if not func then
            WindUI:Notify({
                Title = "Loadstring Error",
                Content = tostring(loadErr),
                Duration = 3,
                Icon = "alert-triangle",
            })
            return
        end

        local success, execErr = pcall(func)
        if not success then
            WindUI:Notify({
                Title = "Execution Failed",
                Content = tostring(execErr),
                Duration = 3,
                Icon = "x",
            })
            return
        end

        WindUI:Notify({
            Title = "Script Loaded",
            Content = "Script executed successfully ✅",
            Duration = 3,
            Icon = "check",
        })
    end)
end

---------------------------------------------------------------------
-- 🧪 SCRIPT BUTTONS TAB
---------------------------------------------------------------------
ScriptsTab:Button({
    Title = "🌿 Infinite Yield",
    Desc = "Executes the Infinite Yield script",
    Callback = function()
        runScript("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source")
    end
})

-- Add more buttons below if you want:
--[[
ScriptsTab:Button({
    Title = "🚀 Example Script",
    Desc = "Runs your custom script",
    Callback = function()
        runScript("https://your-raw-script-link-here.lua")
    end
})
]]

---------------------------------------------------------------------
-- 🛠 UTILITIES TAB
---------------------------------------------------------------------
UtilitiesTab:Button({
    Title = "Clear Notifications",
    Desc = "Clears all active WindUI notifications",
    Callback = function()
        WindUI:ClearNotifications()
    end
})

UtilitiesTab:Button({
    Title = "UI Toggle",
    Desc = "Toggles visibility of the UI",
    Callback = function()
        Window:ToggleUI()
    end
})

---------------------------------------------------------------------
-- 💾 CONFIG TAB (Save / Load)
---------------------------------------------------------------------
ConfigTab:Button({
    Title = "Save Config",
    Desc = "Save your UI settings",
    Callback = function()
        WindUI:SaveConfig("MyDefaultConfig")
        WindUI:Notify({
            Title = "Config",
            Content = "Settings saved ✅",
            Duration = 2,
            Icon = "save"
        })
    end
})

ConfigTab:Button({
    Title = "Load Config",
    Desc = "Load your saved UI settings",
    Callback = function()
        WindUI:LoadConfig("MyDefaultConfig")
        WindUI:Notify({
            Title = "Config",
            Content = "Settings loaded ✅",
            Duration = 2,
            Icon = "upload"
        })
    end
})
