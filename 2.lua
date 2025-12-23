-- AutoFasrm v1 mm2 by meentoz sourse

local ScreenGui = Instance.new("ScreenGui")
local player = game:GetService("Players").LocalPlayer
ScreenGui.Parent = player:WaitForChild("PlayerGui")
ScreenGui.ResetOnSpawn = false

local SnowflakeButton = Instance.new("TextButton")
SnowflakeButton.Name = "SnowflakeButton"
SnowflakeButton.Size = UDim2.new(0, 50, 0, 50)
SnowflakeButton.Position = UDim2.new(0, 400, 0.1, -85)
SnowflakeButton.BackgroundColor3 = Color3.fromRGB(58, 237, 248)
SnowflakeButton.Text = "вќ„пёЏ"
SnowflakeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
SnowflakeButton.Font = Enum.Font.GothamBold
SnowflakeButton.TextSize = 24
SnowflakeButton.Parent = ScreenGui

local SnowflakeCorner = Instance.new("UICorner")
SnowflakeCorner.CornerRadius = UDim.new(1, 0)
SnowflakeCorner.Parent = SnowflakeButton

local UserInputService = game:GetService("UserInputService")
local isMobile = UserInputService.TouchEnabled

if isMobile then
    SnowflakeButton.Size = UDim2.new(0, 70, 0, 70)
    SnowflakeButton.Position = UDim2.new(0, 20, 0.1, -85)
    SnowflakeButton.TextSize = 32
end

local SnowflakeStroke = Instance.new("UIStroke")
SnowflakeStroke.Color = Color3.fromRGB(255, 255, 255)
SnowflakeStroke.Thickness = 3
SnowflakeStroke.Transparency = 0
SnowflakeStroke.LineJoinMode = Enum.LineJoinMode.Round
SnowflakeStroke.Parent = SnowflakeButton

local guiVisible = false
local tweenService = game:GetService("TweenService")

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainUI"
MainFrame.Size = UDim2.new(0, 300, 0, 500)
MainFrame.Position = UDim2.new(0.5, -150, 0.5, -250)
MainFrame.BackgroundColor3 = Color3.fromRGB(9, 116, 236)
MainFrame.Parent = ScreenGui
MainFrame.BackgroundTransparency = 0.7
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Visible = false

local SnowflakesBackground = Instance.new("Frame")
SnowflakesBackground.Name = "SnowflakesBackground"
SnowflakesBackground.Size = UDim2.new(1, 0, 1, 0)
SnowflakesBackground.BackgroundTransparency = 1
SnowflakesBackground.Parent = MainFrame
SnowflakesBackground.ZIndex = 0

local snowflakes = {}
local snowflakeChars = {"вќ„","в›„"}

