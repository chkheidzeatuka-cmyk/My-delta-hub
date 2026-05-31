-- Blox Fruits Delta Executor Full Hub
-- Supports: Delta, Arceus X, Fluxus, Codex
-- Loadstring: loadstring(game:HttpGet("https://pastebin.com/raw/XXXXXXXX"))()

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local VirtualUser = game:GetService("VirtualUser")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")

-- UI Library (custom lightweight)
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "BloxFruitsHub"
ScreenGui.Parent = game:GetService("CoreGui")

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 500, 0, 600)
MainFrame.Position = UDim2.new(0.5, -250, 0.5, -300)
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
MainFrame.BackgroundTransparency = 0.1
MainFrame.BorderSizePixel = 0
MainFrame.Parent = ScreenGui

local Corner = Instance.new("UICorner")
Corner.CornerRadius = UDim.new(0, 8)
Corner.Parent = MainFrame

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 40)
Title.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
Title.Text = "BLOX FRUITS FULL HUB [DELTA]"
Title.TextColor3 = Color3.fromRGB(255, 200, 100)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 18
Title.Parent = MainFrame

local TabButtons = {}
local TabContents = {}

local function CreateTab(name, position)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 100, 0, 40)
    btn.Position = UDim2.new(0, position, 0, 40)
    btn.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
    btn.Text = name
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.GothamSemibold
    btn.TextSize = 14
    btn.Parent = MainFrame
    
    local content = Instance.new("ScrollingFrame")
    content.Size = UDim2.new(1, 0, 1, -80)
    content.Position = UDim2.new(0, 0, 0, 80)
    content.BackgroundTransparency = 1
    content.CanvasSize = UDim2.new(0, 0, 0, 800)
    content.ScrollBarThickness = 6
    content.Visible = false
    content.Parent = MainFrame
    
    btn.MouseButton1Click:Connect(function()
        for _, c in pairs(TabContents) do c.Visible = false end
        content.Visible = true
        for _, b in pairs(TabButtons) do 
            b.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
        end
        btn.BackgroundColor3 = Color3.fromRGB(65, 65, 85)
    end)
    
    table.insert(TabButtons, btn)
    table.insert(TabContents, content)
    return content
end

local function AddToggle(parent, text, y, callback)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 480, 0, 30)
    frame.Position = UDim2.new(0, 10, 0, y)
    frame.BackgroundTransparency = 1
    frame.Parent = parent
    
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(0, 400, 1, 0)
    label.Text = text
    label.TextColor3 = Color3.fromRGB(220, 220, 220)
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.BackgroundTransparency = 1
    label.Font = Enum.Font.Gotham
    label.TextSize = 13
    label.Parent = frame
    
    local toggle = Instance.new("TextButton")
    toggle.Size = UDim2.new(0, 40, 0, 20)
    toggle.Position = UDim2.new(1, -50, 0.5, -10)
    toggle.BackgroundColor3 = Color3.fromRGB(80, 80, 90)
    toggle.Text = ""
    toggle.Parent = frame
    
    local state = false
    toggle.MouseButton1Click:Connect(function()
        state = not state
        toggle.BackgroundColor3 = state and Color3.fromRGB(0, 200, 100) or Color3.fromRGB(80, 80, 90)
        callback(state)
    end)
end

local function AddButton(parent, text, y, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 460, 0, 35)
    btn.Position = UDim2.new(0, 20, 0, y)
    btn.BackgroundColor3 = Color3.fromRGB(55, 55, 75)
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.GothamSemibold
    btn.TextSize = 14
    btn.Parent = parent
    btn.MouseButton1Click:Connect(callback)
end

-- Combat Tab
local combatTab = CreateTab("COMBAT", 10)
-- Auto Farm Tab
local farmTab = CreateTab("AUTO FARM", 120)
-- Fruit Tab
local fruitTab = CreateTab("FRUIT", 230)
-- Teleport Tab
local teleportTab = CreateTab("TELEPORT", 340)
-- Misc Tab
local miscTab = CreateTab("MISC", 450)

-- Variables
local autoAttack = false
local autoFarm = false
local autoCollect = false
local farmPart = nil
local currentTarget = nil

-- Get all enemies
local function GetEnemies()
    local enemies = {}
    for _, v in pairs(Workspace.Enemies:GetChildren()) do
        if v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
            table.insert(enemies, v)
        end
    end
    return enemies
end

-- Auto Attack
RunService.RenderStepped:Connect(function()
    if autoAttack then
        local enemies = GetEnemies()
        if #enemies > 0 then
            local closest = nil
            local closestDist = math.huge
            for _, enemy in pairs(enemies) do
                local dist = (LocalPlayer.Character.HumanoidRootPart.Position - enemy.HumanoidRootPart.Position).Magnitude
                if dist < closestDist then
                    closest = enemy
                    closestDist = dist
                end
            end
            if closest and closestDist < 25 then
                -- Click to attack
                game:GetService("VirtualInputManager"):SendMouseButtonEvent(0, 0, 0, true, game, 0)
                wait(0.05)
                game:GetService("VirtualInputManager"):SendMouseButtonEvent(0, 0, 0, false, game, 0)
            end
        end
    end
end)

