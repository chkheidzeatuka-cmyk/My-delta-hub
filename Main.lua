local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "My Delta Hub ⚡",
   LoadingTitle = "Loading Everything...",
   LoadingSubtitle = "by chkheidzeatuka",
   ConfigurationSaving = { Enabled = false },
   Discord = { Enabled = false },
   KeySystem = false
})

-- Global Farming Variables
_G.AutoClick = false
_G.Weapon = "Melee"

-- Create Tabs
local MainTab = Window:CreateTab("Mega Farm Layout", nil)
local CombatTab = Window:CreateTab("Local Combat", nil)
local PlayerTab = Window:CreateTab("Player Mods", nil)

-- --- MEGA FARM TAB (Loads Ultimate External Hubs) ---
MainTab:CreateSection("Ultimate Auto-Farms (Anti-Cheat Bypassed)")

MainTab:CreateButton({
   Name = "Execute Redz Hub (Best Mobile Auto-Farm)",
   Callback = function()
       loadstring(game:HttpGet("https://raw.githubusercontent.com/REDZ3929/REDZHUB/main/REDZ_HUB/Main.lua"))()
   end,
})

MainTab:CreateButton({
   Name = "Execute W-Azure Hub (Fully Featured)",
   Callback = function()
       loadstring(game:HttpGet("https://api.luarmor.net/files/v3/loaders/3b2169cf53ca6119d74adade79ca333a.lua"))()
   end,
})

MainTab:CreateButton({
   Name = "Execute Hoho Hub",
   Callback = function()
       loadstring(game:HttpGet('https://raw.githubusercontent.com/acsu123/HOHO_H/main/Loading_Screen'))()
   end,
})

-- --- LOCAL COMBAT TAB (Your Custom Tools) ---
CombatTab:CreateSection("Weapon Settings")

CombatTab:CreateDropdown({
   Name = "Select Weapon Type",
   Options = {"Melee", "Sword", "Fruit"},
   CurrentOption = {"Melee"},
   MultipleOptions = false,
   Callback = function(Option)
       _G.Weapon = Option[1]
   end,
})

CombatTab:CreateSection("Combat Toggles")

CombatTab:CreateToggle({
   Name = "Fast Auto-Clicker",
   CurrentValue = false,
   Flag = "AutoClickToggle",
   Callback = function(Value)
       _G.AutoClick = Value
       if Value then
           task.spawn(function()
               while _G.AutoClick do
                   task.wait(0.1)
                   pcall(function()
                       -- Auto-Equip Selected Weapon
                       local player = game.Players.LocalPlayer
                       local character = player.Character
                       if character then
                           for _, tool in pairs(player.Backpack:GetChildren()) do
                               if tool:IsA("Tool") and tool.ToolTip == _G.Weapon then
                                   character.Humanoid:EquipTool(tool)
                               end
                           end
                       end
                       -- Virtual Click Action
                       local VirtualUser = game:GetService("VirtualUser")
                       VirtualUser:CaptureController()
                       VirtualUser:ClickButton1(Vector2.new(850, 520))
                   end)
               end
           end)
       end
   end,
})

-- --- PLAYER TAB ---
PlayerTab:CreateSection("Movement")

PlayerTab:CreateButton({
   Name = "Speed Hack (Fast)",
   Callback = function()
       game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 50
   end,
})

PlayerTab:CreateButton({
   Name = "Super Jump",
   Callback = function()
       game.Players.LocalPlayer.Character.Humanoid.JumpPower = 120
   end,
})
