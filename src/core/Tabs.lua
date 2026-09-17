--!strict

local Tabs = {}
Tabs.__index = Tabs

local Core = script.Parent
local Groupbox = require(Core:WaitForChild("Groupbox"))

function Tabs.new(parentContainer, sidebarContainer, tabName, isFirst, tabList)
    local self = setmetatable({}, Tabs)

    self.Button = Instance.new("TextButton")
    self.Button.Size = UDim2.new(1, 0, 0, 30)
    self.Button.BackgroundColor3 = isFirst and Color3.fromRGB(24, 24, 24) or Color3.fromRGB(16, 16, 16)
    self.Button.BorderSizePixel = 0
    self.Button.Font = Enum.Font.GothamMedium
    self.Button.Text = "  " .. tabName
    self.Button.TextColor3 = isFirst and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(140, 140, 140)
    self.Button.TextSize = 12
    self.Button.TextXAlignment = Enum.TextXAlignment.Left
    self.Button.Parent = sidebarContainer

    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 6)
    btnCorner.Parent = self.Button

    self.Container = Instance.new("ScrollingFrame")
    self.Container.Size = UDim2.new(1, -8, 1, -8)
    self.Container.Position = UDim2.new(0, 4, 0, 4)
    self.Container.BackgroundTransparency = 1
    self.Container.BorderSizePixel = 0
    self.Container.ScrollBarThickness = 3
    self.Container.CanvasSize = UDim2.new(0, 0, 0, 0)
    self.Container.Visible = isFirst
    self.Container.Parent = parentContainer

    local layout = Instance.new("UIListLayout")
    layout.SortOrder = Enum.SortOrder.LayoutOrder
    layout.Padding = UDim.new(0, 8)
    layout.Parent = self.Container

    layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        self.Container.CanvasSize = UDim2.new(0, 0, 0, layout.AbsoluteContentSize.Y + 10)
    end)

    self.Button.MouseButton1Click:Connect(function()
        for _, tab in ipairs(tabList) do
            tab.Button.BackgroundColor3 = Color3.fromRGB(16, 16, 16)
            tab.Button.TextColor3 = Color3.fromRGB(140, 140, 140)
            tab.Container.Visible = false
        end
        self.Button.BackgroundColor3 = Color3.fromRGB(24, 24, 24)
        self.Button.TextColor3 = Color3.fromRGB(255, 255, 255)
        self.Container.Visible = true
    end)

    return self
end

function Tabs:AddGroupbox(titleText: string)
    return Groupbox.new(self.Container, titleText)
end

return Tabs
