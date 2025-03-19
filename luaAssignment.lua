-- Import math, necessary for calculating max_distance
local math = require("math")

-- Function to read config file and extract values
function readConfig(filename)
	local file = io.open(filename, "r")
	if not file then
		print("Error: Config not found")
		return nil
	end

	local config_data = {}

	-- Loop to raad in data that stores it as key and value pairs. Converts to numbers instead of strings
	for line in file:lines() do
		local key, value = line:match("(%w+)%=(%-?%d+)")
		if key and value then
			config_data[key] = tonumber(value)
		end
	end

	file:close()
	return config_data
end

-- Takes varables from config and stores them for use
local rawConfig = readConfig("config.txt")

if not rawConfig then
	os.exit(1)
end

-- Checking if values are being read from config.txt
for k, v in pairs(rawConfig) do
	print("Config Loaded: ", k, v)
end

local config = {
	A = rawConfig.A or 0,
	B = rawConfig.B or 0,
	C = rawConfig.C or 0
}

-- Metatable to manage config and calculate max_distance
local metatable = {
	__index = function(tbl, key)
		if key == "max_distance" then
			return math.floor(math.sqrt(config.A^2 + config.B^2 + config.C^2) + 0.5)
		elseif rawConfig[key] ~= nil then
			return rawConfig[key]
		else
			print("Error: Missing config value -- ", key)
			return nil
		end
	end
}

-- merging tables into one named config for easy access.
setmetatable(config, metatable)

local stamina = config.Stamina
local goal_distance = config.GoalDistance
local max_distance = config.max_distance
local stamina_recovery = config.StaminaRecovery

if not config.Stamina or not config.StaminaRecovery or not config.GoalDistance then
	print("Error: Missing config values")
	os.exit(1)
end

print("Test %d %d %d %d", stamina, goal_distance, max_distance, stamina_recovery)

print("This is config test game")
print("Get to the goal_destination before your stamina runs out")
print(string.format("Max distance per turn: %d", max_distance))
print(string.format("Stamina: %d, Stamina Recovery: %d, Goal Distance: %d,", stamina, stamina_recovery, goal_distance))

-- Test game that utilizes config variables
while goal_distance > 0 and stamina > 0 do
	
	print(string.format("Stamina %d | Distance Remaaining: %d", stamina, goal_distance))

	io.write(string.format("Enter distance to move (1-%d): ", max_distance))
	local move_distance = tonumber(io.read())

	if not move_distance or move_distance < 1 or move_distance > max_distance then
		print("Invalid input")
	else
		if move_distance > stamina then
			print("Not enough stamina")
		else
			stamina = stamina - move_distance
			goal_distance = goal_distance - move_distance
			stamina = math.min(stamina + config.StaminaRecovery, config.Stamina)
		end
	end
end

if goal_distance <=0 then
	print("\n Goal Reached")
else
	print("\n Ran out of stamina")
end
