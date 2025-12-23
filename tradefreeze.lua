local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local gui = player:WaitForChild("PlayerGui")

local function createRoundedFrame(name, size, position, color, radius)
	local frame = Instance.new("Frame")
	frame.Name = name
	frame.Size = size
	frame.Position = position
	frame.BackgroundColor3 = color
	frame.BackgroundTransparency = 1
	frame.ClipsDescendants = true

	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(0, radius)
	corner.Parent = frame

	return frame
end

local function createTextLabel(name, size, position, text, sizeNum, bold)
	local label = Instance.new("TextLabel")
	label.Name = name
	label.Size = size
	label.Position = position
	label.BackgroundTransparency = 1
	label.Text = text
	label.TextColor3 = Color3.fromRGB(255, 255, 255)
	label.TextTransparency = 1
	label.TextSize = sizeNum
	label.Font = bold and Enum.Font.GothamBold or Enum.Font.Gotham

	return label
end

local function enableDragging(frame, dragArea)
	local dragInput, dragStart, startPos
	local isDragging = false

	dragArea.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			dragStart = input.Position
			startPos = frame.Position
			isDragging = true

			local connection
			connection = input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					isDragging = false
					connection:Disconnect()
				end
			end)
		end
	end)

	dragArea.InputChanged:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement and isDragging then
			dragInput = input
		end
	end)

	UserInputService.InputChanged:Connect(function(input)
		if input == dragInput and isDragging then
			local delta = input.Position - dragStart
			frame.Position = UDim2.new(
				startPos.X.Scale, startPos.X.Offset + delta.X,
				startPos.Y.Scale, startPos.Y.Offset + delta.Y
			)
		end
	end)
end

local function createNotification(message)
	local notificationGui = Instance.new("ScreenGui")
	notificationGui.Name = "NotificationGUI"
	notificationGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
	notificationGui.DisplayOrder = 999
	notificationGui.ResetOnSpawn = false
	notificationGui.Parent = gui

	local notificationFrame = Instance.new("Frame")
	notificationFrame.Name = "Notification"
	notificationFrame.Size = UDim2.new(0, 250, 0, 70)
	notificationFrame.Position = UDim2.new(1, -270, 1, -80)
	notificationFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	notificationFrame.BackgroundTransparency = 1
	notificationFrame.ClipsDescendants = true
	notificationFrame.Parent = notificationGui

	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(0, 10)
	corner.Parent = notificationFrame

	local border = Instance.new("UIStroke")
	border.Color = Color3.fromRGB(255, 255, 255)
	border.Thickness = 2
	border.Transparency = 1
	border.Parent = notificationFrame

	local textLabel = Instance.new("TextLabel")
	textLabel.Name = "Text"
	textLabel.Size = UDim2.new(1, -20, 1, -20)
	textLabel.Position = UDim2.new(0, 10, 0, 10)
	textLabel.BackgroundTransparency = 1
	textLabel.Text = message
	textLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
	textLabel.TextTransparency = 1
	textLabel.TextSize = 18
	textLabel.Font = Enum.Font.GothamBold
	textLabel.TextWrapped = true
	textLabel.Parent = notificationFrame

	local showTween = TweenService:Create(notificationFrame, TweenInfo.new(0.5),
		{BackgroundTransparency = 0})
	local borderTween = TweenService:Create(border, TweenInfo.new(0.5),
		{Transparency = 0})
	local textTween = TweenService:Create(textLabel, TweenInfo.new(0.5),
		{TextTransparency = 0})

	showTween:Play()
	borderTween:Play()
	textTween:Play()

	wait(3)

	local hideTween = TweenService:Create(notificationFrame, TweenInfo.new(0.5),
		{
			BackgroundTransparency = 1,
			Position = UDim2.new(1, -270, 1, -30)
		})
	local textHideTween = TweenService:Create(textLabel, TweenInfo.new(0.4),
		{TextTransparency = 1})
	local borderHideTween = TweenService:Create(border, TweenInfo.new(0.4),
		{Transparency = 1})

	textHideTween:Play()
	borderHideTween:Play()
	hideTween:Play()

	hideTween.Completed:Connect(function()
		notificationGui:Destroy()
	end)
end

local introGui = Instance.new("ScreenGui")
introGui.Name = "IntroGUI"
introGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
introGui.ResetOnSpawn = false
introGui.Parent = gui

local introFrame = createRoundedFrame("IntroFrame", 
	UDim2.new(0, 350, 0, 150), 
	UDim2.new(0.5, -175, 0.5, -75), 
	Color3.fromRGB(0, 0, 0), 
	15)
introFrame.Parent = introGui

local introBorder = Instance.new("UIStroke")
introBorder.Color = Color3.fromRGB(100, 100, 100)
introBorder.Thickness = 3
introBorder.Transparency = 1
introBorder.Parent = introFrame

