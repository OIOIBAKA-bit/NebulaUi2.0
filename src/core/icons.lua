--!strict

local Icons = {}

local Registry = {
    home = "rbxassetid://10723434674",
    settings = "rbxassetid://10734950309",
    user = "rbxassetid://10734953444",
}

function Icons.Get(name: string): string
    return Registry[name] or Registry.home
end

return Icons
