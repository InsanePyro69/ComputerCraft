-- ComputerCraft script for a mining turtle to quarry areas
-- Usage: quarry <num> <int> <int>

local sProcessname = "Mining Process"
local iFuelSlot = 16
local x, y, z = 0, 0, 0

local args = { ... }
local length = tonumber(args[1])
local width = tonumber(args[2])
local layers = tonumber(args[3])

local function readnumber(s)
	while true do
		print(s .. ": ")
		local r = io.read()
		local n = tonumber(r)
		if n then return n end
		print("Invalid argument '" .. r .. "'!")
	end
end

length = length or readnumber("Quarry length")
width = width or readnumber("Quarry width")
layers = layers or readnumber("Quarry layers")
local layer = 0

local function refuel()
	if turtle.getFuelLevel() < 500 then
		turtle.select(iFuelSlot)
		if not turtle.refuel(1) then
			print("Please add fuel to slot " .. iFuelSlot)
			while not turtle.refuel(1) do end
		end
		turtle.select(1)
	end
end

local function up()
	local success, data = turtle.inspectUp()
	if success and data.name == "minecraft:bedrock" then
		print("Bedrock above!")
		print("Press Enter to continue")
		io.read()
		return
	end
	refuel()
	while not turtle.up() do
		print("Can't move up")
		print("Press Enter to continue")
		io.read()
	end
	z = z + 1
end

local function down()
	local success, data = turtle.inspectDown()
	if success and data.name == "minecraft:bedrock" then
		print("Bedrock below!")
		print("Press Enter to continue")
		io.read()
		return
	end
	turtle.digDown()
	refuel()
	while not turtle.down() do
		print("Can't move down")
		print("Press Enter to continue")
		io.read()
	end
	z = z - 1
end

local function back()
	refuel()
	while not turtle.back() do
		print("Can't move back")
		print("Press Enter to continue")
		io.read()
	end
end

local function forward()
	local success, data = turtle.inspectUp()
	if success and data.name == "minecraft:bedrock" then
		print("Bedrock infront!")
		print("Press Enter to continue")
		io.read()
		return
	end
	while turtle.dig() do end
	refuel()
	while not turtle.forward() do
		print("Can't move forward")
		print("Press Enter to continue")
		io.read()
	end
	turtle.digUp()
	turtle.digDown()
end

local function deposit()
	for i = 1, 15 do
		turtle.select(i)
		turtle.dropUp()
	end
	turtle.select(1)
end

local function left()
	turtle.turnLeft()
end

local function right()
	turtle.turnRight()
end

local function main()
	while layer < layers do
		layer = layer + 1
		down()
		down()
		turtle.digDown()

		for i = 1, width do
			for j = 1, length - 1 do
				forward()
			end
			if i == width then break end
			if i % 2 == 0 then
				left()
				forward()
				left()
			else
				right()
				forward()
				right()
			end
		end

		left()
		left()

		down()
	end
end

local start_time = os.time()
print("Starting " .. sProcessname .. " at " .. textutils.formatTime(start_time, false))
main()
local end_time = os.time()
print("Ending " .. sProcessname .. " at " .. textutils.formatTime(end_time, false))
print(sProcessname .. " took " .. (end_time - start_time))
