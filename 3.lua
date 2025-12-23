local itemsList = {
    "Santa Hat",
    "Elf Hat", 
    "Acorn",
    "Snowman",
    "Ornament",
    "North Pole",
    "2 Doves"
}

local player = game.Players.LocalPlayer
local collectKey = Enum.KeyCode.F
local collectDelay = 0.5

local function findItemInWorkspace(itemName)
    local foundItems = {}
    
    local function searchInFolder(folder)
        for _, obj in pairs(folder:GetChildren()) do
            if obj.Name == itemName then
                table.insert(foundItems, obj)
            end
            if obj:IsA("Folder") or obj:IsA("Model") then
                searchInFolder(obj)
            end
        end
    end
    
    searchInFolder(workspace)
    return foundItems
end

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "ItemTeleporter"
screenGui.Parent = game.CoreGui

local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 250, 0, 300)
mainFrame.Position = UDim2.new(0, 10, 0.5, -150)
mainFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
mainFrame.BorderSizePixel = 0
mainFrame.Parent = screenGui

local title = Instance.new("TextLabel")
title.Name = "Title"
title.Text = "рџЋ„ Christmas Items"
title.Size = UDim2.new(1, 0, 0, 40)
title.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.TextSize = 20
title.Font = Enum.Font.GothamBold
title.Parent = mainFrame

