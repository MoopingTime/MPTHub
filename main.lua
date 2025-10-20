-- Load the library (make sure this URL is correct for your version)
local WindUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/Footagesus/WindUI/refs/heads/main/Example.lua"))()

-- Create a window
local Window = WindUI:CreateWindow({
    Title = "My App",
    Icon = "palette",         -- icon name (from the library’s supported icons)
    Author = "by Me",
    Folder = "MyAppFolder",
    Size = UDim2.fromOffset(580, 460),
    Theme = "Dark",
    SideBarWidth = 200,
    User = {
        Enabled = true,
        Anonymous = false,
        Callback = function()
            print("User icon clicked!")
            WindUI:Notify({
                Title = "User Action",
                Content = "You clicked the user button!",
                Duration = 2
            })
        end,
    },
})

-- Notify at startup
WindUI:Notify({
    Title = "Welcome",
    Content = "My App with WindUI is ready!",
    Duration = 3,
    Icon = "circle-play",
})

-- Create tabs/sections
local MainTab   = Window:Tab({ Title = "Main", Icon = "house" })
local SettingsTab = Window:Tab({ Title = "Settings", Icon = "gear" })

-- On “Main” tab: add a button
MainTab:Button({
    Title = "Click Me",
    Desc = "Press this button to do something",
    Callback = function()
        print("Button was clicked!")
        WindUI:Notify({
            Title = "Hello",
            Content = "You clicked the button!",
            Duration = 2,
            Icon = "smile"
        })
    end,
})

-- On Settings tab: add a toggle and a slider
SettingsTab:Toggle({
    Title = "Enable Feature",
    Value = false,
    Callback = function(state)
        print("Toggle changed →", state)
        WindUI:Notify({
            Title = "Feature Toggle",
            Content = "Enabled = " .. tostring(state),
            Duration = 2
        })
    end,
})

SettingsTab:Slider({
    Title = "Volume",
    Desc = "Adjust volume level",
    Value = { Min = 0, Max = 100, Default = 50 },
    Callback = function(val)
        print("Slider value →", val)
    end,
})
