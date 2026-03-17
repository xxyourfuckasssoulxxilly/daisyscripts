-- Delta Executor Bomb & Nuke Throw Script (Visual Only)
-- Create GUI with bomb and nuke buttons

-- Load necessary services
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local Debris = game:GetService("Debris")
local Lighting = game:GetService("Lighting")
local LocalPlayer = Players.LocalPlayer

-- Wait for player character
local function waitForCharacter()
    while not LocalPlayer.Character do
        wait(0.1)
    end
    return LocalPlayer.Character
end

-- Create the main GUI
local function createGUI()
    -- Create ScreenGui
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "BombNukeGUI"
    screenGui.ResetOnSpawn = false
    screenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
    
    -- Create main frame
    local mainFrame = Instance.new("Frame")
    mainFrame.Name = "MainFrame"
    mainFrame.Size = UDim2.new(0, 220, 0, 160)
    mainFrame.Position = UDim2.new(0.5, -110, 0.9, -80)
    mainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    mainFrame.BackgroundTransparency = 0.2
    mainFrame.BorderSizePixel = 0
    mainFrame.Active = true
    mainFrame.Draggable = true
    mainFrame.Parent = screenGui
    
    -- Add corner rounding
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 10)
    corner.Parent = mainFrame
    
    -- Add title bar
    local titleBar = Instance.new("Frame")
    titleBar.Name = "TitleBar"
    titleBar.Size = UDim2.new(1, 0, 0, 30)
    titleBar.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    titleBar.BorderSizePixel = 0
    titleBar.Parent = mainFrame
    
    local titleCorner = Instance.new("UICorner")
    titleCorner.CornerRadius = UDim.new(0, 10)
    titleCorner.Parent = titleBar
    
    local titleText = Instance.new("TextLabel")
    titleText.Name = "TitleText"
    titleText.Size = UDim2.new(1, 0, 1, 0)
    titleText.BackgroundTransparency = 1
    titleText.Text = "💣 WEAPONS OF MASS DESTRUCTION 💣"
    titleText.TextColor3 = Color3.fromRGB(255, 100, 100)
    titleText.TextScaled = true
    titleText.Font = Enum.Font.GothamBold
    titleText.Parent = titleBar
    
    -- Create bomb button
    local bombButton = Instance.new("TextButton")
    bombButton.Name = "BombButton"
    bombButton.Size = UDim2.new(0.8, 0, 0.25, 0)
    bombButton.Position = UDim2.new(0.1, 0, 0.3, 0)
    bombButton.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
    bombButton.Text = "💣 THROW BOMB 💣"
    bombButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    bombButton.TextScaled = true
    bombButton.Font = Enum.Font.GothamBold
    bombButton.Parent = mainFrame
    
    local buttonCorner = Instance.new("UICorner")
    buttonCorner.CornerRadius = UDim.new(0, 8)
    buttonCorner.Parent = bombButton
    
    -- Create nuke button
    local nukeButton = Instance.new("TextButton")
    nukeButton.Name = "NukeButton"
    nukeButton.Size = UDim2.new(0.8, 0, 0.25, 0)
    nukeButton.Position = UDim2.new(0.1, 0, 0.6, 0)
    nukeButton.BackgroundColor3 = Color3.fromRGB(150, 0, 255)
    nukeButton.Text = "☢️ NUKE FROM SKY ☢️"
    nukeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    nukeButton.TextScaled = true
    nukeButton.Font = Enum.Font.GothamBold
    nukeButton.Parent = mainFrame
    
    local nukeCorner = Instance.new("UICorner")
    nukeCorner.CornerRadius = UDim.new(0, 8)
    nukeCorner.Parent = nukeButton
    
    return bombButton, nukeButton
end

