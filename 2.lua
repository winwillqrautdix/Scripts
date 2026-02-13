-- AutoFarm v1 mm2 by meentoz (Valentine Edition) 
-- Переделано: вместо снежинок сыпятся сердечки

local ScreenGui = Instance.new("ScreenGui")
local player = game:GetService("Players").LocalPlayer
ScreenGui.Parent = player:WaitForChild("PlayerGui")
ScreenGui.ResetOnSpawn = false

local HeartButton = Instance.new("TextButton")
HeartButton.Name = "HeartButton"
HeartButton.Size = UDim2.new(0, 50, 0, 50)
HeartButton.Position = UDim2.new(0, 400, 0.1, -85)
HeartButton.BackgroundColor3 = Color3.fromRGB(255, 87, 127)
HeartButton.Text = "❤️"
HeartButton.TextColor3 = Color3.fromRGB(255, 255, 255)
HeartButton.Font = Enum.Font.GothamBold
HeartButton.TextSize = 24
HeartButton.Parent = ScreenGui

local HeartCorner = Instance.new("UICorner")
HeartCorner.CornerRadius = UDim.new(1, 0)
HeartCorner.Parent = HeartButton

local HeartStroke = Instance.new("UIStroke")
HeartStroke.Color = Color3.fromRGB(255, 200, 220)
HeartStroke.Thickness = 3
HeartStroke.Transparency = 0
HeartStroke.LineJoinMode = Enum.LineJoinMode.Round
HeartStroke.Parent = HeartButton

local guiVisible = false
local tweenService = game:GetService("TweenService")

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainUI"
MainFrame.Size = UDim2.new(0, 300, 0, 500)
MainFrame.Position = UDim2.new(0.5, -150, 0.5, -250)
MainFrame.BackgroundColor3 = Color3.fromRGB(219, 58, 94)
MainFrame.Parent = ScreenGui
MainFrame.BackgroundTransparency = 0.7
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Visible = false

local HeartsBackground = Instance.new("Frame")
HeartsBackground.Name = "HeartsBackground"
HeartsBackground.Size = UDim2.new(1, 0, 1, 0)
HeartsBackground.BackgroundTransparency = 1
HeartsBackground.Parent = MainFrame
HeartsBackground.ZIndex = 0

local hearts = {}
local heartChars = {"❤️","🧡","💛","💚","💙","💜","🖤","🤍","🤎","💕","💖","💗","💓","💞"}

-- Функция создания сердечка
local function createHeart()
	local heart = Instance.new("TextLabel")
	heart.Name = "Heart"
	heart.Size = UDim2.new(0, 20, 0, 20)
	
	heart.Position = UDim2.new(
		math.random() * 0.9,
		0,
		0,
		0
	)
	
	heart.Text = heartChars[math.random(1, #heartChars)]
	heart.TextColor3 = Color3.fromRGB(255, 105, 180)  -- Розовый
	heart.TextTransparency = math.random(30, 70) / 100
	heart.Font = Enum.Font.Gotham
	heart.TextSize = math.random(15, 30)
	heart.BackgroundTransparency = 1
	heart.Parent = HeartsBackground
	heart.ZIndex = 0
	
	local speed = math.random(30, 60) / 100
	local rotationSpeed = math.random(-100, 100) / 10
	
	coroutine.wrap(function()
		while heart.Parent do
			local currentY = heart.Position.Y.Scale
			heart.Position = UDim2.new(
				heart.Position.X.Scale,
				heart.Position.X.Offset,
				currentY + 0.01 * speed,
				heart.Position.Y.Offset
			)
			
			heart.Rotation = heart.Rotation + rotationSpeed
			
			if currentY > 0.9 then
				heart:Destroy()
				for i, v in ipairs(hearts) do
					if v == heart then
						table.remove(hearts, i)
						break
					end
				end
				createHeart()
				break
			end
			
			wait(0.03)
		end
	end)()
	
	table.insert(hearts, heart)
	return heart
end

for i = 1, 10 do
	createHeart()
	wait(0.1)
end

coroutine.wrap(function()
	while HeartsBackground.Parent do
		wait(2)
		if #hearts < 15 then
			createHeart()
		end
	end
end)()

local heartPosition = HeartButton.Position

local function openGUI()
	guiVisible = true
	
	MainFrame.Size = UDim2.new(0, 10, 0, 10)
	MainFrame.Position = heartPosition
	MainFrame.Visible = true
	
	local sizeTween = tweenService:Create(
		MainFrame,
		TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
		{Size = UDim2.new(0, 300, 0, 500)}
	)
	
	local positionTween = tweenService:Create(
		MainFrame,
		TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
		{Position = UDim2.new(0.5, -150, 0.5, -250)}
	)
	
	sizeTween:Play()
	positionTween:Play()
	
	local rotateTween = tweenService:Create(
		HeartButton,
		TweenInfo.new(0.5, Enum.EasingStyle.Quad),
		{Rotation = 360}
	)
	rotateTween:Play()
	
	print("GUI")
end

local function closeGUI()
	guiVisible = false
	
	local sizeTween = tweenService:Create(
		MainFrame,
		TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.In),
		{Size = UDim2.new(0, 10, 0, 10)}
	)
	
	local positionTween = tweenService:Create(
		MainFrame,
		TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.In),
		{Position = heartPosition}
	)
	
	sizeTween:Play()
	positionTween:Play()
	
	local rotateTween = tweenService:Create(
		HeartButton,
		TweenInfo.new(0.5, Enum.EasingStyle.Quad),
		{Rotation = 0}
	)
	rotateTween:Play()
	
	print("GUI закрывается...")
	
	task.wait(0.5)
	MainFrame.Visible = false
