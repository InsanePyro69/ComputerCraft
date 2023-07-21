-- ComputerCraft script to make Energized Steel from the Powah mod

local function find_item_slot(name)
	for slot = 1, 16 do
		local item = turtle.getItemDetail(slot)
		if item and item.name == name then
			return slot
		end
    end
end

local function process()
	local ironSlot = find_item_slot("minecraft:iron_ingot")
	if not ironSlot then
	    print("No iron found")
	    return true
	end

	local goldSlot = find_item_slot("minecraft:gold_ingot")
	if not goldSlot then
	    print("No gold found")
	    return true
	end

	if ironSlot then
		turtle.select(ironSlot)
		turtle.drop(1)
	end

	if goldSlot then
		turtle.select(goldSlot)
		turtle.drop(1)
	end

	while not turtle.suck(2) do
		-- this gets stuck when there is no empty output slot or being interrupted
	end

end

print("Starting process Energized Steel")

local i = 0
repeat
	i = i + 1
	print("Iteration: " .. i)
	local exit = process()
until exit

print("Ending process")