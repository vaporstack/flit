

--t = { key1 = 'value1', key2 = false }

local N = {}

local library = require('library')
local dag = require('dag')

uuid = require("uuid")

function N.create()
	if name == nil then name = "unnamed_node" end
	obj = {};
	
	obj.name = name
	obj.uuid = uuid()
	
	obj.dag = dag.create_repr()
	
	obj.text = {}
	obj.text.base = "blank text";
	
	obj.links = {}
	library.register(obj)
	return obj
end


return N

--test = create_node()

--print(test.uuid)
