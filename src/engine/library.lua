
dofile("util.lua")

local L = {}

L.entries = {}
L.count = 0

function L.reset()
	--

end



--automatically called by node.create
function L.register(node)
	L.entries[node.uuid] = node
	L.count = L.count + 1
end

local function test()
	L.register('asdf', {'foo', 'bar'})
	L.register('asdf2', {'foo', 'bar'})
	L.register('asdf3', {'foo', 'bar'})
end

--	list all registered entities and some basic attrs

function L.list()
	local entries = L.entries

	for key, value in pairs(L.entries) do --actualcode
		print(key, value.name)
	end
end

return L