-- Auto Farm (NPC kill + collect)
spawn(function()
    while true do
        wait(0.1)
        if autoFarm then
            local enemies = GetEnemies()
            if #enemies > 0 then
                local target = enemies[1]
                if target and target:FindFirstChild("HumanoidRootPart") then
                    LocalPlayer.Character.HumanoidRootPart.CFrame = target.HumanoidRootPart.CFrame * CFrame.new(0, 0, 3)
                    wait(0.05)
                    -- Auto attack
                    game:GetService("VirtualInputManager"):SendMouseButtonEvent(0, 0, 0, true, game, 0)
                    wait(0.1)
                    game:GetService("VirtualInputManager"):SendMouseButtonEvent(0, 0, 0, false, game, 0)
                end
            end
        end
    end
end)

-- Auto Collect (fruits, chests)
spawn(function()
    while true do
        wait(0.5)
        if autoCollect then
            for _, v in pairs(Workspace:GetDescendants()) do
                if v:IsA("Model") and v.Name:find("Fruit") or v.Name:find("Chest") then
                    if v:FindFirstChild("Handle") or v:FindFirstChild("Hitbox") then
                        LocalPlayer.Character.HumanoidRootPart.CFrame = v:GetPivot()
                        wait(0.1)
                    end
                end
            end
        end
    end
end)

-- Teleport to locations
local teleports = {
    {"Marine Starter", Vector3.new(-500, 80, 3000)},
    {"Jungle", Vector3.new(-1400, 50, 3800)},
    {"Desert", Vector3.new(1000, 60, 4200)},
    {"Snow", Vector3.new(800, 150, -1200)},
    {"Magma Village", Vector3.new(-3500, 40, 2500)},
    {"Dark Arena", Vector3.new(2000, 100, 1000)},
    {"Sea of Treats", Vector3.new(-2500, 0, -2000)}
}

-- Build UI Toggles
AddToggle(combatTab, "Auto Attack (Click)", 10, function(val) autoAttack = val end)
AddToggle(combatTab, "Auto Farm NPC", 50, function(val) autoFarm = val end)
AddToggle(combatTab, "Auto Collect Fruits/Chests", 90, function(val) autoCollect = val end)

AddButton(combatTab, "☠️ Kill All NPCs Around", 140, function()
    for _, enemy in pairs(GetEnemies()) do
        LocalPlayer.Character.HumanoidRootPart.CFrame = enemy.HumanoidRootPart.CFrame
        wait(0.1)
    end
end)

-- Fruit Tab
AddButton(fruitTab, "🍎 Store Fruit (Buddha)", 10, function()
    local args = {[1] = "StoreFruit", [2] = "Buddha"}
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
end)

AddButton(fruitTab, "⚡ Store Fruit (Dragon)", 50, function()
    local args = {[1] = "StoreFruit", [2] = "Dragon"}
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
end)

AddButton(fruitTab, "🔥 Store Fruit (Leopard)", 90, function()
    local args = {[1] = "StoreFruit", [2] = "Leopard"}
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
end)

AddButton(fruitTab, "🌀 Reset Fruit (Unequip)", 130, function()
    local args = {[1] = "SetFruit", [2] = ""}
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
end)

-- Teleport Tab
for i, tp in ipairs(teleports) do
    AddButton(teleportTab, "📍 " .. tp[1], 10 + (i-1)*45, function()
        LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(tp[2])
    end)
end

-- Misc Tab
AddButton(miscTab, "💪 Infinite Energy", 10, function()
    LocalPlayer.Character.Humanoid:SetAttribute("Energy", 999999)
    game:GetService("Players").LocalPlayer.Character.Humanoid:GetAttributeChangedSignal("Energy"):Connect(function()
        LocalPlayer.Character.Humanoid:SetAttribute("Energy", 999999)
    end)
end)

AddButton(miscTab, "🛡️ God Mode (No Clip)", 50, function()
    LocalPlayer.Character.HumanoidRootPart.Size = Vector3.new(20, 20, 20)
    LocalPlayer.Character.HumanoidRootPart.Transparency = 0.5
    LocalPlayer.Character.HumanoidRootPart.CanCollide = false
end)

AddButton(miscTab, "🔪 One Hit Kill", 90, function()
    for _, v in pairs(GetEnemies()) do
        if v:FindFirstChild("Humanoid") then
            v.Humanoid.Health = 0
        end
    end
end)

AddButton(miscTab, "💰 Auto Farm Money (Boss)", 130, function()
    while true do
        wait(1)
        -- Farm Graybeard / Vice Admiral
        local bosses = {"Graybeard", "Vice Admiral", "Diamond"}
        for _, bossName in pairs(bosses) do
            local boss = Workspace.Enemies:FindFirstChild(bossName)
            if boss then
                repeat
                    LocalPlayer.Character.HumanoidRootPart.CFrame = boss.HumanoidRootPart.CFrame
                    wait(0.1)
                until not boss.Parent or boss.Humanoid.Health <= 0
            end
        end
    end
end)

print("Blox Fruits Full Hub Loaded - Delta Executor")
