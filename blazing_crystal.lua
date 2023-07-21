-- ComputerCraft script to make Blazing Crystal from the Powah mod

local function find_item_slot(name)
	for slot = 1, 16 do
		local item = turtle.getItemDetail(slot)
		if item and item.name == name then
			return slot
		end
    end
end

local function process()
	local blazeSlot = find_item_slot("minecraft:blaze_rod")
	if not blazeSlot then
	    print("No blaze rod found")
	    return true
	end

	if blazeSlot then
	  turtle.select(blazeSlot)
	  turtle.drop(1)
	end

	while not turtle.suck(1) do
		-- this gets stuck when there is no empty output slot or being interrupted
	end

end

print("Starting process Blazing Crystal")

local i = 0
repeat
    print("Iteration: " .. i)
	i = i + 1
	local exit = process()
until exit

print("Ending process")