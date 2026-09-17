--!strict

local Utility = {}

function Utility.Create(className: string, properties: {[string]: any}, children: {Instance}?): Instance
    local instance = Instance.new(className)
    
    for k, v in pairs(properties) do
        (instance :: any)[k] = v
    end
    
    if children then
        for _, child in ipairs(children) do
            child.Parent = instance
        end
    end
    
    return instance
end

return Utility
