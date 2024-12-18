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

    game.Players.PlayerAdded:Connect(function(newPlayer)
        newPlayer.CharacterAdded:Wait()
        createESP(newPlayer.Character)
    end)
end

-- Add ESP Toggle Button
local espEnabled = false
Tabs.Main:AddButton({
    Title = "Toggle ESP",
    Description = "Enable or disable ESP for all players.",
    Callback = function()
        espEnabled = not espEnabled
        if espEnabled then
            setupESP()
            Fluent:Notify({
                Title = "ESP Enabled",
                Content = "ESP has been enabled for all players.",
                Duration = 5
            })
        else
            for _, player in pairs(game.Players:GetPlayers()) do
                if player.Character and player.Character:FindFirstChild("Highlight") then
                    player.Character.Highlight:Destroy()
                end
            end
            Fluent:Notify({
                Title = "ESP Disabled",
                Content = "ESP has been disabled for all players.",
                Duration = 5
            })
        end
    end
})

-- Other UI Elements (Paragraps, Buttons, Toggles, Sliders etc.)
Tabs.Main:AddParagraph({
    Title = "Paragraph",
    Content = "This is a paragraph.\nSecond line!"
})

-- (Continue adding your previous UI elements here, same as in your original script)

-- Add-ons Configuration
SaveManager:SetLibrary(Fluent)
InterfaceManager:SetLibrary(Fluent)
SaveManager:IgnoreThemeSettings()
SaveManager:SetIgnoreIndexes({})
InterfaceManager:SetFolder("FluentScriptHub")
SaveManager:SetFolder("FluentScriptHub/specific-game")
InterfaceManager:BuildInterfaceSection(Tabs.Settings)
SaveManager:BuildConfigSection(Tabs.Settings)

Window:SelectTab(1)

Fluent:Notify({
    Title = "Fluent",
    Content = "The script has been loaded.",
    Duration = 8
})

SaveManager:LoadAutoloadConfig()