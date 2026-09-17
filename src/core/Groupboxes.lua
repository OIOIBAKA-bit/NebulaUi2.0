--!strict

local Groupbox = {}
Groupbox.__index = Groupbox

type GroupboxInstance = typeof(setmetatable({} :: {
    Container: Frame,
    MainFrame: Frame,
}, Groupbox))

function Groupbox.new(parentTab: ScrollingFrame, titleText: string): GroupboxInstance
    local self = setmetatable({}, Groupbox)

    self.MainFrame = Instance.new("Frame")
    self.MainFrame.Size = UDim2.new(1, 0, 0, 150)
    self.MainFrame.BackgroundColor3 = Color3.fromRGB(16, 16, 16)
    self.MainFrame.BorderSizePixel = 0
    self.MainFrame.Parent = parentTab

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 6)
    corner.Parent = self.MainFrame

    local stroke = Instance.new("UIStroke")
    stroke.Color = Color3.fromRGB(35, 35, 35)
    stroke.Thickness = 1
    stroke.Parent = self.MainFrame

    local header = Instance.new("TextLabel")
    header.Size = UDim2.new(1, 0, 0, 28)
    header.Position = UDim2.new(0, 10, 0, 0)
    header.BackgroundTransparency = 1
    header.Font = Enum.Font.GothamBold
    header.Text = titleText
    header.TextColor3 = Color3.fromRGB(240, 240, 240)
    header.TextSize = 12
    header.TextXAlignment = Enum.TextXAlignment.Left
    header.Parent = self.MainFrame

    self.Container = Instance.new("Frame")
    self.Container.Size = UDim2.new(1, -16, 1, -34)
    self.Container.Position = UDim2.new(0, 8, 0, 30)
    self.Container.BackgroundTransparency = 1
    self.Container.BorderSizePixel = 0
    self.Container.Parent = self.MainFrame

    local layout = Instance.new("UIListLayout")
    layout.SortOrder = Enum.SortOrder.LayoutOrder
    layout.Padding = UDim.new(0, 6)
    layout.Parent = self.Container

    layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        self.MainFrame.Size = UDim2.new(1, 0, 0, layout.AbsoluteContentSize.Y + 42)
    end)

    return self
end

function Groupbox:AddButton(text: string, callback: () -> ())
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(1, 0, 0, 30)
    button.BackgroundColor3 = Color3.fromRGB(22, 22, 22)
    button.BorderSizePixel = 0
    button.Font = Enum.Font.Gotham
    button.Text = "  " .. text
    button.TextColor3 = Color3.fromRGB(220, 220, 220)
    button.TextSize = 12
    button.TextXAlignment = Enum.TextXAlignment.Left
    button.Parent = self.Container

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 4)
    corner.Parent = button

    local stroke = Instance.new("UIStroke")
    stroke.Color = Color3.fromRGB(35, 35, 35)
    stroke.Thickness = 1
    stroke.Parent = button

    button.MouseButton1Click:Connect(function()
        pcall(callback)
    end)

    button.MouseEnter:Connect(function()
        button.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    end)

    button.MouseLeave:Connect(function()
        button.BackgroundColor3 = Color3.fromRGB(22, 22, 22)
    end)
end

return Groupbox