end

HeartButton.MouseButton1Click:Connect(function()
	print("Сердечко нажато! Состояние GUI:", guiVisible)
	
	if not guiVisible then
		openGUI()
	else
		closeGUI()
	end
end)

local UICorner = Instance.new("UICorner")
UICorner.Parent = MainFrame
UICorner.CornerRadius = UDim.new(0, 12)

local UIStroke = Instance.new("UIStroke")
UIStroke.Parent = MainFrame
UIStroke.Color = Color3.fromRGB(255, 20, 147)  -- Розовый
UIStroke.Thickness = 4
UIStroke.Transparency = 0
UIStroke.LineJoinMode = Enum.LineJoinMode.Round
UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

local Title = Instance.new("TextLabel")
Title.Name = "Title"
Title.Size = UDim2.new(1, -50, 0, 50)
Title.Position = UDim2.new(0, 20, 0, 20)
Title.BackgroundTransparency = 1
Title.Text = "Valentine AutoFarm MM2❤️"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.GothamBlack
Title.TextSize = 22
Title.Parent = MainFrame

local Version = Instance.new("TextLabel")
Version.Name = "Version"
Version.Size = UDim2.new(0, 30, 0, 30)
Version.Position = UDim2.new(1, -40, 0, 45)
Version.BackgroundTransparency = 1
Version.Text = "v1"
Version.TextColor3 = Color3.fromRGB(255, 20, 147)
Version.Font = Enum.Font.GothamBold
Version.TextSize = 16
Version.TextXAlignment = Enum.TextXAlignment.Right
Version.Parent = MainFrame

local Divider = Instance.new("Frame")
Divider.Name = "Divider"
Divider.Size = UDim2.new(1, 0, 0, 2)
Divider.Position = UDim2.new(0, 0, 0, 80)
Divider.BackgroundColor3 = Color3.fromRGB(255, 20, 147)
Divider.BorderSizePixel = 0
Divider.Parent = MainFrame

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local workspace = game:GetService("Workspace")
local player = game:GetService("Players").LocalPlayer

local autoFarmEnabled = false
local autoResetEnabled = false
local farmSpeed = 20
local farming = false
local bag_full = false
local resetting = false
local start_position = nil

local CoinCollected, RoundStart, RoundEnd
pcall(function()
	CoinCollected = ReplicatedStorage.Remotes.Gameplay.CoinCollected
	RoundStart = ReplicatedStorage.Remotes.Gameplay.RoundStart
	RoundEnd = ReplicatedStorage.Remotes.Gameplay.RoundEndFade
end)

