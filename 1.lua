--Skid source no pay onlyyy free
--Byy meeentoz😝😝😝


local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local VirtualUser = game:GetService("VirtualUser")
local workspace = game:GetService("Workspace")
local player = Players.LocalPlayer

if player.PlayerGui:FindFirstChild("WinterAutoFarmGUI") then
    player.PlayerGui.WinterAutoFarmGUI:Destroy()
end

local autoFarmEnabled = false
local autoResetEnabled = false
local antiAFKEnabled = false
local farmSpeed = 20

local ScreenGui = Instance.new("ScreenGui")
local OpenCloseButton = Instance.new("TextButton")
local UICorner_10 = Instance.new("UICorner")
local MainFram = Instance.new("Frame")
local TextLabel = Instance.new("TextLabel")
local UICorner = Instance.new("UICorner")
local TextLabel_2 = Instance.new("TextLabel")
local MainButton = Instance.new("TextButton")
local UICorner_2 = Instance.new("UICorner")
local AntiButton = Instance.new("TextButton")
local UICorner_3 = Instance.new("UICorner")
local MenuFrame = Instance.new("Frame")
local UICorner_4 = Instance.new("UICorner")
local TextLabel_3 = Instance.new("TextLabel")
local TextLabel_4 = Instance.new("TextLabel")
local AutoFarm = Instance.new("TextButton")
local UICorner_5 = Instance.new("UICorner")
local Reset = Instance.new("TextButton")
local UICorner_6 = Instance.new("UICorner")
local UICorner_7 = Instance.new("UICorner")
local AntiAfkFrame = Instance.new("Frame")
local UICorner_8 = Instance.new("UICorner")
local TextBox = Instance.new("TextBox")
local AntiAfkButton = Instance.new("TextButton")
local UICorner_9 = Instance.new("UICorner")
local SpeedLabel = Instance.new("TextLabel")
local SpeedBox = Instance.new("TextBox")
local UICorner_11 = Instance.new("UICorner")

local WINTER_BLUE = Color3.fromRGB(135, 206, 235)
local WINTER_DARK_BLUE = Color3.fromRGB(70, 130, 180)
local WINTER_WHITE = Color3.fromRGB(240, 248, 255)
local WINTER_LIGHT_BLUE = Color3.fromRGB(173, 216, 230)
local ICE_BLUE = Color3.fromRGB(176, 224, 230)

ScreenGui.Name = "WinterAutoFarmGUI"
ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

OpenCloseButton.Name = "OpenCloseButton"
OpenCloseButton.Parent = ScreenGui
OpenCloseButton.BackgroundColor3 = WINTER_BLUE
OpenCloseButton.BackgroundTransparency = 0.3
OpenCloseButton.BorderColor3 = WINTER_WHITE
OpenCloseButton.BorderSizePixel = 2
OpenCloseButton.Position = UDim2.new(0, 10, 0, 10)
OpenCloseButton.Size = UDim2.new(0, 100, 0, 40)
OpenCloseButton.Font = Enum.Font.SourceSansBold
OpenCloseButton.Text = "❄️ Open"
OpenCloseButton.TextColor3 = WINTER_WHITE
OpenCloseButton.TextSize = 18

UICorner_10.Parent = OpenCloseButton

MainFram.Name = "MainFram"
MainFram.Parent = ScreenGui
MainFram.BackgroundColor3 = WINTER_BLUE
MainFram.BackgroundTransparency = 0.2
MainFram.BorderColor3 = WINTER_WHITE
MainFram.BorderSizePixel = 3
MainFram.Position = UDim2.new(0.35597387, 0, 0.213592231, 0)
MainFram.Size = UDim2.new(0, 622, 0, 331)
MainFram.Visible = false

