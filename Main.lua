local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "My Delta Hub ⚡",
   LoadingTitle = "Delta Hub Loading...",
   LoadingSubtitle = "by chkheidzeatuka",
   ConfigurationSaving = {
      Enabled = false,
      FolderName = "DeltaHub",
      FileName = "HubConfig"
   },
   Discord = {
      Enabled = false,
      Invite = "",
      RememberJoins = false
   },
   KeySystem = false -- Tells Rayfield not to look for a password
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
