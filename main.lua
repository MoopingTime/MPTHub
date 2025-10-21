-- ✅ Load WindUI
local WindUI = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()

-- 🪟 Create Window
local Window = WindUI:CreateWindow({
    Title = "MPT Hub | v1.0.0",
    Author = "by Mooping",
    Folder = "MPT_Hub",
    NewElements = true,
    HideSearchBar = false,
    OpenButton = {
        Title = "Open MPT Hub",
        Color = ColorSequence.new(
            Color3.fromHex("#00D1FF"),
            Color3.fromHex("#2B1055")
        )
    }
})

---------------------------------------------------------------------
-- ⚡ Helper: universal loadstring runner
---------------------------------------------------------------------
local function runScript(url)
    WindUI:Notify({
        Title = "Loading Script...",
        Content = url,
        Duration = 2,
        Icon = "terminal",
    })
    task.spawn(function()
        local ok, result = pcall(function()
            loadstring(game:HttpGet(url))()
        end)
        if ok then
            WindUI:Notify({
                Title = "Executed ✅",
                Content = "Script ran successfully.",
                Duration = 2,
                Icon = "check",
            })
        else
            WindUI:Notify({
                Title = "Error ❌",
                Content = tostring(result),
                Duration = 3,
                Icon = "x",
            })
        end
    end)
end

---------------------------------------------------------------------
-- 🧱 TAB 1: Combat Scripts
---------------------------------------------------------------------
local CombatTab = Window:Tab({
    Title = "⚔️ Combat",
    Icon = "sword",
})

CombatTab:Button({
    Title = "Silent Aim",
    Desc = "Enables silent aim mode",
    Callback = function()
        runScript("https://pastebin.com/raw/yourCombatScript1")
    end,
})

CombatTab:Button({
    Title = "Kill Aura",
    Desc = "Auto-attack nearby enemies",
    Callback = function()
        runScript("https://pastebin.com/raw/yourCombatScript2")
    end,
})

---------------------------------------------------------------------
-- 💡 TAB 2: Visual Scripts
---------------------------------------------------------------------
local VisualTab = Window:Tab({
    Title = "🎨 Visual",
    Icon = "eye",
})

VisualTab:Button({
    Title = "ESP",
    Desc = "Highlights players",
    Callback = function()
        runScript("https://pastebin.com/raw/z5v6LRsu")
    end,
})

VisualTab:Button({
    Title = "Chams",
    Desc = "Color player models",
    Callback = function()
        runScript("https://pastebin.com/raw/yourVisualScript")
    end,
})

---------------------------------------------------------------------
-- 🧰 TAB 3: Utility Scripts
---------------------------------------------------------------------
local UtilityTab = Window:Tab({
    Title = "🧰 Utilities",
    Icon = "wrench",
})

UtilityTab:Button({
    Title = "Infinite Yield",
    Desc = "Universal admin commands",
    Callback = function()
        runScript("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source")
    end,
})

UtilityTab:Button({
    Title = "Dex Explorer",
    Desc = "Inspect game instances",
    Callback = function()
        runScript("https://raw.githubusercontent.com/peyton2465/Dex/master/out.lua")
    end,
})

---------------------------------------------------------------------
-- 💾 TAB 4: Config (optional)
---------------------------------------------------------------------
local ConfigTab = Window:Tab({
    Title = "💾 Config",
    Icon = "save",
})

ConfigTab:Button({
    Title = "Save Layout",
    Desc = "Save your UI configuration",
    Callback = function()
        WindUI:SaveConfig("MPT_Config")
    end,
})

ConfigTab:Button({
    Title = "Load Layout",
    Desc = "Restore previous UI configuration",
    Callback = function()
        WindUI:LoadConfig("MPT_Config")
    end,
})

---------------------------------------------------------------------
-- ✅ Hub Loaded
---------------------------------------------------------------------
print("✅ MPT Hub | v1.0.0 loaded successfully")