TextLabel.Parent = MainFram
TextLabel.BackgroundColor3 = WINTER_DARK_BLUE
TextLabel.BorderColor3 = WINTER_WHITE
TextLabel.BorderSizePixel = 1
TextLabel.Position = UDim2.new(0.0578778125, 0, 0.0392749235, 0)
TextLabel.Size = UDim2.new(0, 550, 0, 50)
TextLabel.Font = Enum.Font.SourceSansBold
TextLabel.Text = "❄️ Winter AutoFarm Coins ❄️"
TextLabel.TextColor3 = WINTER_WHITE
TextLabel.TextSize = 35

UICorner.Parent = TextLabel

TextLabel_2.Parent = MainFram
TextLabel_2.BackgroundColor3 = Color3.new(1, 1, 1)
TextLabel_2.BackgroundTransparency = 1
TextLabel_2.BorderColor3 = Color3.new(0, 0, 0)
TextLabel_2.BorderSizePixel = 0
TextLabel_2.Position = UDim2.new(0.0675241128, 0, 0.232628405, 0)
TextLabel_2.Size = UDim2.new(0, 170, 0, 25)
TextLabel_2.Font = Enum.Font.SourceSans
TextLabel_2.Text = "by scripthubs"
TextLabel_2.TextColor3 = WINTER_WHITE
TextLabel_2.TextSize = 25

MainButton.Name = "MainButton"
MainButton.Parent = MainFram
MainButton.BackgroundColor3 = WINTER_DARK_BLUE
MainButton.BorderColor3 = WINTER_WHITE
MainButton.BorderSizePixel = 2
MainButton.Position = UDim2.new(0.0668083727, 0, 0.393951863, 0)
MainButton.Size = UDim2.new(0, 176, 0, 55)
MainButton.Font = Enum.Font.SourceSansBold
MainButton.Text = "⚙️ Main"
MainButton.TextColor3 = WINTER_WHITE
MainButton.TextSize = 25

UICorner_2.Parent = MainButton

AntiButton.Name = "AntiButton"
AntiButton.Parent = MainFram
AntiButton.BackgroundColor3 = WINTER_DARK_BLUE
AntiButton.BorderColor3 = WINTER_WHITE
AntiButton.BorderSizePixel = 2
AntiButton.Position = UDim2.new(0.0668083727, 0, 0.662834048, 0)
AntiButton.Size = UDim2.new(0, 176, 0, 55)
AntiButton.Font = Enum.Font.SourceSansBold
AntiButton.Text = "❄️ Anti-Afk"
AntiButton.TextColor3 = WINTER_WHITE
AntiButton.TextSize = 25

UICorner_3.Parent = AntiButton

MenuFrame.Name = "MenuFrame"
MenuFrame.Parent = MainFram
MenuFrame.BackgroundColor3 = WINTER_DARK_BLUE
MenuFrame.BackgroundTransparency = 0.1
MenuFrame.BorderColor3 = WINTER_WHITE
MenuFrame.BorderSizePixel = 2
MenuFrame.Position = UDim2.new(0.419614136, 0, 0.247734144, 0)
MenuFrame.Size = UDim2.new(0, 347, 0, 229)
MenuFrame.Visible = false

UICorner_4.Parent = MenuFrame

TextLabel_3.Parent = MenuFrame
TextLabel_3.BackgroundColor3 = Color3.new(1, 1, 1)
TextLabel_3.BackgroundTransparency = 1
TextLabel_3.BorderColor3 = Color3.new(0, 0, 0)
TextLabel_3.BorderSizePixel = 0
TextLabel_3.Position = UDim2.new(0.0720461085, 0, 0.0873362422, 0)
TextLabel_3.Size = UDim2.new(0, 180, 0, 50)
TextLabel_3.Font = Enum.Font.SourceSansBold
TextLabel_3.Text = "🌬️ Auto Farm"
TextLabel_3.TextColor3 = WINTER_WHITE
TextLabel_3.TextSize = 30

