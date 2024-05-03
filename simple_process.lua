-- ComputerCraft script to simple process items

local function find_item_slot(name)
	for slot = 1, 16 do
		local item = turtle.getItemDetail(slot)
		if item then
            if not name or item.name == name then
                return slot
            end
		end
    end
end

local function process(name)
	local slot = find_item_slot(name)
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

local itemname = turtle.getItemDetail(find_item_slot()).name

local i = 0
repeat
    print("Iteration: " .. i)
	i = i + 1
	local exit = process(itemname)
until exit

print("Ending simple process")