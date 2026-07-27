local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local VirtualInputManager = game:GetService("VirtualInputManager")
local CoreGui = game:GetService("CoreGui")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Player = Players.LocalPlayer
local Mouse = Player:GetMouse()

if "darkzinhub" ~= "darkzinhub" then return end

local Settings = {
    AutoFarm = false,
    AutoAttack = false,
    LongAttack = false,
    AutoQuest = false,
    FarmDistance = 8,
    FarmDelay = 0.1
}

if CoreGui:FindFirstChild("DarkzinHubUI") then
    CoreGui.DarkzinHubUI:Destroy()
end

local MainGUI = Instance.new("ScreenGui")
MainGUI.Name = "DarkzinHubUI"
MainGUI.Parent = CoreGui

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 500, 0, 380)
MainFrame.Position = UDim2.new(0.5, -250, 0.5, -190)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = MainGUI

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 16)
MainCorner.Parent = MainFrame

local MainStroke = Instance.new("UIStroke")
MainStroke.Thickness = 2
MainStroke.Color = Color3.fromRGB(140, 20, 255)
MainStroke.Parent = MainFrame

local TitleBar = Instance.new("Frame")
TitleBar.Size = UDim2.new(1, 0, 0, 50)
TitleBar.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
TitleBar.BorderSizePixel = 0
TitleBar.Parent = MainFrame

local TitleCorner = Instance.new("UICorner")
TitleCorner.CornerRadius = UDim.new(0, 16)
TitleCorner.Parent = TitleBar

local TitleLine = Instance.new("Frame")
TitleLine.Size = UDim2.new(1, 0, 0, 2)
TitleLine.Position = UDim2.new(0, 0, 1, -2)
TitleLine.BackgroundColor3 = Color3.fromRGB(140, 20, 255)
TitleLine.BorderSizePixel = 0
TitleLine.Parent = TitleBar

local TitleText = Instance.new("TextLabel")
TitleText.Size = UDim2.new(1, -50, 1, 0)
TitleText.Position = UDim2.new(0, 20, 0, 0)
TitleText.Text = "🔮 DARKZIN HUB | Blox Fruits"
TitleText.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleText.TextSize = 20
TitleText.Font = Enum.Font.GothamBold
TitleText.BackgroundTransparency = 1
TitleText.TextXAlignment = Enum.TextXAlignment.Left
TitleText.Parent = TitleBar

local CloseButton = Instance.new("TextButton")
CloseButton.Size = UDim2.new(0, 30, 0, 30)
CloseButton.Position = UDim2.new(1, -40, 0.5, -15)
CloseButton.Text = "✕"
CloseButton.TextColor3 = Color3.fromRGB(140, 20, 255)
CloseButton.TextSize = 18
CloseButton.Font = Enum.Font.GothamBold
CloseButton.BackgroundTransparency = 1
CloseButton.Parent = TitleBar

CloseButton.MouseButton1Click:Connect(function()
    MainGUI:Destroy()
end)

local Container = Instance.new("ScrollingFrame")
Container.Size = UDim2.new(1, -30, 1, -70)
Container.Position = UDim2.new(0, 15, 0, 65)
Container.BackgroundTransparency = 1
Container.BorderSizePixel = 0
Container.ScrollBarThickness = 4
Container.ScrollBarImageColor3 = Color3.fromRGB(140, 20, 255)
Container.Parent = MainFrame

local UIListLayout = Instance.new("UIListLayout")
UIListLayout.Parent = Container
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Padding = UDim.new(0, 10)

