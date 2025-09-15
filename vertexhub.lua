-- Vertex Hub Premium Script
-- This is your main script that users will execute

-- Check if key was provided by the Discord bot
if not _G.VertexHubKey then
    game.StarterGui:SetCore("ChatMakeSystemMessage", {
        Text = "[Vertex Hub] No authentication key provided!";
        Color = Color3.fromRGB(255, 0, 0);
        Font = Enum.Font.GothamBold;
        FontSize = Enum.FontSize.Size18;
    })
    return
end

local userKey = _G.VertexHubKey
local httpService = game:GetService("HttpService")

-- Configuration
local CONFIG = {
    webhookUrl = "https://discord.com/api/webhooks/1417236521492418610/3HgRmLCFhmfbMbmPJbFvtfpjQXmihX1K1lCqWk0Ho2iATef4hvGj0Be8WAhci9X8U_8u", -- Optional: for logging
    scriptName = "Vertex Hub",
    version = "1.0.0"
}

-- Get user's HWID (Hardware ID)
local function getHWID()
    local hwid = game:GetService("RbxAnalyticsService"):GetClientId()
    return hwid
end

-- Get user's Roblox ID
local function getUserId()
    return game.Players.LocalPlayer.UserId
end

-- Send notification to user
local function notify(title, text, duration)
    game.StarterGui:SetCore("SendNotification", {
        Title = title;
        Text = text;
        Duration = duration or 5;
    })
end

-- Authentication function
local function authenticate()
    local userHWID = getHWID()
    local userId = getUserId()
    
    notify("Vertex Hub", "Authenticating...", 3)
    
    -- Here you would typically make an HTTP request to your authentication server
    -- For now, we'll just simulate authentication
    
    local authData = {
        key = userKey,
        hwid = userHWID,
        userId = userId,
        timestamp = os.time()
    }
    
    -- You could send this to your server for verification
    -- Example: httpService:PostAsync("https://yourserver.com/auth", httpService:JSONEncode(authData))
    
    -- For demonstration, we'll assume authentication passed
    print("[Vertex Hub] Authentication successful!")
    notify("Vertex Hub", "Authentication successful! Loading script...", 3)
    
    return true
end

-- Main script loading function
local function loadVertexHub()
    notify("Vertex Hub", "Loading premium features...", 2)
    
    -- Your actual script content goes here
    print("[Vertex Hub] Premium script loaded!")
    
    -- Example premium features
    local gui = Instance.new("ScreenGui")
    gui.Name = "VertexHub"
    gui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
    
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 300, 0, 200)
    frame.Position = UDim2.new(0.5, -150, 0.5, -100)
    frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    frame.BorderSizePixel = 0
    frame.Parent = gui
    
    -- Add rounded corners
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 12)
    corner.Parent = frame
    
    -- Title
    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, 0, 0, 50)
    title.Position = UDim2.new(0, 0, 0, 0)
    title.BackgroundTransparency = 1
    title.Text = "Vertex Hub Premium"
    title.TextColor3 = Color3.fromRGB(255, 215, 0)
    title.TextScaled = true
    title.Font = Enum.Font.GothamBold
    title.Parent = frame
    
    -- Status
    local status = Instance.new("TextLabel")
    status.Size = UDim2.new(1, -20, 0, 30)
    status.Position = UDim2.new(0, 10, 0, 60)
    status.BackgroundTransparency = 1
    status.Text = "✅ Authenticated with key: " .. string.sub(userKey, 1, 8) .. "..."
    status.TextColor3 = Color3.fromRGB(87, 242, 135)
    status.TextScaled = true
    status.Font = Enum.Font.Gotham
    status.Parent = frame
    
    -- HWID Info
    local hwidInfo = Instance.new("TextLabel")
    hwidInfo.Size = UDim2.new(1, -20, 0, 30)
    hwidInfo.Position = UDim2.new(0, 10, 0, 100)
    hwidInfo.BackgroundTransparency = 1
    hwidInfo.Text = "🔒 HWID: " .. string.sub(getHWID(), 1, 12) .. "..."
    hwidInfo.TextColor3 = Color3.fromRGB(200, 200, 200)
    hwidInfo.TextScaled = true
    hwidInfo.Font = Enum.Font.Gotham
    hwidInfo.Parent = frame
    
    -- Close button
    local closeBtn = Instance.new("TextButton")
    closeBtn.Size = UDim2.new(0, 80, 0, 30)
    closeBtn.Position = UDim2.new(0.5, -40, 1, -40)
    closeBtn.BackgroundColor3 = Color3.fromRGB(220, 53, 69)
    closeBtn.Text = "Close"
    closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    closeBtn.TextScaled = true
    closeBtn.Font = Enum.Font.GothamBold
    closeBtn.Parent = frame
    
    local closeBtnCorner = Instance.new("UICorner")
    closeBtnCorner.CornerRadius = UDim.new(0, 6)
    closeBtnCorner.Parent = closeBtn
    
    closeBtn.MouseButton1Click:Connect(function()
        gui:Destroy()
    })
    
    -- Auto-close after 10 seconds
    game:GetService("Debris"):AddItem(gui, 10)
    
    notify("Vertex Hub", "Premium features loaded! Enjoy!", 5)
    
    -- Here you would add your actual script features
    -- Examples:
    -- loadstring(game:HttpGet("https://your-actual-script-url.com/features.lua"))()
    -- or include your script features directly here
    
    print("[Vertex Hub] All premium features initialized!")
end

-- Enhanced authentication with server verification (optional)
local function authenticateWithServer()
    local userHWID = getHWID()
    local userId = getUserId()
    
    local authPayload = {
        key = userKey,
        hwid = userHWID,
        roblox_id = userId,
        game_id = game.PlaceId,
        timestamp = os.time()
    }
    
    -- If you have a backend server for verification
    --[[
    local success, response = pcall(function()
        return httpService:PostAsync(
            "https://your-auth-server.com/verify", 
            httpService:JSONEncode(authPayload),
            Enum.HttpContentType.ApplicationJson
        )
    end)
    
    if success then
        local responseData = httpService:JSONDecode(response)
        if responseData.success then
            return true
        else
            notify("Vertex Hub", "Authentication failed: " .. (responseData.error or "Invalid key"), 5)
            return false
        end
    else
        notify("Vertex Hub", "Cannot connect to authentication server", 5)
        return false
    end
    --]]
    
    -- For now, just return true (simulate successful auth)
    return true
end

-- Main execution
local function main()
    -- Clear any existing instances
    local existingGui = game.Players.LocalPlayer.PlayerGui:FindFirstChild("VertexHub")
    if existingGui then
        existingGui:Destroy()
    end
    
    -- Authenticate user
    if authenticate() then
        wait(1) -- Small delay for better UX
        loadVertexHub()
    else
        notify("Vertex Hub", "Authentication failed! Invalid key or HWID.", 5)
        return
    end
end

-- Execute main function
main()
