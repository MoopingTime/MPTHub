-- 🌬 WindUI Hub Template (Full Version)
-- ✅ Fixed "attempt to call a nil value"
-- ✅ Clean structure + example UI

--// 🌀 Load WindUI
local windUrl = "https://raw.githubusercontent.com/Footagesus/WindUI/main/Example.lua"
local windCode = game:HttpGet(windUrl)
local windFn = loadstring(windCode)
if windFn then
    windFn()
else
    error("❌ Failed to load WindUI script.")
end

--// 🌐 Wait for WindUI to initialize
local WindUI = _G.WindUI or WindUI
if not WindUI then
    error("❌ WindUI failed to initialize. Check the URL or script.")
end

--// 🪟 Create Main Window
local Window = WindUI:CreateWindow({
    Title = "⚡ My Hub",
    Description = "WindUI Hub Template",
    Theme = "Dark" -- or "Light"
})

--// 🧭 Create Tabs
local MainTab = Window:CreateTab({
    Title = "Main",
    Icon = "rbxassetid://4483345998"
})

local MiscTab = Window:CreateTab({
    Title = "Misc",
    Icon = "rbxassetid://6034509993"
})

--// 🟡 BUTTON
MainTab:CreateButton({
    Title = "Print Hello",
    Description = "Click to print in console",
    Callback = function()
        print("✅ Hello from WindUI Hub!")
    end
})

--// 🔵 TOGGLE
local toggleActive = false
MainTab:CreateToggle({
    Title = "Loop WalkSpeed",
    Description = "Toggle speed loop",
    Default = false,
    Callback = function(state)
        toggleActive = state
        if state then
            print("🚀 Speed loop ON")
            task.spawn(function()
                while toggleActive do
                    pcall(function()
                        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 100
                    end)
                    task.wait(0.5)
                end
            end)
        else
            print("🛑 Speed loop OFF")
            pcall(function()
                game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 16
            end)
        end
    end
})

--// 🟢 SLIDER
MainTab:CreateSlider({
    Title = "WalkSpeed",
    Description = "Adjust speed manually",
    Min = 16,
    Max = 200,
    Default = 16,
    Callback = function(value)
        pcall(function()
            game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = value
        end)
    end
})

--// 📝 PARAGRAPH
MiscTab:CreateParagraph({
    Title = "About",
    Description = "This hub was made with WindUI 🌬"
})

--// 🔘 DROPDOWN EXAMPLE
MiscTab:CreateDropdown({
    Title = "Select Mode",
    Description = "Choose an option",
    Items = {"Normal", "Stealth", "Ultra"},
    Default = "Normal",
    Callback = function(selected)
        print("🌐 Selected mode:", selected)
    end
})

print("✅ WindUI Hub loaded successfully!")