local introTitle = createTextLabel("Title", 
	UDim2.new(1, 0, 0, 60), 
	UDim2.new(0, 0, 0.5, -30), 
	"Trade Freeze", 
	32, 
	true)
introTitle.Parent = introFrame

local mainGui = Instance.new("ScreenGui")
mainGui.Name = "MainGUI"
mainGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
mainGui.ResetOnSpawn = false
mainGui.Enabled = false
mainGui.Parent = gui

local mainFrame = createRoundedFrame("MainFrame",
	UDim2.new(0, 400, 0, 350),
	UDim2.new(0.5, -200, 0.5, -175),
	Color3.fromRGB(0, 0, 0),
	20)
mainFrame.Parent = mainGui

local mainBorder = Instance.new("UIStroke")
mainBorder.Color = Color3.fromRGB(255, 255, 255)
mainBorder.Thickness = 3
mainBorder.Transparency = 1
mainBorder.Parent = mainFrame

local mainTitle = createTextLabel("Title",
	UDim2.new(1, 0, 0, 60),
	UDim2.new(0, 0, 0, 20),
	"FREEZE TRADE",
	36,
	true)
mainTitle.Parent = mainFrame

local function showIntro()
	local bgTween = TweenService:Create(introFrame, TweenInfo.new(0.6),
		{BackgroundTransparency = 0})
	local borderTween = TweenService:Create(introBorder, TweenInfo.new(0.6),
		{Transparency = 0})
	local textTween = TweenService:Create(introTitle, TweenInfo.new(0.8),
		{TextTransparency = 0})

	bgTween:Play()
	borderTween:Play()
	textTween:Play()
end

