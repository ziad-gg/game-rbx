-- Compiled with roblox-ts v2.1.0
local function getChild(childName)
	return game.Workspace:FindFirstChild(childName)
end
return {
	getChild = getChild,
}
