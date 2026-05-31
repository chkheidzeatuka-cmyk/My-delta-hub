local Rayfield = loadstring(game:HttpGet('https://raw.githubusercontent.com/SiriusXFiles/Rayfield/main/source'))()

local Window = Rayfield:CreateWindow({
   Name = "My Delta Hub ⚡",
   LoadingTitle = "Delta Hub Loading...",
   LoadingSubtitle = "by chkheidzeatuka",
   ConfigurationSaving = {
      Enabled = false
   },
   Discord = {
      Enabled = false
   }
})

local PlayerTab = Window:CreateTab("Player Mods", nil)

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