TextLabel_4.Parent = MenuFrame
TextLabel_4.BackgroundColor3 = Color3.new(1, 1, 1)
TextLabel_4.BackgroundTransparency = 1
TextLabel_4.BorderColor3 = Color3.new(0, 0, 0)
TextLabel_4.BorderSizePixel = 0
TextLabel_4.Position = UDim2.new(0.0720461085, 0, 0.681222737, 0)
TextLabel_4.Size = UDim2.new(0, 180, 0, 50)
TextLabel_4.Font = Enum.Font.SourceSansBold
TextLabel_4.Text = "⛄ Auto Reset"
TextLabel_4.TextColor3 = WINTER_WHITE
TextLabel_4.TextSize = 30

SpeedLabel.Parent = MenuFrame
SpeedLabel.BackgroundColor3 = Color3.new(1, 1, 1)
SpeedLabel.BackgroundTransparency = 1
SpeedLabel.BorderColor3 = Color3.new(0, 0, 0)
SpeedLabel.BorderSizePixel = 0
SpeedLabel.Position = UDim2.new(0.0720461085, 0, 0.4, 0)
SpeedLabel.Size = UDim2.new(0, 180, 0, 30)
SpeedLabel.Font = Enum.Font.SourceSansBold
SpeedLabel.Text = "⛄ Farm Speed"
SpeedLabel.TextColor3 = WINTER_WHITE
SpeedLabel.TextSize = 20
SpeedLabel.TextXAlignment = Enum.TextXAlignment.Left

SpeedBox.Parent = MenuFrame
SpeedBox.BackgroundColor3 = ICE_BLUE
SpeedBox.BorderColor3 = WINTER_WHITE
SpeedBox.BorderSizePixel = 1
SpeedBox.Position = UDim2.new(0.6, 0, 0.4, 0)
SpeedBox.Size = UDim2.new(0, 80, 0, 30)
SpeedBox.Font = Enum.Font.SourceSansBold
SpeedBox.Text = tostring(farmSpeed)
SpeedBox.TextColor3 = WINTER_DARK_BLUE
SpeedBox.TextSize = 18
SpeedBox.PlaceholderText = "Speed"
UICorner_11.Parent = SpeedBox

SpeedBox.FocusLost:Connect(function(enterPressed)
    if enterPressed then
        local newSpeed = tonumber(SpeedBox.Text)
        if newSpeed and newSpeed >= 5 and newSpeed <= 100 then
            farmSpeed = newSpeed
            SpeedBox.Text = tostring(farmSpeed)
        else
            SpeedBox.Text = tostring(farmSpeed)
        end
    end
end)

AutoFarm.Name = "AutoFarm"
AutoFarm.Parent = MenuFrame
AutoFarm.BackgroundColor3 = Color3.new(1, 1, 1)
AutoFarm.BorderColor3 = WINTER_WHITE
AutoFarm.BorderSizePixel = 2
AutoFarm.Position = UDim2.new(0.848661482, 0, 0.12876153, 0)
AutoFarm.Size = UDim2.new(0, 30, 0, 30)
AutoFarm.Font = Enum.Font.SourceSans
AutoFarm.Text = ""
AutoFarm.TextColor3 = Color3.new(0, 0, 0)
AutoFarm.TextSize = 14

UICorner_5.Parent = AutoFarm
UICorner_5.CornerRadius = UDim.new(1, 0)

Reset.Name = "Reset"
Reset.Parent = MenuFrame
Reset.BackgroundColor3 = Color3.new(1, 1, 1)
Reset.BorderColor3 = WINTER_WHITE
Reset.BorderSizePixel = 2
Reset.Position = UDim2.new(0.848661482, 0, 0.723043799, 0)
Reset.Size = UDim2.new(0, 30, 0, 30)
Reset.Font = Enum.Font.SourceSans
Reset.Text = ""
Reset.TextColor3 = Color3.new(0, 0, 0)
Reset.TextSize = 14

UICorner_6.Parent = Reset
UICorner_6.CornerRadius = UDim.new(1, 0)

UICorner_7.Parent = MainFram