-- Function to create explosion effect
local function createExplosion(position, isNuke)
    local scale = isNuke and 3 or 1
    
    -- Create explosion part
    local explosion = Instance.new("Part")
    explosion.Name = isNuke and "NukeExplosion" or "BombExplosion"
    explosion.Anchored = true
    explosion.CanCollide = false
    explosion.Transparency = 1
    explosion.Size = Vector3.new(1, 1, 1)
    explosion.Position = position
    explosion.Parent = workspace
    
    -- Create explosion visual effects
    
    -- 1. Fire effect (bigger for nuke)
    local fire = Instance.new("Fire")
    fire.Size = isNuke and 40 or 15
    fire.Heat = isNuke and 50 or 25
    fire.Parent = explosion
    
    -- 2. Particle emitter
    local particles = Instance.new("ParticleEmitter")
    particles.Texture = "rbxasset://textures/particles/sparkles_main.dds"
    particles.Rate = isNuke and 500 or 200
    particles.Lifetime = NumberRange.new(isNuke and 2 or 1, isNuke and 4 or 2)
    particles.SpreadAngle = Vector2.new(360, 360)
    particles.Speed = NumberRange.new(isNuke and 30 or 10, isNuke and 50 or 20)
    particles.VelocityInheritance = 0
    particles.Acceleration = Vector3.new(0, 10, 0)
    particles.Drag = 5
    particles.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, isNuke and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(255, 200, 50)),
        ColorSequenceKeypoint.new(0.3, Color3.fromRGB(255, 200, 50)),
        ColorSequenceKeypoint.new(0.6, Color3.fromRGB(255, 100, 0)),
        ColorSequenceKeypoint.new(1, isNuke and Color3.fromRGB(200, 200, 200) or Color3.fromRGB(100, 100, 100))
    })
    particles.Size = NumberSequence.new({
        NumberSequenceKeypoint.new(0, isNuke and 15 or 5),
        NumberSequenceKeypoint.new(0.5, isNuke and 30 or 10),
        NumberSequenceKeypoint.new(1, 0)
    })
    particles.Parent = explosion
    
    -- 3. Light effect
    local light = Instance.new("PointLight")
    light.Brightness = isNuke and 10 or 5
    light.Range = isNuke and 100 or 30
    light.Color = isNuke and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(255, 150, 0)
    light.Parent = explosion
    
    -- 4. Shockwave ring
    local ring = Instance.new("Part")
    ring.Name = "Shockwave"
    ring.Anchored = true
    ring.CanCollide = false
    ring.Transparency = 0.7
    ring.Size = Vector3.new(1, 0.1, 1)
    ring.BrickColor = isNuke and BrickColor.new("Bright yellow") or BrickColor.new("Really red")
    ring.Material = Enum.Material.Neon
    ring.Position = position
    ring.Parent = workspace
    
    local ringMesh = Instance.new("CylinderMesh")
    ringMesh.Parent = ring
    
    -- Animate shockwave
    local ringTweenInfo = TweenInfo.new(
        isNuke and 1.5 or 0.5,
        Enum.EasingStyle.Quad,
        Enum.EasingDirection.Out,
        0,
        false,
        0
    )
    
    local ringGoal = {
        Size = Vector3.new(isNuke and 100 or 30, 0.1, isNuke and 100 or 30),
        Transparency = 1
    }
    
    local ringTween = TweenService:Create(ring, ringTweenInfo, ringGoal)
    ringTween:Play()
    
    -- Animate explosion size
    local explosionTweenInfo = TweenInfo.new(
        isNuke and 2 or 0.8,
        Enum.EasingStyle.Quad,
        Enum.EasingDirection.Out,
        0,
        false,
        0
    )
    
    local explosionGoal = {
        Size = Vector3.new(isNuke and 60 or 20, isNuke and 60 or 20, isNuke and 60 or 20),
        Transparency = 1
    }
    
    local explosionTween = TweenService:Create(explosion, explosionTweenInfo, explosionGoal)
    explosionTween:Play()
    
    -- Clean up explosion parts after animation
    explosionTween.Completed:Connect(function()
        explosion:Destroy()
        ring:Destroy()
    end)
    
    -- Camera shake effect (more intense for nuke)
    local camera = workspace.CurrentCamera
    local originalCF = camera.CFrame
    
    local shakeIntensity = isNuke and 5 or 2
    local shakeDuration = isNuke and 1 or 0.3
    local startTime = tick()
    
    -- Shake loop
    local connection
    connection = RunService.RenderStepped:Connect(function()
        local elapsed = tick() - startTime
        if elapsed < shakeDuration then
            local shake = Vector3.new(
                math.random(-shakeIntensity * 10, shakeIntensity * 10) / 10,
                math.random(-shakeIntensity * 10, shakeIntensity * 10) / 10,
                math.random(-shakeIntensity * 10, shakeIntensity * 10) / 10
            )
            camera.CFrame = originalCF * CFrame.new(shake)
        else
            camera.CFrame = originalCF
            connection:Disconnect()
        end
    end)
    
    -- Flash effect for nuke
    if isNuke then
        local flash = Instance.new("Part")
        flash.Anchored = true
        flash.CanCollide = false
        flash.Transparency = 0
        flash.BrickColor = BrickColor.new("White")
        flash.Material = Enum.Material.Neon
        flash.Size = Vector3.new(200, 200, 200)
        flash.CFrame = CFrame.new(position + Vector3.new(0, 50, 0))
        flash.Parent = workspace
        
        local flashTween = TweenService:Create(flash, TweenInfo.new(0.5), {Transparency = 1})
        flashTween:Play()
        flashTween.Completed:Connect(function()
            flash:Destroy()
        end)
        
        -- Create mushroom cloud effect
        local cloud = Instance.new("Part")
        cloud.Anchored = true
        cloud.CanCollide = false
        cloud.Transparency = 0.3
        cloud.BrickColor = BrickColor.new("Dark gray")
        cloud.Size = Vector3.new(30, 30, 30)
        cloud.CFrame = CFrame.new(position + Vector3.new(0, 40, 0))
        cloud.Parent = workspace
        
        local cloudTween = TweenService:Create(cloud, TweenInfo.new(3), {
            Size = Vector3.new(100, 100, 100),
            Transparency = 1
        })
        cloudTween:Play()
        cloudTween.Completed:Connect(function()
            cloud:Destroy()
        end)
    end
