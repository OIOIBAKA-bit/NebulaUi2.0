--!strict

local Library = {}
Library.__index = Library

local Core = script:WaitForChild("Core")
local Window = require(Core:WaitForChild("Window"))
local Theme = require(Core:WaitForChild("Theme"))
local Icons = require(Core:WaitForChild("Icons"))

type WindowOptions = {
    Title: string?,
}

function Library.CreateWindow(options: WindowOptions?)
    options = options or {}
    return Window.new(options.Title or "Obsidian UI")
end

function Library.SetTheme(themeName: string)
    Theme.SetTheme(themeName)
end

function Library.GetIcon(iconName: string): string
    return Icons.Get(iconName)
end

return Library
