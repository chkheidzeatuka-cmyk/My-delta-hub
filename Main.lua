local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()

-- Creates the Main Window
local Window = OrionLib:MakeWindow({
    Name = "My Delta Hub ⚡", 
    HidePremium = true, 
    SaveConfig = false, 
    IntroText = "Loading Hub..."
})

-- Tab 1: Player Mods
local PlayerTab = Window:MakeTab({
    Name = "Player Mods",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

PlayerTab:AddButton({
    Name = "Speed Hack (Fast)",
    Callback = function()
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 50
    end    
})

PlayerTab:AddButton({
    Name = "Super Jump",
    Callback = function()
        game.Players.LocalPlayer.Character.Humanoid.JumpPower = 120
    end    
})

-- Tab 2: Credits
local CreditsTab = Window:MakeTab({
    Name = "Credits",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

CreditsTab:AddLabel("Hub Created by chkheidzeatuka")

-- Initializes the UI
OrionLib:Init()