AntiAfkFrame.Name = "AntiAfkFrame"
AntiAfkFrame.Parent = MainFram
AntiAfkFrame.BackgroundColor3 = WINTER_DARK_BLUE
AntiAfkFrame.BackgroundTransparency = 0.1
AntiAfkFrame.BorderColor3 = WINTER_WHITE
AntiAfkFrame.BorderSizePixel = 2
AntiAfkFrame.Position = UDim2.new(0.419341743, 0, 0.250791252, 0)
AntiAfkFrame.Size = UDim2.new(0, 347, 0, 229)
AntiAfkFrame.Visible = false

UICorner_8.Parent = AntiAfkFrame

TextBox.Parent = AntiAfkFrame
TextBox.BackgroundColor3 = WINTER_LIGHT_BLUE
TextBox.BackgroundTransparency = 1
TextBox.BorderColor3 = WINTER_LIGHT_BLUE
TextBox.BorderSizePixel = 0
TextBox.Position = UDim2.new(0.0605187304, 0, 0.109170303, 0)
TextBox.Size = UDim2.new(0, 200, 0, 50)
TextBox.Font = Enum.Font.SourceSansBold
TextBox.Text = "🎄 Anti-Afk"
TextBox.TextColor3 = WINTER_WHITE
TextBox.TextSize = 37

AntiAfkButton.Name = "AntiAfkButton"
AntiAfkButton.Parent = AntiAfkFrame
AntiAfkButton.BackgroundColor3 = Color3.new(1, 1, 1)
AntiAfkButton.BorderColor3 = WINTER_WHITE
AntiAfkButton.BorderSizePixel = 2
AntiAfkButton.Position = UDim2.new(0.796788275, 0, 0.154962391, 0)
AntiAfkButton.Size = UDim2.new(0, 30, 0, 30)
AntiAfkButton.Font = Enum.Font.SourceSans
AntiAfkButton.Text = ""
AntiAfkButton.TextColor3 = Color3.new(0, 0, 0)
AntiAfkButton.TextSize = 14

UICorner_9.Parent = AntiAfkButton
UICorner_9.CornerRadius = UDim.new(1, 0)

local CoinCollected = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("Gameplay"):WaitForChild("CoinCollected")
local RoundStart = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("Gameplay"):WaitForChild("RoundStart")
local RoundEnd = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("Gameplay"):WaitForChild("RoundEndFade")

local farming = false
local bag_full = false
local resetting = false
local start_position = nil

local function enableAntiAFK()
    player.Idled:Connect(function()
        VirtualUser:CaptureController()
        VirtualUser:ClickButton2(Vector2.new())
    end)
end

local function getCharacter() 
    return player.Character or player.CharacterAdded:Wait() 
end

local function getHRP() 
    return getCharacter():WaitForChild("HumanoidRootPart") 
end

CoinCollected.OnClientEvent:Connect(function(_, current, max)
    if current == max and not resetting and autoResetEnabled then
        resetting = true
        bag_full = true
        local hrp = getHRP()
        if start_position then
            local tween = TweenService:Create(hrp, TweenInfo.new(2, Enum.EasingStyle.Linear), {CFrame = start_position})
            tween:Play()
            tween.Completed:Wait()
        end
        task.wait(0.5)
        player.Character.Humanoid.Health = 0
        player.CharacterAdded:Wait()
        task.wait(1.5)
        resetting = false
        bag_full = false
    end
end)

RoundStart.OnClientEvent:Connect(function()
    farming = true
    start_position = getHRP().CFrame
end)

RoundEnd.OnClientEvent:Connect(function()
    farming = false
end)

local function get_nearest_coin()
    local hrp = getHRP()
    local closest, dist = nil, math.huge
    for _, m in pairs(workspace:GetChildren()) do
        if m:FindFirstChild("CoinContainer") then
            for _, coin in pairs(m.CoinContainer:GetChildren()) do
                if coin:IsA("BasePart") and coin:FindFirstChild("TouchInterest") then
                    local d = (hrp.Position - coin.Position).Magnitude
                    if d < dist then 
                        closest, dist = coin, d 
                    end
                end
            end
        end
    end
    return closest, dist
