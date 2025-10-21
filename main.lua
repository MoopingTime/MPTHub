-- ✅ Load WindUI Framework
local WindUI = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()
local UserInputService = game:GetService("UserInputService")

---------------------------------------------------------------------
-- 🌈 WINDOW SETUP
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
-- 💬 DISCORD TAB
---------------------------------------------------------------------
local DiscordTab = Window:Tab({
    Title = "Discord",
    Icon = "message-circle",
})

local defaultInviteCode = "mptdevs"
local defaultInviteLink = "https://discord.gg/" .. defaultInviteCode

local success, Response = pcall(function()
    local DiscordAPI = "https://discord.com/api/v10/invites/" .. defaultInviteCode .. "?with_counts=true&with_expiration=true"
    return game:GetService("HttpService"):JSONDecode(WindUI.Creator.Request({
        Url = DiscordAPI,
        Method = "GET",
        Headers = {
            ["User-Agent"] = "User/MPT-Hub",
            ["Accept"] = "application/json"
        }
    }).Body)
end)

if success and Response and Response.guild then
    DiscordTab:Paragraph({
        Title = Response.guild.name or "MPT Discord",
        Desc = "Members: " .. (Response.approximate_member_count or "N/A") ..
               "\nOnline: " .. (Response.approximate_presence_count or "N/A"),
        Buttons = {
            {
                Title = "Copy Invite",
                Icon = "link",
                Callback = function()
                    setclipboard(defaultInviteLink)
                    WindUI:Notify({
                        Title = "Copied!",
                        Desc = "Invite link copied to clipboard.",
                        Icon = "check",
                        Duration = 3,
                    })
                end,
            },
        },
    })
else
    DiscordTab:Paragraph({
        Title = "MPT Discord",
        Desc = "Members: N/A\nOnline: N/A",
        Buttons = {
            {
                Title = "Copy Invite",
                Icon = "link",
                Callback = function()
                    setclipboard(defaultInviteLink)
                    WindUI:Notify({
                        Title = "Copied!",
                        Desc = "Invite link copied to clipboard.",
                        Icon = "check",
                        Duration = 3,
                    })
                end,
            },
        },
    })
end

---------------------------------------------------------------------
-- 🧠 INFO TAB
---------------------------------------------------------------------
local InfoTab = Window:Tab({
    Title = "Info",
    Icon = "info",
})

InfoTab:Paragraph({
    Title = "Welcome to MPT Hub",
    Desc = "A multi-script hub built with WindUI 🌬️\n\nNew features and updates coming soon!",
    Image = "zap",
    ImageSize = 20,
})

---------------------------------------------------------------------
-- 💻 SCRIPTS TAB
---------------------------------------------------------------------
local ScriptsTab = Window:Tab({
    Title = "Scripts",
    Icon = "code",
})

-- Helper to safely execute loadstrings
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

-- 3 Placeholder Buttons
ScriptsTab:Button({
    Title = "🌿 Infinite Yield",
    Desc = "Universal admin command hub",
    Callback = function()
        runScript("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source")
    end
})

ScriptsTab:Button({
    Title = "🔍 Dark Dex Explorer",
    Desc = "Explore Roblox game instances",
    Callback = function()
        runScript("https://raw.githubusercontent.com/peyton2465/Dex/master/out.lua")
    end
})

ScriptsTab:Button({
    Title = "🧠 Simple ESP",
    Desc = "Basic ESP Script",
    Callback = function()
        runScript("https://pastebin.com/raw/z5v6LRsu")
    end
})

-- 💡 Example: Add more scripts below
--[[
ScriptsTab:Button({
    Title = "🔥 Your Script Name",
    Desc = "Description here",
    Callback = function()
        runScript("https://pastebin.com/raw/YOURSCRIPTID")
    end
})
]]

---------------------------------------------------------------------
-- ⚙️ SETTINGS TAB
---------------------------------------------------------------------
local SettingsTab = Window:Tab({
    Title = "Settings",
    Icon = "settings",
})

SettingsTab:Toggle({
    Title = "Glow Theme",
    Icon = "sun",
    Default = true,
    Callback = function(state)
        WindUI:SetTheme(state and "Glow" or "Berserk")
        WindUI:Notify({
            Title = "Theme Switched",
            Content = state and "Glow Theme" or "Berserk Theme",
            Duration = 2,
            Icon = "paintbrush",
        })
    end,
})

SettingsTab:Button({
    Title = "Clear Notifications",
    Desc = "Removes all active popups",
    Callback = function()
        WindUI:ClearNotifications()
    end,
})

SettingsTab:Button({
    Title = "Close Hub",
    Desc = "Hide the MPT Hub window",
    Callback = function()
        Window:ToggleUI()
    end,
})

---------------------------------------------------------------------
-- 💾 SAVE TAB
---------------------------------------------------------------------
local ConfigTab = Window:Tab({
    Title = "Config",
    Icon = "save",
})

ConfigTab:Button({
    Title = "Save UI Settings",
    Desc = "Store your layout locally",
    Callback = function()
        WindUI:SaveConfig("MPT_Default")
        WindUI:Notify({
            Title = "Config Saved",
            Content = "Settings saved successfully ✅",
            Duration = 2,
            Icon = "save",
        })
    end,
})

ConfigTab:Button({
    Title = "Load UI Settings",
    Desc = "Restore your saved layout",
    Callback = function()
        WindUI:LoadConfig("MPT_Default")
        WindUI:Notify({
            Title = "Config Loaded",
            Content = "Settings restored ✅",
            Duration = 2,
            Icon = "upload",
        })
    end,
})

---------------------------------------------------------------------
-- ✅ END OF HUB
---------------------------------------------------------------------
print("✅ MPT Hub | v1.0.0 loaded successfully.")