-- Р¤СѓРЅРєС†РёСЏ СЃРѕР·РґР°РЅРёСЏ СЃРЅРµР¶РёРЅРєРё
local function createSnowflake()
	local snowflake = Instance.new("TextLabel")
	snowflake.Name = "Snowflake"
	snowflake.Size = UDim2.new(0, 20, 0, 20)

	snowflake.Position = UDim2.new(
		math.random() * 0.9,
		0,
		0,
		0
	)

	snowflake.Text = snowflakeChars[math.random(1, #snowflakeChars)]
	snowflake.TextColor3 = Color3.fromRGB(255, 255, 255)
	snowflake.TextTransparency = math.random(30, 70) / 100
	snowflake.Font = Enum.Font.Gotham
	snowflake.TextSize = math.random(15, 30)
	snowflake.BackgroundTransparency = 1
	snowflake.Parent = SnowflakesBackground
	snowflake.ZIndex = 0

	local speed = math.random(30, 60) / 100
	local rotationSpeed = math.random(-100, 100) / 10

	coroutine.wrap(function()
		while snowflake.Parent do
			local currentY = snowflake.Position.Y.Scale
			snowflake.Position = UDim2.new(
				snowflake.Position.X.Scale,
				snowflake.Position.X.Offset,
				currentY + 0.01 * speed,
				snowflake.Position.Y.Offset
			)

			snowflake.Rotation = snowflake.Rotation + rotationSpeed

			if currentY > 0.9 then
				snowflake:Destroy()
				for i, v in ipairs(snowflakes) do
					if v == snowflake then
						table.remove(snowflakes, i)
						break
					end
				end
				createSnowflake()
				break
			end

			wait(0.03)
		end
	end)()

	table.insert(snowflakes, snowflake)
	return snowflake
end

for i = 1, 10 do
	createSnowflake()
	wait(0.1)
end

coroutine.wrap(function()
	while SnowflakesBackground.Parent do
		wait(2)
		if #snowflakes < 15 then
			createSnowflake()
		end
	end
end)()

local snowflakePosition = SnowflakeButton.Position

local function openGUI()
	guiVisible = true

	MainFrame.Size = UDim2.new(0, 10, 0, 10)
	MainFrame.Position = snowflakePosition
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
		SnowflakeButton,
		TweenInfo.new(0.5, Enum.EasingStyle.Quad),
		{Rotation = 180}
	)
	rotateTween:Play()

	print("GUI РѕС‚РєСЂС‹РІР°РµС‚СЃСЏ...")
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
		{Position = snowflakePosition}
	)

	sizeTween:Play()
	positionTween:Play()

	local rotateTween = tweenService:Create(
		SnowflakeButton,
		TweenInfo.new(0.5, Enum.EasingStyle.Quad),
		{Rotation = 0}
	)
	rotateTween:Play()

	print("GUI Р·Р°РєСЂС‹РІР°РµС‚СЃСЏ...")

	task.wait(0.5)
	MainFrame.Visible = false
end

SnowflakeButton.MouseButton1Click:Connect(function()
	print("РЎРЅРµР¶РёРЅРєР° РЅР°Р¶Р°С‚Р°! РЎРѕСЃС‚РѕСЏРЅРёРµ GUI:", guiVisible)

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
UIStroke.Color = Color3.fromRGB(2, 14, 222)
UIStroke.Thickness = 4
UIStroke.Transparency = 0
UIStroke.LineJoinMode = Enum.LineJoinMode.Round
UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

local Title = Instance.new("TextLabel")
Title.Name = "Title"
Title.Size = UDim2.new(1, -50, 0, 50)
Title.Position = UDim2.new(0, 20, 0, 20)
Title.BackgroundTransparency = 1
Title.Text = "Winter AutoFarm MM2вќ„пёЏ"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.GothamBlack
Title.TextSize = 20
Title.Parent = MainFrame

local Version = Instance.new("TextLabel")
Version.Name = "Version"
Version.Size = UDim2.new(0, 30, 0, 30)
Version.Position = UDim2.new(1, -40, 0, 25)
Version.BackgroundTransparency = 1
Version.Text = "v1"
Version.TextColor3 = Color3.fromRGB(2, 14, 222)
Version.Font = Enum.Font.GothamBold
Version.TextSize = 16
Version.TextXAlignment = Enum.TextXAlignment.Right
Version.Parent = MainFrame

local Divider = Instance.new("Frame")
Divider.Name = "Divider"
Divider.Size = UDim2.new(1, 0, 0, 2)
Divider.Position = UDim2.new(0, 0, 0, 80)
Divider.BackgroundColor3 = Color3.fromRGB(2, 14, 222)
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

-- Р•СЃР»Рё RemoteEvents РЅРµ РЅР°Р№РґРµРЅС‹, СЃРѕР·РґР°РµРј Р·Р°РіР»СѓС€РєРё
if not CoinCollected then
	warn("вљ пёЏ RemoteEvents РЅРµ РЅР°Р№РґРµРЅС‹! AutoFarm РјРѕР¶РµС‚ РЅРµ СЂР°Р±РѕС‚Р°С‚СЊ.")
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
		print("Р Р°СѓРЅРґ РЅР°С‡Р°Р»СЃСЏ, farming = true")
	end)
end

if RoundEnd then
	RoundEnd.OnClientEvent:Connect(function()
		farming = false
		print("Р Р°СѓРЅРґ РѕРєРѕРЅС‡РµРЅ, farming = false")
	end)
end

