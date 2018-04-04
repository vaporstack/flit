
node = require'node'
require"io"

dofile("util.lua")

local library = require("library")

local T = {}


local function split(input)
	local res = {}
	local c = 0
	for i in string.gmatch(input, "%S+") do
		res[i] = res[i] or 0
		res[i] = res[i] + 1
		--c = c + 1
	end
	return res
end


local function load_lorem()
	local filename = "../../data/lorem.txt"
	local lorem = {}
	local para = {}
	local combined = ""
	local ctr = 1
	for line in io.lines(filename) do 
		para[ctr] = line
		combined = combined .. line
		--print(line)
		ctr = ctr + 1
	end
	--combined = string.gsub(combined, "/\.", "\ ")
	combined = string.lower(combined)
	lorem.combined = combined
	lorem.para = para

	local chunks = split(combined)
	--table.foreach(chunks, print) 
	--print(chunks)
	--print(count(chunks))
	lorem.chunks = chunks
	--table.foreach(chunks, print) 
	T.lorem = lorem
	return lorem;
end



local function create_node()

	local chunks = T.lorem.chunks
	local keyset={}
	local n=0

	for k,v in pairs(chunks) do
  		n=n+1
  		keyset[n]=k
	end
	
	table.sort(keyset)

	local num = #keyset
	local rand_str = ""

	local node = node.create()

	for i=1,10 do
		local index = math.random(1, num)
		local key = keyset[index]
		rand_str = rand_str .. " " .. key
		if math.random() < .1 then
			--print("NAMING node", key)
			node.name = key
		end
	end

	node.text.base = rand_str
	if node.name == nil then
		node.name = "something_went_wrong_somewhere_earlier"
	end

	return node

end


function T.run()
	print("Loading lorem")
	local lorem = load_lorem()

	local test = {}
	local num = 5
	print("Creating " .. num .." random nodes.")

	for i = 1, num do
		local n = create_node()

		test[i] = n
	end
	library.list()
end

T.run()

return T