end

-- Function to throw bomb
local function throwBomb()
    local character = LocalPlayer.Character
    if not character then return end
    
    local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
    if not humanoidRootPart then return end
    
    -- Get throw direction (where player is looking)
    local camera = workspace.CurrentCamera
    local lookDirection = camera.CFrame.LookVector
    local throwPosition = humanoidRootPart.Position + Vector3.new(0, 3, 0) + (lookDirection * 2)
    
    -- Create bomb projectile
    local bomb = Instance.new("Part")
    bomb.Name = "Bomb"
    bomb.Size = Vector3.new(1, 1, 1)
    bomb.BrickColor = BrickColor.new("Really black")
    bomb.Material = Enum.Material.SmoothPlastic
    bomb.CanCollide = true
    bomb.Position = throwPosition
    bomb.Parent = workspace
    
    -- Add bomb handle/effect
    local handleEffect = Instance.new("SelectionBox")
    handleEffect.Color3 = Color3.fromRGB(255, 0, 0)
    handleEffect.LineThickness = 0.1
    handleEffect.Transparency = 0.5
    handleEffect.Adornee = bomb
    handleEffect.Parent = bomb
    
    local fireEffect = Instance.new("Fire")
    fireEffect.Size = 2
    fireEffect.Heat = 5
    fireEffect.Parent = bomb
    
    -- Throw the bomb with velocity
    local bodyVelocity = Instance.new("BodyVelocity")
    bodyVelocity.MaxForce = Vector3.new(4000, 4000, 4000)
    bodyVelocity.Velocity = lookDirection * 50 + Vector3.new(0, 20, 0)
    bodyVelocity.Parent = bomb
    
    -- Add some rotation
    local bodyGyro = Instance.new("BodyGyro")
    bodyGyro.MaxTorque = Vector3.new(4000, 4000, 4000)
    bodyGyro.CFrame = CFrame.new(bomb.Position) * CFrame.Angles(math.random(), math.random(), math.random())
    bodyGyro.Parent = bomb
    
    -- Explode after 1.5 seconds
    task.wait(1.5)
    
    if bomb and bomb.Parent then
        local explosionPosition = bomb.Position
        bomb:Destroy()
        createExplosion(explosionPosition, false)
    end
end