-- Если RemoteEvents не найдены, создаем заглушки
if not CoinCollected then
	warn("⚠️ RemoteEvents не найдены! AutoFarm может не работать.")
end

local function getCharacter() 
	return player.Character or player.CharacterAdded:Wait() 
end

local function getHRP() 
	local char = getCharacter()
	return char:WaitForChild("HumanoidRootPart")
end

local function get_nearest_coin()
	local hrp = getHRP()
	if not hrp then return nil, math.huge end
	
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

if RoundStart then
	RoundStart.OnClientEvent:Connect(function()
		farming = true
		print("Раунд начался, farming = true")
	end)
end

if RoundEnd then
	RoundEnd.OnClientEvent:Connect(function()
		farming = false
		print("Раунд окончен, farming = false")
	end)
end

if CoinCollected then
	CoinCollected.OnClientEvent:Connect(function(_, current, max)
		if current == max and not resetting and autoResetEnabled then
			print("Сумка заполнена! Запускаем Reset...")
			resetting = true
			bag_full = true
			local hrp = getHRP()
			if start_position then
				local tween = TweenService:Create(hrp, TweenInfo.new(2, Enum.EasingStyle.Linear), {CFrame = start_position})
				tween:Play()
				tween.Completed:Wait()
			end
			wait(0.5)
			if player.Character and player.Character:FindFirstChild("Humanoid") then
				player.Character.Humanoid.Health = 0
			end
			player.CharacterAdded:Wait()
			wait(1.5)
			resetting = false
			bag_full = false
			print("Reset завершен")
		end
	end)
end

if RoundStart then
	RoundStart.OnClientEvent:Connect(function()
		if player.Character then
			local hrp = player.Character:FindFirstChild("HumanoidRootPart")
			if hrp then
				start_position = hrp.CFrame
				print("Стартовая позиция сохранена")
			end
		end
	end)
end

local autoFarmCoroutine = nil
local function startAutoFarm()
	if autoFarmCoroutine then 
		autoFarmCoroutine = nil
	end
	
	print("🚀 AutoFarm ВКЛЮЧЕН! Скорость: " .. farmSpeed)
	autoFarmEnabled = true
	
	autoFarmCoroutine = coroutine.wrap(function()
		while autoFarmEnabled do
			if farming and not bag_full then
				local coin, dist = get_nearest_coin()
				if coin and player.Character then
					local hrp = player.Character:FindFirstChild("HumanoidRootPart")
					if hrp then
						if dist > 150 then
							hrp.CFrame = coin.CFrame
						else
							local tween = TweenService:Create(hrp, TweenInfo.new(dist / farmSpeed, Enum.EasingStyle.Linear), {CFrame = coin.CFrame})
							tween:Play()
							repeat 
								wait() 
							until not coin:FindFirstChild("TouchInterest") or not farming or not autoFarmEnabled or not hrp.Parent
							tween:Cancel()
						end
					end
				end
			end
			wait(0.2)
		end
		print("AutoFarm OFF")
	end)()
	
	autoFarmCoroutine()
end

local function stopAutoFarm()
	autoFarmEnabled = false
	autoFarmCoroutine = nil
	print("AutoFarm ВЫКЛЮЧЕН")
end