end

task.spawn(function()
    while true do
        if autoFarmEnabled and farming and not bag_full then
            local coin, dist = get_nearest_coin()
            if coin then
                local hrp = getHRP()
                if dist > 150 then
                    hrp.CFrame = coin.CFrame
                else
                    local tween = TweenService:Create(hrp, TweenInfo.new(dist / farmSpeed, Enum.EasingStyle.Linear), {CFrame = coin.CFrame})
                    tween:Play()
                    repeat 
                        task.wait() 
                    until not coin:FindFirstChild("TouchInterest") or not farming or not autoFarmEnabled
                    tween:Cancel()
                end
            end
        end
        task.wait(0.2)
    end
end)

local function OpenCloseScript()
    local isOpen = false
    
    OpenCloseButton.MouseButton1Click:Connect(function()
        isOpen = not isOpen
        MainFram.Visible = isOpen
        
        if isOpen then
            OpenCloseButton.Text = "❄️ Close"
        else
            OpenCloseButton.Text = "❄️ Open"
            MenuFrame.Visible = false
            AntiAfkFrame.Visible = false
        end
    end)
end

local function DraggingScript()
    local frame = MainFram
    local UserInputService = game:GetService("UserInputService")
    
    local dragging = false
    local dragStart, startPos
    
    local function update(input)
        local delta = input.Position - dragStart
        frame.Position = UDim2.new(
            startPos.X.Scale, 
            startPos.X.Offset + delta.X,
            startPos.Y.Scale, 
            startPos.Y.Offset + delta.Y
        )
    end
    
    frame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = frame.Position

            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)
    
    frame.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            if dragging then
                update(input)
            end
        end
    end)
end

local function FrameToggleScript()
    local button1 = MainFram:WaitForChild("AntiButton")
    local button2 = MainFram:WaitForChild("MainButton")
    
    local antiAfkFrame = MainFram:WaitForChild("AntiAfkFrame")
    local menuFrame = MainFram:WaitForChild("MenuFrame")
    
    antiAfkFrame.Visible = false
    menuFrame.Visible = false
    
    button1.MouseButton1Click:Connect(function()
        antiAfkFrame.Visible = not antiAfkFrame.Visible
        menuFrame.Visible = false
    end)
    
    button2.MouseButton1Click:Connect(function()
        menuFrame.Visible = not menuFrame.Visible
        antiAfkFrame.Visible = false
    end)
end

AutoFarm.MouseButton1Click:Connect(function()
    autoFarmEnabled = not autoFarmEnabled
    if autoFarmEnabled then
        AutoFarm.BackgroundColor3 = Color3.fromRGB(0, 255, 127)
        print("❄️ AutoFarm activated!")
    else
        AutoFarm.BackgroundColor3 = Color3.new(1, 1, 1)
        print("❄️ AutoFarm deactivated!")
    end
end)

Reset.MouseButton1Click:Connect(function()
    autoResetEnabled = not autoResetEnabled
    if autoResetEnabled then
        Reset.BackgroundColor3 = Color3.fromRGB(0, 255, 127)
        print("❄️ Auto Reset activated!")
    else
        Reset.BackgroundColor3 = Color3.new(1, 1, 1)
        print("❄️ Auto Reset deactivated!")
    end
end)

AntiAfkButton.MouseButton1Click:Connect(function()
    antiAFKEnabled = not antiAFKEnabled
    if antiAFKEnabled then
        AntiAfkButton.BackgroundColor3 = Color3.fromRGB(0, 255, 127)
        enableAntiAFK()
        print("❄️ Anti-AFK activated!")
    else
        AntiAfkButton.BackgroundColor3 = Color3.new(1, 1, 1)
        print("❄️ Anti-AFK deactivated!")
    end
end)

OpenCloseScript()
DraggingScript()
FrameToggleScript()

print("❄️ Winter AutoFarm GUI loaded! Press the button in top-left corner to open.")