-- Function to drop nuke from sky
local function dropNuke()
    local character = LocalPlayer.Character
    if not character then return end
    
    local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
    if not humanoidRootPart then return end
    
    -- Get target position (where player is looking)
    local camera = workspace.CurrentCamera
    local lookDirection = camera.CFrame.LookVector
    local targetPosition = humanoidRootPart.Position + (lookDirection * 50)
    
    -- Create nuke at high altitude
    local nuke = Instance.new("Part")
    nuke.Name = "Nuke"
    nuke.Size = Vector3.new(5, 10, 5)
    nuke.BrickColor = BrickColor.new("Bright yellow")
    nuke.Material = Enum.Material.Metal
    nuke.CanCollide = true
    nuke.Position = targetPosition + Vector3.new(0, 200, 0) -- Drop from sky
    nuke.Parent = workspace
    
    -- Add nuke effects
    local selectionBox = Instance.new("SelectionBox")
    selectionBox.Color3 = Color3.fromRGB(255, 0, 0)
    selectionBox.LineThickness = 0.2
    selectionBox.Transparency = 0.3
    selectionBox.Adornee = nuke
    selectionBox.Parent = nuke
    
    -- Trail effect
    local trail = Instance.new("Trail")
    trail.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 0)),
        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 255, 0)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255))
    })
    trail.Lifetime = 2
    trail.WidthScale = NumberSequence.new({
        NumberSequenceKeypoint.new(0, 5),
        NumberSequenceKeypoint.new(1, 0)
    })
    trail.Transparency = NumberSequence.new(0.5)
    trail.Parent = nuke
    
    local attachment = Instance.new("Attachment")
    attachment.Position = Vector3.new(0, 5, 0)
    attachment.Parent = nuke
    
    local attachment2 = Instance.new("Attachment")
    attachment2.Position = Vector3.new(0, -5, 0)
    attachment2.Parent = nuke
    
    trail.Attachment0 = attachment
    trail.Attachment1 = attachment2
    
    -- Falling velocity
    local bodyVelocity = Instance.new("BodyVelocity")
    bodyVelocity.MaxForce = Vector3.new(4000, 4000, 4000)
    bodyVelocity.Velocity = Vector3.new(0, -100, 0)
    bodyVelocity.Parent = nuke
    
    -- Rotation
    local bodyGyro = Instance.new("BodyGyro")
    bodyGyro.MaxTorque = Vector3.new(4000, 4000, 4000)
    bodyGyro.CFrame = CFrame.new(nuke.Position) * CFrame.Angles(0, 0, 0)
    bodyGyro.Parent = nuke
    
    -- Siren sound effect (if game has sounds)
    pcall(function()
        local sound = Instance.new("Sound")
        sound.SoundId = "rbxasset://sounds/siren.wav"
        sound.Volume = 5
        sound.Looped = true
        sound.Parent = nuke
        sound:Play()
    end)
    
    -- Wait for nuke to hit ground or timeout
    local startTime = tick()
    local connection
    
    connection = RunService.Heartbeat:Connect(function()
        if not nuke or not nuke.Parent then
            if connection then connection:Disconnect() end
            return
        end
        
        -- Check if nuke hit something
        local ray = Ray.new(nuke.Position, Vector3.new(0, -10, 0))
        local hit, position = workspace:FindPartOnRay(ray, nuke)
        
        if hit or (tick() - startTime > 5) then
            connection:Disconnect()
            
            if nuke and nuke.Parent then
                local explosionPosition = nuke.Position
                nuke:Destroy()
                createExplosion(explosionPosition, true)
            end
        end
    end)
    
    -- Auto-explode after 5 seconds
    task.wait(5)
    
    if nuke and nuke.Parent then
        connection:Disconnect()
        local explosionPosition = nuke.Position
        nuke:Destroy()
        createExplosion(explosionPosition, true)
    end
end

-- Initialize
local function initialize()
    -- Wait for player character
    waitForCharacter()
    
    -- Create GUI and get buttons
    local bombButton, nukeButton = createGUI()
    
    -- Connect bomb button click
    bombButton.MouseButton1Click:Connect(function()
        throwBomb()
    end)
    
    -- Connect nuke button click
    nukeButton.MouseButton1Click:Connect(function()
        dropNuke()
    end)
    
    -- Optional: Keybinds (Press B for bomb, N for nuke)
    UserInputService.InputBegan:Connect(function(input, gameProcessed)
        if gameProcessed then return end
        
        if input.KeyCode == Enum.KeyCode.B then
            throwBomb()
        elseif input.KeyCode == Enum.KeyCode.N then
            dropNuke()
        end
    end)
    
    print("Bomb & Nuke Thrower GUI loaded! Click buttons or press 'B' for bomb, 'N' for nuke!")
end

-- Run the script
local success, err = pcall(initialize)
if not success then
    warn("Error loading Bomb/Nuke Thrower: " .. tostring(err))
end
