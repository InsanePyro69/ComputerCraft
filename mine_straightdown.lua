-- ComputerCraft script for a mining turtle

local sProcessname = "Mining Straight Down"
local bRunning = true
local iFuelSlot = 16
local bReachedBedrock = false
local x, y, z = 0, 0, 0

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
		bReachedBedrock = true
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

local function dispense() -- deposits mined items into chest behind where bot was initially placed. checks if bot needs fuel before dropping fuel into chest
    for i=1,15 do
        turtle.select(i)
        turtle.dropUp()
    end
	turtle.select(1)
end

local function mainloop()
    if bReachedBedrock then
		if z == 0 then
			bRunning = false
            dispense()
		else
			up()
		end
	else
		down()
    end
end

while bRunning do
    mainloop()
end

print("Ending " .. sProcessname)