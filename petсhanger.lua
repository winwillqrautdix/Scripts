-- Load Fsys and InventoryDB
local load = require(game.ReplicatedStorage:WaitForChild("Fsys")).load
local inventoryDB = load("InventoryDB")

-- Change function
local function change(from, to)
    local fromIndex
    local toIndex

    -- Find pets by name
    for i, v in pairs(inventoryDB.pets) do
        if v.name:lower() == from:lower() then
            fromIndex = i
        end
        if v.name:lower() == to:lower() then
            toIndex = i
        end
    end

    -- Check if found
    if not fromIndex or not toIndex then
        warn("âŒ Pets not found!")
        return false
    end

    -- Copy values
    for i, v in pairs(inventoryDB.pets[fromIndex]) do
        inventoryDB.pets[fromIndex][i] = inventoryDB.pets[toIndex][i]
    end

    print("âœ… Successfully replaced:", from, "â†’", to)
    return true
end


-- === CREATE GUI ===
local player = game.Players.LocalPlayer
local ScreenGui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
ScreenGui.Name = "PetChangerHub"
ScreenGui.ResetOnSpawn = false

-- Main Frame
local Frame = Instance.new("Frame", ScreenGui)
Frame.Size = UDim2.new(0, 400, 0, 250)
Frame.Position = UDim2.new(0.5, -200, 0.5, -125)
Frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
Frame.BorderSizePixel = 0
Frame.Active = true -- Needed for dragging

local UICorner = Instance.new("UICorner", Frame)
UICorner.CornerRadius = UDim.new(0, 15)

-- Title (this will be draggable)
local Title = Instance.new("TextLabel", Frame)
Title.Size = UDim2.new(1, 0, 0, 50)
Title.BackgroundTransparency = 1
Title.Text = "ðŸ¾ PET CHANGER | LEVINS HUB ðŸ¾"
Title.Font = Enum.Font.GothamBold
Title.TextSize = 20
Title.TextColor3 = Color3.fromRGB(255, 200, 50)

-- Input "From"
local FromBox = Instance.new("TextBox", Frame)
FromBox.Size = UDim2.new(0.8, 0, 0, 40)
FromBox.Position = UDim2.new(0.1, 0, 0.3, 0)
FromBox.PlaceholderText = "Enter pet name (from)"
FromBox.Font = Enum.Font.Gotham
FromBox.TextSize = 16
FromBox.Text = ""
FromBox.TextColor3 = Color3.fromRGB(255, 255, 255)
FromBox.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
Instance.new("UICorner", FromBox).CornerRadius = UDim.new(0, 10)

-- Input "To"
local ToBox = Instance.new("TextBox", Frame)
ToBox.Size = UDim2.new(0.8, 0, 0, 40)
ToBox.Position = UDim2.new(0.1, 0, 0.5, 0)
ToBox.PlaceholderText = "Enter pet name (to)"
ToBox.Font = Enum.Font.Gotham
ToBox.TextSize = 16
ToBox.Text = ""
ToBox.TextColor3 = Color3.fromRGB(255, 255, 255)
ToBox.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
Instance.new("UICorner", ToBox).CornerRadius = UDim.new(0, 10)

-- Replace Button
local ChangeBtn = Instance.new("TextButton", Frame)
ChangeBtn.Size = UDim2.new(0.6, 0, 0, 45)
ChangeBtn.Position = UDim2.new(0.2, 0, 0.75, 0)
ChangeBtn.BackgroundColor3 = Color3.fromRGB(70, 130, 255)
ChangeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ChangeBtn.Text = "Replace Pet"
ChangeBtn.Font = Enum.Font.GothamBold
ChangeBtn.TextSize = 18
Instance.new("UICorner", ChangeBtn).CornerRadius = UDim.new(0, 12)

-- Button logic
ChangeBtn.MouseButton1Click:Connect(function()
    local fromName = FromBox.Text
    local toName = ToBox.Text

    if fromName == "" or toName == "" then
        warn("âŒ Please enter pet names!")
        ChangeBtn.Text = "âŒ Missing names!"
        task.delay(1.5, function()
            ChangeBtn.Text = "Replace Pet"
        end)
        return
    end

    local result = change(fromName, toName)
    if result then
        ChangeBtn.Text = "âœ… Success!"
    else
        ChangeBtn.Text = "âŒ Failed!"
    end

    task.delay(1.5, function()
        ChangeBtn.Text = "Replace Pet"
    end)
end)


-- === DRAGGING SCRIPT ===
local UserInputService = game:GetService("UserInputService")
local dragging, dragInput, dragStart, startPos

local function update(input)
    local delta = input.Position - dragStart
    Frame.Position = UDim2.new(
        startPos.X.Scale, startPos.X.Offset + delta.X,
        startPos.Y.Scale, startPos.Y.Offset + delta.Y
    )
end

Title.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or 
       input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = Frame.Position

        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

Title.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or 
       input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        update(input)
    end
end)
