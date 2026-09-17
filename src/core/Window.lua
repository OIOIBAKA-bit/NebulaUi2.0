--!strict

local Window = {}
Window.__index = Window

local Core = script.Parent
local Drag = require(Core:WaitForChild("Drag"))
local Theme = require(Core:WaitForChild("Theme"))
local Tabs = require(Core:WaitForChild("Tabs"))
local Resize = require(Core:WaitForChild("Resize"))

local Players = game:GetService("Players")
local PlayerGui = Players.LocalPlayer:WaitForChild("PlayerGui")

function Window.new(titleText: string)
    local self = setmetatable({}, Window)

    self.ScreenGui = Instance.new("ScreenGui")
    self.ScreenGui.Name = "ObsidianLibrary"
    self.ScreenGui.ResetOnSpawn = false
    self.ScreenGui.Parent = PlayerGui

    self.MainFrame = Instance.new("Frame")
    self.MainFrame.Size = UDim2.new(0, 600, 0, 400)
    self.MainFrame.Position = UDim2.new(0.5, -300, 0.5, -200)
    self.MainFrame.BackgroundColor3 = Theme.Get("Background")
    self.MainFrame.BorderSizePixel = 0
    self.MainFrame.Parent = self.ScreenGui

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = self.MainFrame

    local stroke = Instance.new("UIStroke")
    stroke.Color = Theme.Get("Outline")
    stroke.Thickness = 1
    stroke.Parent = self.MainFrame

    local topBar = Instance.new("Frame")
    topBar.Size = UDim2.new(1, 0, 0, 36)
    topBar.BackgroundColor3 = Theme.Get("Sidebar")
    topBar.BorderSizePixel = 0
    topBar.Parent = self.MainFrame

    local topCorner = Instance.new("UICorner")
    topCorner.CornerRadius = UDim.new(0, 8)
    topCorner.Parent = topBar

    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, -20, 1, 0)
    title.Position = UDim2.new(0, 12, 0, 0)
    title.BackgroundTransparency = 1
    title.Font = Enum.Font.GothamBold
    title.Text = titleText
    title.TextColor3 = Theme.Get("Text")
    title.TextSize = 13
    title.TextXAlignment = Enum.TextXAlignment.Left
    title.Parent = topBar

    self.Sidebar = Instance.new("ScrollingFrame")
    self.Sidebar.Size = UDim2.new(0, 140, 1, -44)
    self.Sidebar.Position = UDim2.new(0, 4, 0, 40)
    self.Sidebar.BackgroundTransparency = 1
    self.Sidebar.BorderSizePixel = 0
    self.Sidebar.ScrollBarThickness = 0
    self.Sidebar.CanvasSize = UDim2.new(0, 0, 0, 0)
    self.Sidebar.Parent = self.MainFrame

    local sidebarLayout = Instance.new("UIListLayout")
    sidebarLayout.SortOrder = Enum.SortOrder.LayoutOrder
    sidebarLayout.Padding = UDim.new(0, 4)
    sidebarLayout.Parent = self.Sidebar

    sidebarLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        self.Sidebar.CanvasSize = UDim2.new(0, 0, 0, sidebarLayout.AbsoluteContentSize.Y)
    end)

    self.ContainerHolder = Instance.new("Frame")
    self.ContainerHolder.Size = UDim2.new(1, -152, 1, -44)
    self.ContainerHolder.Position = UDim2.new(0, 148, 0, 40)
    self.ContainerHolder.BackgroundTransparency = 1
    self.ContainerHolder.BorderSizePixel = 0
    self.ContainerHolder.Parent = self.MainFrame

    self.TabList = {}
    
    Drag.Enable(self.MainFrame, topBar)
    Resize.Enable(self.MainFrame, Vector2.new(450, 300))

    return self
end

function Window:AddTab(tabName: string)
    local isFirst = #self.TabList == 0
    local tabObj = Tabs.new(self.ContainerHolder, self.Sidebar, tabName, isFirst, self.TabList)
    table.insert(self.TabList, tabObj)
    return tabObj
end

return Window
