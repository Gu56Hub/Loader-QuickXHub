if not game:IsLoaded() then game.Loaded:Wait() end

if getgenv().__UniLoader then return end
getgenv().__UniLoader = true

local StarterGui = game:GetService("StarterGui")
local Players = game:GetService("Players")

local HUB_NAME = "QuickX Hub"
local ICON = "rbxassetid://132029940467197"

local Scripts = {
    [994732206] = {
        name = "Blox Fruits",
        url = "https://api.jnkie.com/api/v1/luascripts/public/f18c840b16d4e6cc9f6dac7b550f0b9fc6700fd6697310975eb6d93ab5d8b7ea/download",
    },

    [3756501373] = {
        name = "MeMe Sea",
        kaitun_url = nil, -- ใส่ URL Kaitun ตรงนี้
    },
}

local function notify(title, text, duration)
    pcall(function()
        StarterGui:SetCore("SendNotification", {
            Title = title,
            Text = text,
            Icon = ICON,
            Duration = duration or 5,
        })
    end)
end

local entry = Scripts[game.GameId]

if not entry then
    getgenv().__UniLoader = nil
    Players.LocalPlayer:Kick("Map Not Supported")
    return
end

local url
local mode

if entry.name == "MeMe Sea" then
    if getgenv().Script_Mode == "kaitun_Script" then
        url = entry.kaitun_url
        mode = "Kaitun"
    else
        getgenv().__UniLoader = nil
        warn("[" .. HUB_NAME .. "] MeMe Sea supports Kaitun only")
        return
    end
else
    url = entry.url
    mode = "Normal"
end

if not url then
    getgenv().__UniLoader = nil
    warn("[" .. HUB_NAME .. "] URL is not configured")
    return
end

local ok, err = pcall(function()
    loadstring(game:HttpGet(url))()
end)

if ok then
    notify(HUB_NAME, entry.name .. " " .. mode .. " loaded!")
else
    getgenv().__UniLoader = nil
    warn("[" .. HUB_NAME .. "] " .. tostring(err))
end
