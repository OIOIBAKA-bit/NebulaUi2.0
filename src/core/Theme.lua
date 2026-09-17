--!strict

local Theme = {}
local currentTheme = "Dark"

local Themes = {
    Dark = {
        Background = Color3.fromRGB(13, 13, 13),
        Sidebar = Color3.fromRGB(16, 16, 16),
        Accent = Color3.fromRGB(0, 120, 255),
        Text = Color3.fromRGB(240, 240, 240),
        SubText = Color3.fromRGB(140, 140, 140),
        Outline = Color3.fromRGB(35, 35, 35),
    }
}

function Theme.Get(key: string): Color3
    return Themes[currentTheme][key] or Color3.fromRGB(255, 255, 255)
end

function Theme.SetTheme(name: string)
    if Themes[name] then
        currentTheme = name
    end
end

return Theme