local function createModernToggle(name, text, position, defaultValue)
	-- Контейнер
	local ToggleContainer = Instance.new("Frame")
	ToggleContainer.Name = name .. "Toggle"
	ToggleContainer.Size = UDim2.new(1, -40, 0, 40)
	ToggleContainer.Position = position
	ToggleContainer.BackgroundTransparency = 1
	ToggleContainer.Active = true
	ToggleContainer.Parent = MainFrame
	
	local Background = Instance.new("Frame")
	Background.Name = "Background"
	Background.Size = UDim2.new(1, 0, 1, 0)
	Background.BackgroundColor3 = Color3.fromRGB(219, 58, 94)
	Background.BackgroundTransparency = 0.4
	Background.Active = true
	Background.Parent = ToggleContainer
	
	local BackgroundCorner = Instance.new("UICorner")
	BackgroundCorner.CornerRadius = UDim.new(0, 8)
	BackgroundCorner.Parent = Background
	
	local BackgroundStroke = Instance.new("UIStroke")
	BackgroundStroke.Color = Color3.fromRGB(255, 20, 147)
	BackgroundStroke.Thickness = 1
	BackgroundStroke.Parent = Background
	
	local TextLabel = Instance.new("TextLabel")
	TextLabel.Name = "Text"
	TextLabel.Size = UDim2.new(0.7, 0, 1, 0)
	TextLabel.Position = UDim2.new(0, 15, 0, 0)
	TextLabel.BackgroundTransparency = 1
	TextLabel.Text = text
	TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
	TextLabel.Font = Enum.Font.Gotham
	TextLabel.TextSize = 21
	TextLabel.TextXAlignment = Enum.TextXAlignment.Left
	TextLabel.Active = true
	TextLabel.Parent = ToggleContainer
	
	local ToggleSwitch = Instance.new("Frame")
	ToggleSwitch.Name = "Switch"
	ToggleSwitch.Size = UDim2.new(0, 60, 0, 30)
	ToggleSwitch.Position = UDim2.new(1, -30, 1, -20)
	ToggleSwitch.AnchorPoint = Vector2.new(1, 0.5)
	ToggleSwitch.BackgroundColor3 = defaultValue and Color3.fromRGB(255, 20, 147) or Color3.fromRGB(124, 124, 124)
	ToggleSwitch.Active = true
	ToggleSwitch.Parent = ToggleContainer
	
	local SwitchCorner = Instance.new("UICorner")
	SwitchCorner.CornerRadius = UDim.new(0, 15)
	SwitchCorner.Parent = ToggleSwitch
	
	local SwitchStroke = Instance.new("UIStroke")
	SwitchStroke.Color = Color3.fromRGB(255, 105, 180)
	SwitchStroke.Thickness = 1
	SwitchStroke.Transparency = 0.3
	SwitchStroke.Parent = ToggleSwitch
	
	local ToggleSlider = Instance.new("Frame")
	ToggleSlider.Name = "Slider"
	ToggleSlider.Size = UDim2.new(0, 26, 0, 26)
	ToggleSlider.Position = defaultValue and UDim2.new(1, -28, 1, -10) or UDim2.new(1, 2, 1, -10)
	ToggleSlider.AnchorPoint = Vector2.new(0, 0)
	ToggleSlider.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	ToggleSlider.Parent = ToggleSwitch
	
	local SliderCorner = Instance.new("UICorner")
	SliderCorner.CornerRadius = UDim.new(1, 0)
	SliderCorner.Parent = ToggleSlider
	
	local isEnabled = defaultValue
	
	local function toggleState()
		isEnabled = not isEnabled
		
		game:GetService("TweenService"):Create(
			ToggleSwitch,
			TweenInfo.new(0.2),
			{BackgroundColor3 = isEnabled and Color3.fromRGB(255, 20, 147) or Color3.fromRGB(124, 124, 124)}
		):Play()
		
		game:GetService("TweenService"):Create(
			ToggleSlider,
			TweenInfo.new(0.2),
			{Position = isEnabled and UDim2.new(1, -28, 0.5, -13) or UDim2.new(0, 2, 0.5, -13)}
		):Play()
		
		print(text .. ": " .. (isEnabled and "ВКЛЮЧЕНО" or "ВЫКЛЮЧЕНО"))
		return isEnabled
	end
	
	
	if not defaultValue then
		ToggleSwitch.BackgroundColor3 = Color3.fromRGB(124, 124, 124)
		ToggleSlider.Position = UDim2.new(0, 2, 0.5, -13)
	else
		ToggleSwitch.BackgroundColor3 = Color3.fromRGB(255, 20, 147)
		ToggleSlider.Position = UDim2.new(1, -28, 0.5, -13)
	end
	
	
	ToggleContainer.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			local newState = toggleState()
			
			
			if name == "FarmCoins" then
				if newState then
					startAutoFarm()
				else
					stopAutoFarm()
				end
			elseif name == "Reset" then
				autoResetEnabled = newState
				print("Auto Reset: " .. (autoResetEnabled and "ON" or "OFF"))
			elseif name == "AntiAfk" then
				if newState then
					local VirtualUser = game:GetService("VirtualUser")
					player.Idled:Connect(function()
						VirtualUser:CaptureController()
						VirtualUser:ClickButton2(Vector2.new())
					end)
					print("Anti-AFK ON")
				else
					print("Anti-AFK OFF")
				end
			end
		end
	end)
	
	Background.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			ToggleContainer.InputBegan:Fire(input)
		end
	end)
	
	ToggleSwitch.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			ToggleContainer.InputBegan:Fire(input)
		end
	end)
	
	TextLabel.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			ToggleContainer.InputBegan:Fire(input)
		end
	end)
	
	ToggleContainer.MouseEnter:Connect(function()
		game:GetService("TweenService"):Create(
			Background,
			TweenInfo.new(0.2),
			{BackgroundTransparency = 0.2}
		):Play()
	end)
	
	ToggleContainer.MouseLeave:Connect(function()
		game:GetService("TweenService"):Create(
			Background,
			TweenInfo.new(0.2),
			{BackgroundTransparency = 0.4}
		):Play()
	end)
	
	return {Container = ToggleContainer, toggleFunction = toggleState, isEnabled = function() return isEnabled end}