if CoinCollected then
	CoinCollected.OnClientEvent:Connect(function(_, current, max)
		if current == max and not resetting and autoResetEnabled then
			print("РЎСѓРјРєР° Р·Р°РїРѕР»РЅРµРЅР°! Р—Р°РїСѓСЃРєР°РµРј Reset...")
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
			print("Reset Р·Р°РІРµСЂС€РµРЅ")
		end
	end)
end

if RoundStart then
	RoundStart.OnClientEvent:Connect(function()
		if player.Character then
			local hrp = player.Character:FindFirstChild("HumanoidRootPart")
			if hrp then
				start_position = hrp.CFrame
				print("РЎС‚Р°СЂС‚РѕРІР°СЏ РїРѕР·РёС†РёСЏ СЃРѕС…СЂР°РЅРµРЅР°")
			end
		end
	end)
end

local autoFarmCoroutine = nil
local function startAutoFarm()
	if autoFarmCoroutine then 
		-- РћСЃС‚Р°РЅР°РІР»РёРІР°РµРј СЃС‚Р°СЂСѓСЋ РєРѕСЂСѓС‚РёРЅСѓ РµСЃР»Рё РµСЃС‚СЊ
		autoFarmCoroutine = nil
	end

	print("рџљЂ AutoFarm Р’РљР›Р®Р§Р•Рќ! РЎРєРѕСЂРѕСЃС‚СЊ: " .. farmSpeed)
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
		print("AutoFarm Р’Р«РљР›Р®Р§Р•Рќ")
	end)()

	autoFarmCoroutine()
end

local function stopAutoFarm()
	autoFarmEnabled = false
	autoFarmCoroutine = nil
	print("AutoFarm Р’Р«РљР›Р®Р§Р•Рќ")
end

local function createModernToggle(name, text, position, defaultValue)
	-- РљРѕРЅС‚РµР№РЅРµСЂ
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
	Background.BackgroundColor3 = Color3.fromRGB(2, 31, 126)
	Background.BackgroundTransparency = 0.4
	Background.Active = true
	Background.Parent = ToggleContainer

	local BackgroundCorner = Instance.new("UICorner")
	BackgroundCorner.CornerRadius = UDim.new(0, 8)
	BackgroundCorner.Parent = Background

	local BackgroundStroke = Instance.new("UIStroke")
	BackgroundStroke.Color = Color3.fromRGB(2, 14, 222)
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
	ToggleSwitch.BackgroundColor3 = defaultValue and Color3.fromRGB(38, 0, 255) or Color3.fromRGB(124, 124, 124) -- Р¤РРљРЎ: РїРѕРјРµРЅСЏР»Рё С†РІРµС‚Р° РјРµСЃС‚Р°РјРё
	ToggleSwitch.Active = true
	ToggleSwitch.Parent = ToggleContainer

	local SwitchCorner = Instance.new("UICorner")
	SwitchCorner.CornerRadius = UDim.new(0, 15)
	SwitchCorner.Parent = ToggleSwitch

	local SwitchStroke = Instance.new("UIStroke")
	SwitchStroke.Color = Color3.fromRGB(2, 15, 255)
	SwitchStroke.Thickness = 1
	SwitchStroke.Transparency = 0.3
	SwitchStroke.Parent = ToggleSwitch

	local ToggleSlider = Instance.new("Frame")
	ToggleSlider.Name = "Slider"
	ToggleSlider.Size = UDim2.new(0, 26, 0, 26)
	ToggleSlider.Position = defaultValue and UDim2.new(1, -28, 1, -10) or UDim2.new(1, 2, 1, -10) -- Р¤РРљРЎ: РїРѕРјРµРЅСЏР»Рё РјРµСЃС‚Р°РјРё
	ToggleSlider.AnchorPoint = Vector2.new(0, 0) -- Р¤РРљРЎ: СЏРєРѕСЂСЊ РїРѕ С†РµРЅС‚СЂСѓ Y
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
			{BackgroundColor3 = isEnabled and Color3.fromRGB(38, 0, 255) or Color3.fromRGB(124, 124, 124)}
		):Play()

		game:GetService("TweenService"):Create(
			ToggleSlider,
			TweenInfo.new(0.2),
			{Position = isEnabled and UDim2.new(1, -28, 0.5, -13) or UDim2.new(0, 2, 0.5, -13)}
		):Play()

		print(text .. ": " .. (isEnabled and "Р’РљР›Р®Р§Р•РќРћ" or "Р’Р«РљР›Р®Р§Р•РќРћ"))
		return isEnabled
	end

	
	if not defaultValue then
		ToggleSwitch.BackgroundColor3 = Color3.fromRGB(124, 124, 124)
		ToggleSlider.Position = UDim2.new(0, 2, 0.5, -13)
	else
		ToggleSwitch.BackgroundColor3 = Color3.fromRGB(38, 0, 255)
		ToggleSlider.Position = UDim2.new(1, -28, 0.5, -13)
	end

	
