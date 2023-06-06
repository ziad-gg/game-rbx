-- Compiled with roblox-ts v2.1.0
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local getChild = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "module").getChild
local Players = game:GetService("Players")
local List = {}
local ConnectedList = {}
local ListCollector = {}
local Lasers = getChild("Lasers")
local Bankkey = getChild("BankKey")
local MoneyKey = getChild("MoneyKey")
local Door = getChild("Door")
local Collector = getChild("Collector")
local newPosition = Vector3.new(110.5, 32.098, 38.17)
if Collector and Collector:IsA("Part") then
	Collector.Touched:Connect(function(otherPart)
		local _Humanoid = otherPart.Parent
		if _Humanoid ~= nil then
			_Humanoid = _Humanoid:FindFirstChildOfClass("Humanoid")
		end
		local Humanoid = _Humanoid
		if Humanoid and Humanoid.Parent then
			local key = Humanoid.Parent.Name
			local Player = Players:FindFirstChild(key)
			local _result = Player
			if _result ~= nil then
				_result = _result:IsA("Player")
			end
			if _result then
				local Guis = Player:WaitForChild("PlayerGui")
				local _Screen = Guis
				if _Screen ~= nil then
					_Screen = _Screen:WaitForChild("Money")
				end
				local Screen = _Screen
				local Main = Screen:WaitForChild("Main")
				local Text = Main:FindFirstChild("Money")
				local Old = ConnectedList[key]
				-- eslint-disable-next-line roblox-ts/lua-truthiness
				local _condition = Old
				if _condition ~= 0 and (_condition == _condition and _condition) then
					local _result_1 = Text
					if _result_1 ~= nil then
						_result_1 = _result_1:IsA("TextLabel")
					end
					_condition = _result_1
				end
				if _condition ~= 0 and (_condition == _condition and _condition) then
					print(Old, string.split(Text.Text, "/"))
				end
			end
		end
	end)
end
if Lasers then
	local Childs = Lasers:GetChildren()
	for _, child in Childs do
		if child:IsA("Part") then
			child.Touched:Connect(function(otherPart)
				local _Humaniod = otherPart.Parent
				if _Humaniod ~= nil then
					_Humaniod = _Humaniod:FindFirstChildOfClass("Humanoid")
				end
				local Humaniod = _Humaniod
				local _condition = Humaniod and Humaniod.Parent
				if _condition then
					local _result = Humaniod.Parent
					if _result ~= nil then
						_result = _result.Name
					end
					_condition = not (List[_result] ~= nil)
				end
				if _condition then
					local _result = Humaniod.Parent
					if _result ~= nil then
						_result = _result.Name
					end
					List[_result] = true
					Humaniod:TakeDamage(20)
					wait(0.4)
					local _result_1 = Humaniod.Parent
					if _result_1 ~= nil then
						_result_1 = _result_1.Name
					end
					List[_result_1] = nil
				end
			end)
		end
	end
end
local _condition = Bankkey and Bankkey:IsA("Part")
if _condition then
	local _result = Door
	if _result ~= nil then
		_result = _result:IsA("Model")
	end
	_condition = _result
end
if _condition then
	Bankkey.Touched:Once(function(otherPart)
		local _Humanoid = otherPart.Parent
		if _Humanoid ~= nil then
			_Humanoid = _Humanoid:FindFirstChildOfClass("Humanoid")
		end
		local Humanoid = _Humanoid
		if Humanoid and Humanoid.Parent then
			Door:PivotTo(CFrame.new(newPosition))
			local _name = Humanoid.Parent.Name
			ConnectedList[_name] = 0
		end
	end)
end
if MoneyKey and MoneyKey:IsA("Part") then
	MoneyKey.Touched:Connect(function(otherPart)
		local _Humanoid = otherPart.Parent
		if _Humanoid ~= nil then
			_Humanoid = _Humanoid:FindFirstChildOfClass("Humanoid")
		end
		local Humanoid = _Humanoid
		if Humanoid and Humanoid.Parent then
			local key = Humanoid.Parent.Name
			local Player = Players:FindFirstChild(key)
			-- eslint-disable-next-line roblox-ts/lua-truthiness
			local _condition_1 = ConnectedList[key]
			if not (_condition_1 ~= 0 and (_condition_1 == _condition_1 and _condition_1)) then
				_condition_1 = 0
			end
			local Old = _condition_1
			-- print(Old);
			local _condition_2 = typeof(Old) == "number"
			if _condition_2 then
				local _result = Player
				if _result ~= nil then
					_result = _result:IsA("Player")
				end
				_condition_2 = _result
			end
			if _condition_2 then
				local Guis = Player:WaitForChild("PlayerGui")
				local _Screen = Guis
				if _Screen ~= nil then
					_Screen = _Screen:WaitForChild("Money")
				end
				local Screen = _Screen
				local Main = Screen:WaitForChild("Main")
				local Text = Main:FindFirstChild("Money")
				local _condition_3 = Screen and Screen:IsA("ScreenGui")
				if _condition_3 then
					local _result = Text
					if _result ~= nil then
						_result = _result:IsA("TextLabel")
					end
					_condition_3 = _result
					if _condition_3 then
						_condition_3 = not (ListCollector[key] ~= nil)
					end
				end
				if _condition_3 then
					ListCollector[key] = true
					while { wait(2) } do
						if ListCollector[key] ~= nil == true and ConnectedList[key] ~= 2000 then
							-- eslint-disable-next-line roblox-ts/lua-truthiness
							local _condition_4 = ConnectedList[key]
							if not (_condition_4 ~= 0 and (_condition_4 == _condition_4 and _condition_4)) then
								_condition_4 = 0
							end
							local money = _condition_4
							Screen.Enabled = true
							if ConnectedList[key] == 2000 then
								-- ▼ Set.delete ▼
								local _valueExisted = ListCollector[key] ~= nil
								ListCollector[key] = nil
								-- ▲ Set.delete ▲
								return _valueExisted
							else
								local _arg1 = money + 25
								ConnectedList[key] = _arg1
								Text.Text = "2000" .. "/" .. tostring((if money + 50 > 2000 then 2000 else money + 50)) .. "$"
								ListCollector[key] = nil
								wait(2.4)
								ListCollector[key] = true
							end
						end
					end
				end
			end
		end
	end)
	MoneyKey.TouchEnded:Connect(function(otherPart)
		local _Humanoid = otherPart.Parent
		if _Humanoid ~= nil then
			_Humanoid = _Humanoid:FindFirstChildOfClass("Humanoid")
		end
		local Humanoid = _Humanoid
		if Humanoid and Humanoid.Parent then
			local _name = Humanoid.Parent.Name
			local Old = ConnectedList[_name]
			local _name_1 = Humanoid.Parent.Name
			ListCollector[_name_1] = nil
		end
	end)
end
Players.PlayerAdded:Connect(function(player)
	player.CharacterAdded:Connect(function(c)
		local Humaniod = c:FindFirstChildOfClass("Humanoid")
		if Humaniod then
			Humaniod.WalkSpeed = Humaniod.WalkSpeed + 20
		end
	end)
end)