local function CreateToggle(Name, SettingName)
    local ToggleFrame = Instance.new("Frame")
    ToggleFrame.Size = UDim2.new(1, -10, 0, 55)
    ToggleFrame.BackgroundColor3 = Color3.fromRGB(22, 22, 22)
    ToggleFrame.BorderSizePixel = 0
    ToggleFrame.Parent = Container
    
    local ToggleCorner = Instance.new("UICorner")
    ToggleCorner.CornerRadius = UDim.new(0, 12)
    ToggleCorner.Parent = ToggleFrame
    
    local ToggleStroke = Instance.new("UIStroke")
    ToggleStroke.Thickness = 1
    ToggleStroke.Color = Color3.fromRGB(50, 50, 50)
    ToggleStroke.Parent = ToggleFrame
    
    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(0.7, 0, 1, 0)
    Label.Position = UDim2.new(0, 15, 0, 0)
    Label.Text = Name
    Label.TextColor3 = Color3.fromRGB(230, 230, 230)
    Label.TextSize = 15
    Label.Font = Enum.Font.GothamSemibold
    Label.BackgroundTransparency = 1
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Parent = ToggleFrame
    
    local CheckBox = Instance.new("TextButton")
    CheckBox.Size = UDim2.new(0, 45, 0, 24)
    CheckBox.Position = UDim2.new(1, -60, 0.5, -12)
    CheckBox.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    CheckBox.Text = ""
    CheckBox.Parent = ToggleFrame
    
    local CBCorner = Instance.new("UICorner")
    CBCorner.CornerRadius = UDim.new(1, 0)
    CBCorner.Parent = CheckBox
    
    local CBStroke = Instance.new("UIStroke")
    CBStroke.Thickness = 1
    CBStroke.Color = Color3.fromRGB(140, 20, 255)
    CBStroke.Parent = CheckBox
    
    local Indicator = Instance.new("Frame")
    Indicator.Size = UDim2.new(0, 18, 0, 18)
    Indicator.Position = UDim2.new(0, 3, 0.5, -9)
    Indicator.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
    Indicator.Parent = CheckBox
    
    local IndCorner = Instance.new("UICorner")
    IndCorner.CornerRadius = UDim.new(1, 0)
    IndCorner.Parent = Indicator
    
    CheckBox.MouseButton1Click:Connect(function()
        Settings[SettingName] = not Settings[SettingName]
        local active = Settings[SettingName]
        
        TweenService:Create(Indicator, TweenInfo.new(0.2), {
            Position = active and UDim2.new(1, -21, 0.5, -9) or UDim2.new(0, 3, 0.5, -9),
            BackgroundColor3 = active and Color3.fromRGB(140, 20, 255) or Color3.fromRGB(100, 100, 100)
        }):Play()
        
        TweenService:Create(ToggleStroke, TweenInfo.new(0.2), {
            Color = active and Color3.fromRGB(140, 20, 255) or Color3.fromRGB(50, 50, 50)
        }):Play()
    end)
end

CreateToggle("Ativar Auto Farm", "AutoFarm")
CreateToggle("Ativar Auto Quest", "AutoQuest")
CreateToggle("Ativar Auto Attack", "AutoAttack")
CreateToggle("Ativar Long Attack (Alcance)", "LongAttack")

local function GerenciarMissao()
    if not Settings.AutoQuest then return end
    local commF = ReplicatedStorage: some_indirect_path_or_nil("Remotes", "CommF_") or (ReplicatedStorage:FindFirstChild("Remotes") and ReplicatedStorage.Remotes:FindFirstChild("CommF_"))
    
    if commF and not Player.PlayerGui.Main.Quest.Visible then
        if Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") then
            Player.Character.HumanoidRootPart.CFrame = CFrame.new(1060, 16, 1551)
            task.wait(0.4)
            commF:InvokeServer("StartQuest", "BanditQuest1", 1)
        end
    end
end

local function AplicarLongAttack()
    if not Settings.LongAttack then return end
    local tool = Player.Character and Player.Character:FindFirstChildOfClass("Tool")
    if tool and tool:FindFirstChild("Handle") then
        tool.Handle.Size = Vector3.new(55, 55, 55)
        tool.Handle.CanCollide = false
    end
end

RunService.Stepped:Connect(function()
    if not Settings.LongAttack then
        local tool = Player.Character and Player.Character:FindFirstChildOfClass("Tool")
        if tool and tool:FindFirstChild("Handle") and tool.Handle.Size.X > 5 then
            tool.Handle.Size = Vector3.new(1, 1, 1)
        end
    end
end)

task.spawn(function()
    while task.wait(Settings.FarmDelay) do
        if Settings.AutoFarm then
            pcall(function()
                GerenciarMissao()
                local alvo = nil
                if workspace:FindFirstChild("Enemies") then
                    for _, npc in pairs(workspace.Enemies:GetChildren()) do
                        if npc:FindFirstChild("Humanoid") and npc.Humanoid.Health > 0 then
                            alvo = npc
                            break
                        end
                    end
                end
                
                if alvo and alvo:FindFirstChild("HumanoidRootPart") and Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") then
                    if not Player.Character.HumanoidRootPart:FindFirstChild("DarkzinFly") then
                        local bv = Instance.new("BodyVelocity")
                        bv.Name = "DarkzinFly"
                        bv.Velocity = Vector3.new(0, 0, 0)
                        bv.MaxForce = Vector3.new(9e9, 9e9, 9e9)
                        bv.Parent = Player.Character.HumanoidRootPart
                    end
                    
                    Player.Character.HumanoidRootPart.CFrame = alvo.HumanoidRootPart.CFrame * CFrame.new(0, Settings.FarmDistance, 0)
                    
                    if Settings.AutoAttack then
                        AplicarLongAttack()
                        local tool = Player.Backpack:FindFirstChildOfClass("Tool")
                        if tool then Player.Character.Humanoid:EquipTool(tool) end
                        VirtualInputManager:SendMouseButtonEvent(Mouse.X, Mouse.Y, 0, true, game, 1)
                        VirtualInputManager:SendMouseButtonEvent(Mouse.X, Mouse.Y, 0, false, game, 1)
                    end
                end
            end)
        else
            if Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") then
                local fly = Player.Character.HumanoidRootPart:FindFirstChild("DarkzinFly")
                if fly then fly:Destroy() end
            end
        end
    end
end)