local scrollFrame = Instance.new("ScrollingFrame")
scrollFrame.Name = "ScrollFrame"
scrollFrame.Size = UDim2.new(1, -10, 1, -50)
scrollFrame.Position = UDim2.new(0, 5, 0, 45)
scrollFrame.BackgroundTransparency = 1
scrollFrame.BorderSizePixel = 0
scrollFrame.ScrollBarThickness = 5
scrollFrame.CanvasSize = UDim2.new(0, 0, 0, #itemsList * 50)
scrollFrame.Parent = mainFrame

for i, itemName in pairs(itemsList) do
    local buttonFrame = Instance.new("Frame")
    buttonFrame.Name = "Item_" .. itemName
    buttonFrame.Size = UDim2.new(1, -10, 0, 45)
    buttonFrame.Position = UDim2.new(0, 5, 0, (i-1) * 50)
    buttonFrame.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    buttonFrame.BorderSizePixel = 0
    buttonFrame.Parent = scrollFrame
    
    local itemButton = Instance.new("TextButton")
    itemButton.Name = "Button"
    itemButton.Size = UDim2.new(1, 0, 1, 0)
    itemButton.BackgroundTransparency = 1
    itemButton.Text = "рџЋ… " .. itemName
    itemButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    itemButton.TextSize = 16
    itemButton.Font = Enum.Font.Gotham
    itemButton.Parent = buttonFrame
    
    itemButton.MouseButton1Click:Connect(function()
        teleportAndCollect(itemName)
    end)
end

local function collectItem(item)
    if not item then return false end
    
    local effect = Instance.new("Part")
    effect.Size = Vector3.new(3, 3, 3)
    
    if item:IsA("Model") then
        local primaryPart = item.PrimaryPart or item:FindFirstChildWhichIsA("BasePart")
        if primaryPart then
            effect.Position = primaryPart.Position
        end
    elseif item:IsA("BasePart") then
        effect.Position = item.Position
    end
    
    effect.Anchored = true
    effect.CanCollide = false
    effect.Material = Enum.Material.Neon
    effect.Color = Color3.fromRGB(255, 215, 0)
    effect.Transparency = 0.3
    
    local mesh = Instance.new("SpecialMesh", effect)
    mesh.MeshType = Enum.MeshType.Sphere
    
    effect.Parent = workspace
    game.Debris:AddItem(effect, 0.5)
    
    local message = Instance.new("Message", workspace)
    message.Text = "рџ“¦ Item collected!"
    game.Debris:AddItem(message, 2)
    
    wait(0.1)
    if item.Parent then
        item:Destroy()
        return true
    end
    
    return false
end

function teleportAndCollect(itemName)
    local character = player.Character
    if not character then
        print("No character!")
        return
    end
    
    local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
    if not humanoidRootPart then
        print("No HumanoidRootPart!")
        return
    end
    
    local foundItems = findItemInWorkspace(itemName)
    
    if #foundItems > 0 then
        local item = foundItems[1]
        local targetPosition
        
        if item:IsA("Model") then
            local primaryPart = item.PrimaryPart or item:FindFirstChildWhichIsA("BasePart")
            if primaryPart then
                targetPosition = primaryPart.Position
            end
        elseif item:IsA("BasePart") then
            targetPosition = item.Position
        end
        
        if targetPosition then
            humanoidRootPart.CFrame = CFrame.new(targetPosition + Vector3.new(0, 3, 0))
            
            local teleportEffect = Instance.new("Part")
            teleportEffect.Size = Vector3.new(3, 3, 3)
            teleportEffect.Position = targetPosition
            teleportEffect.Anchored = true
            teleportEffect.CanCollide = false
            teleportEffect.Material = Enum.Material.Neon
            teleportEffect.Color = Color3.fromRGB(0, 255, 255)
            teleportEffect.Transparency = 0.3
            
            local teleportMesh = Instance.new("SpecialMesh", teleportEffect)
            teleportMesh.MeshType = Enum.MeshType.Sphere
            
            teleportEffect.Parent = workspace
            game.Debris:AddItem(teleportEffect, 1)
            
            local message = Instance.new("Message", workspace)
            message.Text = "рџљЂ Teleport to: " .. itemName
            game.Debris:AddItem(message, 2)
            
            wait(collectDelay)
            collectItem(item)
        else
            local message = Instance.new("Message", workspace)
            message.Text = "вќЊ Item not found: " .. itemName
            game.Debris:AddItem(message, 2)
        end
    else
        local message = Instance.new("Message", workspace)
        message.Text = "вќЊ Item not found: " .. itemName
        game.Debris:AddItem(message, 2)
    end
end

function addItemToList(itemName)
    table.insert(itemsList, itemName)
    updateUI()
    print("Added item: " .. itemName)
end

function removeItemFromList(itemName)
    for i, name in pairs(itemsList) do
        if name == itemName then
            table.remove(itemsList, i)
            updateUI()
            print("Removed item: " .. itemName)
            return
        end
    end
end

function updateUI()
    scrollFrame:ClearAllChildren()
    scrollFrame.CanvasSize = UDim2.new(0, 0, 0, #itemsList * 50)
    
    for i, itemName in pairs(itemsList) do
        local buttonFrame = Instance.new("Frame")
        buttonFrame.Name = "Item_" .. itemName
        buttonFrame.Size = UDim2.new(1, -10, 0, 45)
        buttonFrame.Position = UDim2.new(0, 5, 0, (i-1) * 50)
        buttonFrame.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
        buttonFrame.BorderSizePixel = 0
        buttonFrame.Parent = scrollFrame
        
        local itemButton = Instance.new("TextButton")
        itemButton.Name = "Button"
        itemButton.Size = UDim2.new(1, 0, 1, 0)
        itemButton.BackgroundTransparency = 1
        itemButton.Text = "рџЋ… " .. itemName
        itemButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        itemButton.TextSize = 16
        itemButton.Font = Enum.Font.Gotham
        itemButton.Parent = buttonFrame
        
        itemButton.MouseButton1Click:Connect(function()
            teleportAndCollect(itemName)
        end)
    end
end

local UIS = game:GetService("UserInputService")
UIS.InputBegan:Connect(function(input, gameProcessed)
    if not gameProcessed and input.KeyCode == collectKey then
        local character = player.Character
        if character then
            local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
            if humanoidRootPart then
                local nearestItem = nil
                local nearestDistance = 15
                
                for _, itemName in pairs(itemsList) do
                    local foundItems = findItemInWorkspace(itemName)
                    
                    for _, item in pairs(foundItems) do
                        local itemPosition
                        if item:IsA("Model") then
                            local primaryPart = item.PrimaryPart or item:FindFirstChildWhichIsA("BasePart")
                            if primaryPart then
                                itemPosition = primaryPart.Position
                            end
                        elseif item:IsA("BasePart") then
                            itemPosition = item.Position
                        end
                        
                        if itemPosition then
                            local distance = (humanoidRootPart.Position - itemPosition).Magnitude
                            if distance <= nearestDistance then
                                nearestDistance = distance
                                nearestItem = item
                            end
                        end
                    end
                end
                
                if nearestItem then
                    collectItem(nearestItem)
                end
            end
        end
    end
end)

print("Teleport + Auto Collect loaded!")
print("Items: " .. table.concat(itemsList, ", "))
print("Commands:")
print("teleportAndCollect('Santa Hat')")
print("addItemToList('New Item')")
print("removeItemFromList('Item')")
print("Press F to collect nearest item")
