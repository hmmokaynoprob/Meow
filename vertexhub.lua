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

    print("hello my nigger friend")
   
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
