-- Load Fluent Library and Addons
local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/SaveManager.lua"))()
local InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/InterfaceManager.lua"))()

-- Create Fluent Window
local Window = Fluent:CreateWindow({
    Title = "Fluent " .. Fluent.Version,
    SubTitle = "by dawid",
    TabWidth = 160,
    Size = UDim2.fromOffset(580, 460),
    Acrylic = true,
    Theme = "Dark",
    MinimizeKey = Enum.KeyCode.LeftControl
})

-- Create Tabs
local Tabs = {
    Main = Window:AddTab({ Title = "Main", Icon = "" }),
    Settings = Window:AddTab({ Title = "Settings", Icon = "settings" })
}

local Options = Fluent.Options

-- Notification
Fluent:Notify({
    Title = "Notification",
    Content = "This is a notification",
    SubContent = "SubContent",
    Duration = 5
})

-- ESP Functionality
local function createESP(instance)
    local highlight = Instance.new("Highlight")
    highlight.Adornee = instance
    highlight.FillColor = Color3.new(1, 0, 0)  -- Change color as needed
    highlight.FillTransparency = 0.5  -- Adjust transparency
    highlight.Parent = instance
end

local function setupESP()
    for _, targetPlayer in pairs(game.Players:GetPlayers()) do
        if targetPlayer ~= game.Players.LocalPlayer then
            if targetPlayer.Character then
                createESP(targetPlayer.Character)
            end
        end
    end

    game.Players.PlayerAdded:Connect(function(newPlayer)
        newPlayer.CharacterAdded:Wait()
        createESP(newPlayer.Character)
    end)

    game.Players.PlayerRemoving:Connect(function(leavingPlayer)
        if leavingPlayer.Character and leavingPlayer.Character:FindFirstChild("Highlight") then
            leavingPlayer.Character.Highlight:Destroy()
        end
    end)
end

-- Exunys Aimbot Code
-- Universal Aimbot Module by Exunys © CC0 1.0 Universal (2023 - 2024)
-- Initialization of the Aimbot Environment
getgenv().ExunysDeveloperAimbot = {
    DeveloperSettings = {
        UpdateMode = "RenderStepped",
        TeamCheckOption = "TeamColor",
        RainbowSpeed = 1 -- Bigger = Slower
    },

    Settings = {
        Enabled = true,
        TeamCheck = false,
        AliveCheck = true,
        WallCheck = false,
        OffsetToMoveDirection = false,
        OffsetIncrement = 15,
        Sensitivity = 0, -- Animation length (in seconds) before fully locking onto target
        Sensitivity2 = 3.5, -- mousemoverel Sensitivity
        LockMode = 1, -- 1 = CFrame; 2 = mousemoverel
        LockPart = "Head", -- Body part to lock on
        TriggerKey = Enum.UserInputType.MouseButton2,
        Toggle = false
    },

    FOVSettings = {
        Enabled = true,
        Visible = true,
        Radius = 90,
        NumSides = 60,
        Thickness = 1,
        Transparency = 1,
        Filled = false,
        RainbowColor = false,
        RainbowOutlineColor = false,
        Color = Color3.fromRGB(255, 255, 255),
        OutlineColor = Color3.fromRGB(0, 0, 0),
        LockedColor = Color3.fromRGB(255, 150, 150)
    },

    Blacklisted = {},
    FOVCircleOutline = Drawing.new("Circle"),
    FOVCircle = Drawing.new("Circle")
}

local Environment = getgenv().ExunysDeveloperAimbot

setrenderproperty(Environment.FOVCircle, "Visible", false)
setrenderproperty(Environment.FOVCircleOutline, "Visible", false)

-- Core Functions for Aimbot (Omitted for brevity, please include the entire logic provided in your original aimbot code)
-- [Insert the entire logic of the aimbot functionality here, including methods like Load, GetClosestPlayer, etc.]

local Load = function()
    -- Initialization logic for Aimbot including connections to render steps and input handling
    -- [Insert your entire Load function logic here]
end

-- Add Aimbot Toggle Button
Tabs.Main:AddButton({
    Title = "Toggle Aimbot",
    Description