end


local toggleList = {
	{"FarmCoins", "❤️ AutoFarm", UDim2.new(0, 20, 0, 100), false},
	{"Reset", "💝 Reset FullBag", UDim2.new(0, 20, 0, 160), false},
	{"AntiAfk", "💖 AntiAfk", UDim2.new(0, 20, 0, 220), false},
}


local toggles = {}


for i, toggleData in ipairs(toggleList) do
	local name, text, position, defaultValue = toggleData[1], toggleData[2], toggleData[3], toggleData[4]
	local toggle = createModernToggle(name, text, position, defaultValue)
	toggles[name] = toggle
end


local SpeedContainer = Instance.new("Frame")
SpeedContainer.Name = "SpeedToggle"
SpeedContainer.Size = UDim2.new(1, -40, 0, 40)
SpeedContainer.Position = UDim2.new(0, 20, 0, 280)
SpeedContainer.BackgroundTransparency = 1
SpeedContainer.Active = true
SpeedContainer.Parent = MainFrame


local Background = Instance.new("Frame")
Background.Name = "Background"
Background.Size = UDim2.new(1, 0, 1, 0)
Background.BackgroundColor3 = Color3.fromRGB(219, 58, 94)
Background.BackgroundTransparency = 0.4
Background.Active = true
Background.Parent = SpeedContainer

local BackgroundCorner = Instance.new("UICorner")
BackgroundCorner.CornerRadius = UDim.new(0, 8)
BackgroundCorner.Parent = Background

local BackgroundStroke = Instance.new("UIStroke")
BackgroundStroke.Color = Color3.fromRGB(255, 20, 147)
BackgroundStroke.Thickness = 1
BackgroundStroke.Parent = Background


local SpeedTextLabel = Instance.new("TextLabel")
SpeedTextLabel.Name = "Text"
SpeedTextLabel.Size = UDim2.new(0.7, 0, 1, 0)
SpeedTextLabel.Position = UDim2.new(0, 15, 0, 0)
SpeedTextLabel.BackgroundTransparency = 1
SpeedTextLabel.Text = "⚡ Farm Speed: " .. farmSpeed
SpeedTextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
SpeedTextLabel.Font = Enum.Font.Gotham
SpeedTextLabel.TextSize = 21
SpeedTextLabel.TextXAlignment = Enum.TextXAlignment.Left
SpeedTextLabel.Active = true
SpeedTextLabel.Parent = SpeedContainer


