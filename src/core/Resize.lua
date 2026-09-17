--!strict

local UserInputService = game:GetService("UserInputService")
local Resize = {}

function Resize.Enable(targetFrame: Frame, minSize: Vector2)
    local resizing = false
    local startSize = Vector2.new()
    local startMousePos = Vector2.new()

    local handle = Instance.new("TextButton")
    handle.Size = UDim2.new(0, 16, 0, 16)
    handle.Position = UDim2.new(1, -16, 1, -16)
    handle.BackgroundTransparency = 1
    handle.Text = ""
    handle.Parent = targetFrame

    handle.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            resizing = true
            startSize = targetFrame.AbsoluteSize
            startMousePos = Vector2.new(input.Position.X, input.Position.Y)

            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    resizing = false
                end
            end)
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if resizing and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            local currentMousePos = Vector2.new(input.Position.X, input.Position.Y)
            local delta = currentMousePos - startMousePos
            
            local newWidth = math.max(minSize.X, startSize.X + delta.X)
            local newHeight = math.max(minSize.Y, startSize.Y + delta.Y)

            targetFrame.Size = UDim2.new(0, newWidth, 0, newHeight)
        end
    end)
end

return Resize