-- РЈРЅРёРІРµСЂСЃР°Р»СЊРЅР°СЏ С„СѓРЅРєС†РёСЏ РѕР±СЂР°Р±РѕС‚РєРё РєР»РёРєР°/РєР°СЃР°РЅРёСЏ
local function handleToggleClick()
    local newState = toggleState()

    -- РћР±СЂР°Р±РѕС‚РєР° С„СѓРЅРєС†РёР№ С‚РѕРіРіР»РѕРІ
    if name == "FarmCoins" then
        if newState then
            startAutoFarm()
        else
            stopAutoFarm()
        end
    elseif name == "Reset" then
        autoResetEnabled = newState
        print("Auto Reset: " .. (autoResetEnabled and "Р’РљР›Р®Р§Р•Рќ" or "Р’Р«РљР›Р®Р§Р•Рќ"))
    elseif name == "AntiAfk" then
        if newState then
            local VirtualUser = game:GetService("VirtualUser")
            player.Idled:Connect(function()
                VirtualUser:CaptureController()
                VirtualUser:ClickButton2(Vector2.new())
            end)
            print("Anti-AFK Р’РљР›Р®Р§Р•Рќ")
        else
            print("Anti-AFK Р’Р«РљР›Р®Р§Р•Рќ (РґР»СЏ РїРѕР»РЅРѕРіРѕ РѕС‚РєР»СЋС‡РµРЅРёСЏ РЅСѓР¶РЅР° РїРµСЂРµР·Р°РіСЂСѓР·РєР°)")
        end
    end
end

-- РћР±СЂР°Р±РѕС‚РєР° РєР»РёРєРѕРІ Рё РєР°СЃР°РЅРёР№ РґР»СЏ РІСЃРµРіРѕ РєРѕРЅС‚РµР№РЅРµСЂР°
ToggleContainer.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or 
       (isMobile and input.UserInputType == Enum.UserInputType.Touch) then
        handleToggleClick()
        
        -- Р’РёР·СѓР°Р»СЊРЅР°СЏ РѕР±СЂР°С‚РЅР°СЏ СЃРІСЏР·СЊ РґР»СЏ РјРѕР±РёР»СЊРЅС‹С… СѓСЃС‚СЂРѕР№СЃС‚РІ
        if isMobile then
            game:GetService("TweenService"):Create(
                Background,
                TweenInfo.new(0.1),
                {BackgroundTransparency = 0.1}
            ):Play()
            wait(0.1)
            game:GetService("TweenService"):Create(
                Background,
                TweenInfo.new(0.1),
                {BackgroundTransparency = 0.4}
            ):Play()
        end
    end
end)

