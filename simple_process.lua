-- ComputerCraft script to simple process items

local function find_item_slot()
	for slot = 1, 16 do
		if turtle.getItemDetail(slot) then
			return slot
		end
	end
end

local function process()
	local slot = find_item_slot()
	if not slot then
		print("No item found")
		return true
	end

	turtle.select(slot)
	turtle.drop(1)

	while not turtle.suck(1) do
		-- this gets stuck when there is no empty output slot or being interrupted
	end

end

print("Starting simple process")

local i = 0
repeat
    print("Iteration: " .. i)
	i = i + 1
	local exit = process()
until exit

print("Ending simple process")
