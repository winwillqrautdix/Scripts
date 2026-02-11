--Made By Meentoz V1 AutoFarm Heart AdoptMe Valentines 2026 
local player = game.Players.LocalPlayer
local PlayerGui = player:WaitForChild("PlayerGui")
local UserInputService = game:GetService("UserInputService")
local VirtualInputManager = game:GetService("VirtualInputManager")

local teleportActive = false
local teleportOneTimeDone = false
local canCollectHearts = false
local dragging = false
local dragStart, startPos

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "DraggableHeartFarmGUI"
ScreenGui.Parent = PlayerGui

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 220, 0, 150)
MainFrame.Position = UDim2.new(0, 50, 0, 100)
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
MainFrame.BackgroundTransparency = 0.1
MainFrame.Active = true
MainFrame.Parent = ScreenGui

local Corner = Instance.new("UICorner")
Corner.CornerRadius = UDim.new(0, 10)
Corner.Parent = MainFrame

local Stroke = Instance.new("UIStroke")
Stroke.Color = Color3.fromRGB(255, 100, 100)
Stroke.Thickness = 2
Stroke.Parent = MainFrame

local DragBar = Instance.new("Frame")
DragBar.Size = UDim2.new(1, 0, 0, 30)
DragBar.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
DragBar.BackgroundTransparency = 0.3
DragBar.Parent = MainFrame

local DragCorner = Instance.new("UICorner")
DragCorner.CornerRadius = UDim.new(0, 10)
DragCorner.Parent = DragBar

local DragText = Instance.new("TextLabel")
DragText.Text = " AutoFarm Heart AdoptMe"
DragText.Size = UDim2.new(1, 0, 1, 0)
DragText.BackgroundTransparency = 1
DragText.TextColor3 = Color3.fromRGB(200, 200, 200)
DragText.Font = Enum.Font.GothamBold
DragText.TextSize = 12
DragText.Parent = DragBar

local function makeDraggable(frame, dragBar)
    dragBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
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
    
    UserInputService.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement and dragging then
            local delta = input.Position - dragStart
            frame.Position = UDim2.new(
                startPos.X.Scale, 
                startPos.X.Offset + delta.X, 
                startPos.Y.Scale, 
                startPos.Y.Offset + delta.Y
            )
        end
    end)
end

makeDraggable(MainFrame, DragBar)

local ControlButton = Instance.new("TextButton")
ControlButton.Text = "START FARM"
ControlButton.Size = UDim2.new(0.8, 0, 0, 50)
ControlButton.Position = UDim2.new(0.1, 0, 0.3, 0)
ControlButton.BackgroundColor3 = Color3.fromRGB(100, 200, 100)
ControlButton.TextColor3 = Color3.new(1, 1, 1)
ControlButton.Font = Enum.Font.GothamBold
ControlButton.TextSize = 14
ControlButton.Parent = MainFrame

local BtnCorner = Instance.new("UICorner")
BtnCorner.CornerRadius = UDim.new(0, 8)
BtnCorner.Parent = ControlButton

local StatusLabel = Instance.new("TextLabel")
StatusLabel.Text = "Status: OFF"
StatusLabel.Size = UDim2.new(1, 0, 0, 20)
StatusLabel.Position = UDim2.new(0, 0, 0.8, 0)
StatusLabel.BackgroundTransparency = 1
StatusLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
StatusLabel.Font = Enum.Font.Gotham
StatusLabel.TextSize = 12
StatusLabel.TextXAlignment = Enum.TextXAlignment.Center
StatusLabel.Parent = MainFrame

local function stepForwardReal()
    task.spawn(function()
        local character = player.Character
        if not character then return end
        local humanoid = character:FindFirstChildWhichIsA("Humanoid")
        if humanoid then
            VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.S, false, game)
            task.wait(0.2)
            VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.S, false, game)
            print("👣 Шаг вперед")
        end
    end)
end

ControlButton.MouseButton1Click:Connect(function()
    teleportActive = not teleportActive
    
    if teleportActive then
        ControlButton.Text = "STOP FARM"
        ControlButton.BackgroundColor3 = Color3.fromRGB(200, 100, 100)
        StatusLabel.Text = "Status: FARMING"
        StatusLabel.TextColor3 = Color3.fromRGB(100, 255, 100)
        DragText.TextColor3 = Color3.fromRGB(100, 255, 100)
        print("✅ AutoFarm On")
        
        canCollectHearts = false
        
        if not teleportOneTimeDone then
            teleportOneTimeDone = true
            task.spawn(function()
                local character = player.Character
                if not character then
                    character = player.CharacterAdded:Wait()
                end
                
                local hrp = character:WaitForChild("HumanoidRootPart")
                local targetPosition1 = Vector3.new(-3024.21484375, 6529.39794921875, -8958.8095703125)
                hrp.CFrame = CFrame.new(targetPosition1)
                task.wait(1)
                stepForwardReal()
                task.wait(1)
                canCollectHearts = true
                StatusLabel.Text = "Status: FARMING (COLLECTING)"
            end)
        else
            canCollectHearts = true
            StatusLabel.Text = "Status: FARMING (COLLECTING)"
        end
    else
        ControlButton.Text = "START FARM"
        ControlButton.BackgroundColor3 = Color3.fromRGB(100, 200, 100)
        StatusLabel.Text = "Status: OFF"
        StatusLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
        DragText.TextColor3 = Color3.fromRGB(200, 200, 200)
        canCollectHearts = false
        print("⛔ AutoFarm Off")
    end
end)

spawn(function()
    local TARGET = CFrame.new(-338.9837646484375, 31.034208297729492, -1442.8511962890625)
    
    local function getHeartPart(obj)
        if obj:IsA("Sound") then
            return nil
        end
        
        if obj.PrimaryPart then
            return obj.PrimaryPart
        end
        
        local part = obj:FindFirstChildWhichIsA("BasePart")
        if part then
            return part
        end
        
        if obj:IsA("BasePart") then
            return obj
        end
        
        return nil
    end
    
    while task.wait(0.8) do
        if teleportActive and canCollectHearts then
            local character = player.Character
            if not character then continue end
            
            local hrp = character:FindFirstChild("HumanoidRootPart")
            if not hrp then continue end
            
            local heartPart = nil
            
            for _, v in pairs(workspace:GetChildren()) do
                if v.Name == "HeartPickup" then
                    heartPart = getHeartPart(v)
                    if heartPart then break end
                end
            end
            
            -- Если не нашли, ищем глубже
            if not heartPart then
                for _, v in pairs(workspace:GetDescendants()) do
                    if v.Name == "HeartPickup" and not v:IsA("Sound") then
                        heartPart = getHeartPart(v)
                        if heartPart then break end
                    end
                end
            end
            
            -- ТП К СЕРДЦУ
            if heartPart then
                hrp.CFrame = heartPart.CFrame * CFrame.new(0, 3, 0)
                task.wait(0.3)
            end
            
            -- ВОЗВРАТ
            if hrp and hrp.Parent then
                hrp.CFrame = TARGET
                task.wait(0.2)
            end
        end
    end
end)

print("made by meentoz")