-- РўР°РєР¶Рµ РґРѕР±Р°РІР»СЏРµРј РѕР±СЂР°Р±РѕС‚РєСѓ РґР»СЏ РІРЅСѓС‚СЂРµРЅРЅРёС… СЌР»РµРјРµРЅС‚РѕРІ
local function propagateClick(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or 
       (isMobile and input.UserInputType == Enum.UserInputType.Touch) then
        handleToggleClick()
    end
end

Background.InputBegan:Connect(propagateClick)
ToggleSwitch.InputBegan:Connect(propagateClick)
TextLabel.InputBegan:Connect(propagateClick)

	return {Container = ToggleContainer, toggleFunction = toggleState, isEnabled = function() return isEnabled end}
end


local toggleList = {
	{"FarmCoins", "рџЋ„ AutoFarm", UDim2.new(0, 20, 0, 100), false},
	{"Reset", "рџ”„ Reset FullBag", UDim2.new(0, 20, 0, 160), false},
	{"AntiAfk", "в›„ AntiAfk", UDim2.new(0, 20, 0, 220), false},
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
Background.BackgroundColor3 = Color3.fromRGB(2, 31, 126)
Background.BackgroundTransparency = 0.4
Background.Active = true
Background.Parent = SpeedContainer

local BackgroundCorner = Instance.new("UICorner")
BackgroundCorner.CornerRadius = UDim.new(0, 8)
BackgroundCorner.Parent = Background

local BackgroundStroke = Instance.new("UIStroke")
BackgroundStroke.Color = Color3.fromRGB(2, 14, 222)
BackgroundStroke.Thickness = 1
BackgroundStroke.Parent = Background


local SpeedTextLabel = Instance.new("TextLabel")
SpeedTextLabel.Name = "Text"
SpeedTextLabel.Size = UDim2.new(0.7, 0, 1, 0)
SpeedTextLabel.Position = UDim2.new(0, 15, 0, 0)
SpeedTextLabel.BackgroundTransparency = 1
SpeedTextLabel.Text = "вљЎ Farm Speed: " .. farmSpeed
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
SpeedInput.BackgroundColor3 = Color3.fromRGB(41, 205, 255)
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
InputStroke.Color = Color3.fromRGB(2, 15, 255)
InputStroke.Thickness = 1
InputStroke.Transparency = 0.3
InputStroke.Parent = SpeedInput


SpeedInput.FocusLost:Connect(function(enterPressed)
	if enterPressed then
		local newSpeed = tonumber(SpeedInput.Text)
		if newSpeed and newSpeed >= 5 and newSpeed <= 100 then
			farmSpeed = newSpeed
			SpeedTextLabel.Text = "вљЎ Farm Speed: " .. farmSpeed
			print("РЎРєРѕСЂРѕСЃС‚СЊ AutoFarm РёР·РјРµРЅРµРЅР° РЅР°: " .. farmSpeed)

			SpeedInput.BackgroundColor3 = Color3.fromRGB(0, 200, 100)
			wait(0.3)
			SpeedInput.BackgroundColor3 = Color3.fromRGB(41, 205, 255)
		else
			SpeedInput.Text = tostring(farmSpeed)
			SpeedInput.BackgroundColor3 = Color3.fromRGB(255, 100, 100)
			print("РћС€РёР±РєР°! РЎРєРѕСЂРѕСЃС‚СЊ РґРѕР»Р¶РЅР° Р±С‹С‚СЊ РѕС‚ 5 РґРѕ 100")
			wait(0.3)
			SpeedInput.BackgroundColor3 = Color3.fromRGB(41, 205, 255)
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
TimeCounter.BackgroundColor3 = Color3.fromRGB(2, 31, 126)
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
TimeStroke.Color = Color3.fromRGB(2, 14, 222)
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

print("вњ… GUI СЃРѕР·РґР°РЅР° СѓСЃРїРµС€РЅРѕ!")
print("РљРѕР»РёС‡РµСЃС‚РІРѕ РїРµСЂРµРєР»СЋС‡Р°С‚РµР»РµР№: " .. #toggleList)
print("Р’СЃРµ РєРЅРѕРїРєРё РІС‹РєР»СЋС‡РµРЅС‹ РїРѕ СѓРјРѕР»С‡Р°РЅРёСЋ")
print("РќР°Р¶РјРё РЅР° СЃРЅРµР¶РёРЅРєСѓ вќ„пёЏ С‡С‚РѕР±С‹ РѕС‚РєСЂС‹С‚СЊ/Р·Р°РєСЂС‹С‚СЊ GUI")
print("AutoFarm РіРѕС‚РѕРІ Рє СЂР°Р±РѕС‚Рµ!")


coroutine.wrap(function()
	while true do
		if autoFarmEnabled and farming then
			print("рџ”Ќ AutoFarm РёС‰РµС‚ РјРѕРЅРµС‚С‹... farming=" .. tostring(farming))
		end
		wait(5)
	end
end)()
