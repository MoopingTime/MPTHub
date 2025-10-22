-- ✅ Load WindUI Framework
local WindUI = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()

-- ⚙️ Helper Function: Run Script Safely
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
                Content = "Script ran successfully!",
                Duration = 3,
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
-- 🌈 Create Main Window
---------------------------------------------------------------------
local Window = WindUI:CreateWindow({
    Title = "MPT Hub | v1.0.0",
    Author = "by Mooping",
    Folder = "MPT_Hub",
    NewElements = true,
    HideSearchBar = false,
    OpenButton = {
        Title = "Open MPT Hub",
        CornerRadius = UDim.new(1, 0),
        StrokeThickness = 3,
        Enabled = true,
        Draggable = true,
        OnlyMobile = false,
        Color = ColorSequence.new(
            Color3.fromHex("#00D1FF"),
            Color3.fromHex("#2B1055")
        )
    }
})

---------------------------------------------------------------------
-- 🌿 PLANTS VS BRAINROT TAB
---------------------------------------------------------------------
local PvBTab = Window:Tab({
    Title = "🌿 Plants vs Brainrot",
    Icon = "leaf",
})

PvBTab:Button({
    Title = "Main Script",
    Desc = "Plants vs Brainrot Main Hub",
    Callback = function()
        runScript("https://pastebin.com/raw/D3NJXvMk")
    end
})

PvBTab:Button({
    Title = "BHX Hub",
    Desc = "BHX Hub for Plants vs Brainrot",
    Callback = function()
        runScript("https://pastebin.com/raw/myJXEuRc")
    end
})

PvBTab:Button({
    Title = "Updated Script",
    Desc = "Alternate script for Plants vs Brainrot",
    Callback = function()
        runScript("https://pastebin.com/raw/XKPNpzba")
    end
})

---------------------------------------------------------------------
-- 🍇 BLOX FRUITS TAB
---------------------------------------------------------------------
local BloxTab = Window:Tab({
    Title = "🍇 Blox Fruits",
    Icon = "anchor",
})

BloxTab:Button({
    Title = "Xeter Hub",
    Desc = "Blox Fruits - Xeter Hub",
    Callback = function()
        runScript("https://pastebin.com/raw/w7CD8dw5")
    end
})

BloxTab:Button({
    Title = "Redz Hub",
    Desc = "Blox Fruits - Redz Hub",
    Callback = function()
        runScript("https://pastebin.com/raw/TRX3Dj7X")
    end
})

BloxTab:Button({
    Title = "HNC Hub",
    Desc = "Blox Fruits - HNC Hub",
    Callback = function()
        runScript("https://pastebin.com/raw/GMkRCvxv")
    end
})

BloxTab:Button({
    Title = "Blue X Hub",
    Desc = "Blox Fruits - Blue X Hub",
    Callback = function()
        runScript("https://pastebin.com/raw/gtBbc7ta")
    end
})

BloxTab:Button({
    Title = "Lonely Hub",
    Desc = "Blox Fruits - Lonely Hub",
    Callback = function()
        runScript("https://pastebin.com/raw/WmnP4Mey")
    end
})

BloxTab:Button({
    Title = "W-Azure Hub",
    Desc = "Blox Fruits - W-Azure Hub",
    Callback = function()
        runScript("https://pastebin.com/raw/CKhME5sE")
    end
})

---------------------------------------------------------------------
-- 🌙 99 NIGHTS TAB
---------------------------------------------------------------------
local NightsTab = Window:Tab({
    Title = "🌙 99 Nights",
    Icon = "moon",
})

NightsTab:Button({
    Title = "Main Script",
    Desc = "99 Nights - Main Script",
    Callback = function()
        runScript("https://pastebin.com/raw/ML5v0fAA")
    end
})

NightsTab:Button({
    Title = "Foxname Hub",
    Desc = "99 Nights - Foxname Hub",
    Callback = function()
        runScript("https://pastebin.com/raw/FC49iXUA")
    end
})

NightsTab:Button({
    Title = "Voidware",
    Desc = "99 Nights - Voidware Script",
    Callback = function()
        runScript("https://pastebin.com/raw/Tzah5xfi")
    end
})

---------------------------------------------------------------------
-- 💀 STEAL A BRAINROT TAB
---------------------------------------------------------------------
local StealTab = Window:Tab({
    Title = "💀 Steal a Brainrot",
    Icon = "skull",
})

StealTab:Button({
    Title = "Main Script",
    Desc = "Steal a Brainrot Script",
    Callback = function()
        runScript("https://pastebin.com/raw/YMgzWcEt")
    end
})

StealTab:Button({
    Title = "LKZ Hub",
    Desc = "Steal a Brainrot - LKZ Hub",
    Callback = function()
        runScript("https://pastebin.com/raw/NfctN3PG")
    end
})

---------------------------------------------------------------------
-- 🐠 FISCH TAB
---------------------------------------------------------------------
local FischTab = Window:Tab({
    Title = "🐠 Fisch",
    Icon = "fish",
})

FischTab:Button({
    Title = "Zenith Hub",
    Desc = "Fisch - Zenith Hub Script",
    Callback = function()
        runScript("https://pastes.io/raw/fisch-script-zenith-hub")
    end
})

---------------------------------------------------------------------
-- 🐠 FISH IT TAB
---------------------------------------------------------------------
local FischTab = Window:Tab({
    Title = "🐠 Fish It",
    Icon = "fish",
})

FischTab:Button({
    Title = "Than Hub",
    Desc = "Fish It - Than Hub Script",
    Callback = function()
        runScript("https://raw.githubusercontent.com/thantzy/thanhub/refs/heads/main/thanv1")
    end
})

---------------------------------------------------------------------
-- ⚙️ SETTINGS TAB
---------------------------------------------------------------------
local SettingsTab = Window:Tab({
    Title = "⚙️ Settings",
    Icon = "settings",
})

SettingsTab:Button({
    Title = "Clear Notifications",
    Desc = "Remove all popups",
    Callback = function()
        WindUI:ClearNotifications()
    end
})

SettingsTab:Toggle({
    Title = "Glow Theme",
    Icon = "sun",
    Default = true,
    Callback = function(state)
        WindUI:SetTheme(state and "Glow" or "Berserk")
    end
})

---------------------------------------------------------------------
print("✅ MPT Hub | Loaded all scripts successfully!")