local function createButtons()
	local button1 = Instance.new("TextButton")
	button1.Name = "FreezeButton"
	button1.Size = UDim2.new(0, 320, 0, 60)
	button1.Position = UDim2.new(0.5, -160, 0.4, -30)
	button1.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
	button1.BackgroundTransparency = 0
	button1.Text = "Freeze Trade"
	button1.TextColor3 = Color3.fromRGB(255, 255, 255)
	button1.TextSize = 20
	button1.Font = Enum.Font.GothamBold
	button1.AutoButtonColor = false
	button1.Parent = mainFrame

	local corner1 = Instance.new("UICorner")
	corner1.CornerRadius = UDim.new(0, 12)
	corner1.Parent = button1

	local button1Border = Instance.new("UIStroke")
	button1Border.Color = Color3.fromRGB(100, 100, 100)
	button1Border.Thickness = 2
	button1Border.Transparency = 0
	button1Border.Parent = button1

	local button2 = Instance.new("TextButton")
	button2.Name = "AcceptButton"
	button2.Size = UDim2.new(0, 320, 0, 60)
	button2.Position = UDim2.new(0.5, -160, 0.7, -30)
	button2.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
	button2.BackgroundTransparency = 0
	button2.Text = "Accept Trade"
	button2.TextColor3 = Color3.fromRGB(255, 255, 255)
	button2.TextSize = 20
	button2.Font = Enum.Font.GothamBold
	button2.AutoButtonColor = false
	button2.Parent = mainFrame

	local corner2 = Instance.new("UICorner")
	corner2.CornerRadius = UDim.new(0, 12)
	corner2.Parent = button2

	local button2Border = Instance.new("UIStroke")
	button2Border.Color = Color3.fromRGB(100, 100, 100)
	button2Border.Thickness = 2
	button2Border.Transparency = 0
	button2Border.Parent = button2

	local button1Active = false
	local button2Active = false

	button1.MouseEnter:Connect(function()
		if not button1Active then
			TweenService:Create(button1, TweenInfo.new(0.2), {
				BackgroundColor3 = Color3.fromRGB(50, 50, 50)
			}):Play()
			TweenService:Create(button1Border, TweenInfo.new(0.2), {
				Color = Color3.fromRGB(150, 150, 150)
			}):Play()
		end
	end)

	button1.MouseLeave:Connect(function()
		if not button1Active then
			TweenService:Create(button1, TweenInfo.new(0.2), {
				BackgroundColor3 = Color3.fromRGB(30, 30, 30)
			}):Play()
			TweenService:Create(button1Border, TweenInfo.new(0.2), {
				Color = Color3.fromRGB(100, 100, 100)
			}):Play()
		end
	end)

	button2.MouseEnter:Connect(function()
		if not button2Active then
			TweenService:Create(button2, TweenInfo.new(0.2), {
				BackgroundColor3 = Color3.fromRGB(50, 50, 50)
			}):Play()
			TweenService:Create(button2Border, TweenInfo.new(0.2), {
				Color = Color3.fromRGB(150, 150, 150)
			}):Play()
		end
	end)

	button2.MouseLeave:Connect(function()
		if not button2Active then
			TweenService:Create(button2, TweenInfo.new(0.2), {
				BackgroundColor3 = Color3.fromRGB(30, 30, 30)
			}):Play()
			TweenService:Create(button2Border, TweenInfo.new(0.2), {
				Color = Color3.fromRGB(100, 100, 100)
			}):Play()
		end
	end)

	button1.MouseButton1Click:Connect(function()
		if button1Active then
			button1Active = false
			TweenService:Create(button1, TweenInfo.new(0.3), {
				BackgroundColor3 = Color3.fromRGB(200, 50, 50),
				TextColor3 = Color3.fromRGB(0, 0, 0)
			}):Play()
			TweenService:Create(button1Border, TweenInfo.new(0.3), {
				Color = Color3.fromRGB(150, 0, 0)
			}):Play()

			createNotification("Freeze Off")

			wait(2)
			if not button1Active then
				TweenService:Create(button1, TweenInfo.new(0.3), {
					BackgroundColor3 = Color3.fromRGB(30, 30, 30),
					TextColor3 = Color3.fromRGB(255, 255, 255)
				}):Play()
				TweenService:Create(button1Border, TweenInfo.new(0.3), {
					Color = Color3.fromRGB(100, 100, 100)
				}):Play()
				button1.Text = "Freeze Trade"
			end
		else
			button1Active = true
			TweenService:Create(button1, TweenInfo.new(0.3), {
				BackgroundColor3 = Color3.fromRGB(50, 200, 50),
				TextColor3 = Color3.fromRGB(0, 0, 0)
			}):Play()
			TweenService:Create(button1Border, TweenInfo.new(0.3), {
				Color = Color3.fromRGB(0, 150, 0)
			}):Play()
			button1.Text = "FREEZE ACTIVE"

			createNotification("Freeze On")
		end
	end)

	button2.MouseButton1Click:Connect(function()
		if button2Active then
			button2Active = false
			TweenService:Create(button2, TweenInfo.new(0.3), {
				BackgroundColor3 = Color3.fromRGB(200, 50, 50),
				TextColor3 = Color3.fromRGB(0, 0, 0)
			}):Play()
			TweenService:Create(button2Border, TweenInfo.new(0.3), {
				Color = Color3.fromRGB(150, 0, 0)
			}):Play()

			createNotification("Auto Accept Off")

			wait(2)
			if not button2Active then
				TweenService:Create(button2, TweenInfo.new(0.3), {
					BackgroundColor3 = Color3.fromRGB(30, 30, 30),
					TextColor3 = Color3.fromRGB(255, 255, 255)
				}):Play()
				TweenService:Create(button2Border, TweenInfo.new(0.3), {
					Color = Color3.fromRGB(100, 100, 100)
				}):Play()
				button2.Text = "Accept Trade"
			end
		else
			button2Active = true
			TweenService:Create(button2, TweenInfo.new(0.3), {
				BackgroundColor3 = Color3.fromRGB(50, 200, 50),
				TextColor3 = Color3.fromRGB(0, 0, 0)
			}):Play()
			TweenService:Create(button2Border, TweenInfo.new(0.3), {
				Color = Color3.fromRGB(0, 150, 0)
			}):Play()
			button2.Text = "ACCEPTED"

			createNotification("Auto Accept On")
		end
	end)
end

local function showMainGUI()
	mainGui.Enabled = true

	local bgTween = TweenService:Create(mainFrame, TweenInfo.new(0.7),
		{BackgroundTransparency = 0})
	local borderTween = TweenService:Create(mainBorder, TweenInfo.new(0.7),
		{Transparency = 0})
	local titleTween = TweenService:Create(mainTitle, TweenInfo.new(0.8),
		{TextTransparency = 0})

	bgTween:Play()
	borderTween:Play()
	titleTween:Play()

	enableDragging(mainFrame, mainTitle)
	enableDragging(mainFrame, mainFrame)

	wait(0.5)
	createButtons()
end

local function transitionToMain()
	local hideTween = TweenService:Create(introFrame, TweenInfo.new(0.5),
		{
			BackgroundTransparency = 1,
			Position = UDim2.new(0.5, -175, 0.3, -75)
		})
	local textHideTween = TweenService:Create(introTitle, TweenInfo.new(0.4),
		{TextTransparency = 1})
	local borderHideTween = TweenService:Create(introBorder, TweenInfo.new(0.4),
		{Transparency = 1})

	textHideTween:Play()
	borderHideTween:Play()
	hideTween:Play()

	hideTween.Completed:Connect(function()
		introGui:Destroy()
		showMainGUI()
	end)
end

showIntro()
wait(2)
transitionToMain()