local SpeedInput = Instance.new("TextBox")
SpeedInput.Name = "SpeedInput"
SpeedInput.Size = UDim2.new(0, 60, 0, 30)
SpeedInput.Position = UDim2.new(1, -15, 0.9, -15)
SpeedInput.AnchorPoint = Vector2.new(1, 0.5)
SpeedInput.BackgroundColor3 = Color3.fromRGB(255, 105, 180)
SpeedInput.TextColor3 = Color3.fromRGB(255, 255, 255)
SpeedInput.Font = Enum.Font.Gotham
SpeedInput.TextSize = 16
SpeedInput.Text = tostring(farmSpeed)
SpeedInput.PlaceholderText = "Speed"
SpeedInput.Parent = SpeedContainer

local InputCorner = Instance.new("UICorner")
InputCorner.CornerRadius = UDim.new(0, 6)
InputCorner.Parent = SpeedInput

local InputStroke = Instance.new("UIStroke")
InputStroke.Color = Color3.fromRGB(255, 20, 147)
InputStroke.Thickness = 1
InputStroke.Transparency = 0.3
InputStroke.Parent = SpeedInput


SpeedInput.FocusLost:Connect(function(enterPressed)
	if enterPressed then
		local newSpeed = tonumber(SpeedInput.Text)
		if newSpeed and newSpeed >= 5 and newSpeed <= 100 then
			farmSpeed = newSpeed
			SpeedTextLabel.Text = "⚡ Farm Speed: " .. farmSpeed
			print("Скорость AutoFarm изменена на: " .. farmSpeed)
			
			SpeedInput.BackgroundColor3 = Color3.fromRGB(255, 20, 147)
			wait(0.3)
			SpeedInput.BackgroundColor3 = Color3.fromRGB(255, 105, 180)
		else
			SpeedInput.Text = tostring(farmSpeed)
			SpeedInput.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
			print("Ошибка! Скорость должна быть от 5 до 100")
			wait(0.3)
			SpeedInput.BackgroundColor3 = Color3.fromRGB(255, 105, 180)
		end
	end
end)


SpeedContainer.MouseEnter:Connect(function()
	game:GetService("TweenService"):Create(
		Background,
		TweenInfo.new(0.2),
		{BackgroundTransparency = 0.2}
	):Play()
end)

SpeedContainer.MouseLeave:Connect(function()
	game:GetService("TweenService"):Create(
		Background,
		TweenInfo.new(0.2),
		{BackgroundTransparency = 0.4}
	):Play()
end)


local TimeCounter = Instance.new("TextLabel")
TimeCounter.Name = "TimeCounter"
TimeCounter.Size = UDim2.new(1, -40, 0, 30)
TimeCounter.Position = UDim2.new(0, 20, 1, -35)
TimeCounter.BackgroundColor3 = Color3.fromRGB(219, 58, 94)
TimeCounter.BackgroundTransparency = 0.3
TimeCounter.Text = "Time Farm: 00:00:00"
TimeCounter.TextColor3 = Color3.fromRGB(255, 255, 255)
TimeCounter.Font = Enum.Font.Gotham
TimeCounter.TextSize = 20
TimeCounter.TextXAlignment = Enum.TextXAlignment.Center
TimeCounter.Parent = MainFrame

local TimeCorner = Instance.new("UICorner")
TimeCorner.CornerRadius = UDim.new(0, 8)
TimeCorner.Parent = TimeCounter

local TimeStroke = Instance.new("UIStroke")
TimeStroke.Color = Color3.fromRGB(255, 20, 147)
TimeStroke.Thickness = 2
TimeStroke.Parent = TimeCounter


local startTime = tick()
local function updateTime()
	while TimeCounter.Parent do
		local elapsed = tick() - startTime
		local hours = math.floor(elapsed / 3600)
		local minutes = math.floor((elapsed % 3600) / 60)
		local seconds = math.floor(elapsed % 60)
		
		TimeCounter.Text = string.format("Time Farm: %02d:%02d:%02d", hours, minutes, seconds)
		wait(1)
	end
end


coroutine.wrap(updateTime)()

coroutine.wrap(function()
	while true do
		if autoFarmEnabled and farming then
			print("farming=" .. tostring(farming))
		end
		wait(5)
	end
end)()
