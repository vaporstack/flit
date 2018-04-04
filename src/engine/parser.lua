

local P = {}


dofile("util.lua")
dofile("gsplit.lua")

local function mysplit(inputstr, sep)
        if sep == nil then
                sep = "%s"
        end
        local t={} ; i=1
        for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
                t[i] = str
                i = i + 1
        end
        return t
end


local function read_file(file)
	local f = io.open(file, "r")
	local content = f:read("*all")
	f:close()
	return content
end

function recursive_scan_parens(text, data)


end

function P.scan_links(input)
	if not input then
		print(" no input!")
		return
	end

	print("Parsed: //--------------------------")
	print(input)
	print("Endsed: //--------------------------")
	local bracket_expr = "\[([^\]]+)]"
	print("Links:")
	local done = false
	for iter, w, i in string.match(input, "%a+") do
      		print(w, i)
     	end
	--for k,v in string.match(input, "%[") do
	--	print(k)
	--end

	--local links = string.gmatch(input, bracket_expr);


end


function P.parse_file(input)

	P.data = {}
	print("Parsing : "  .. input)
	local data = read_file(input)
	local entries = split6(data, "////")
	--print(entries)
	local ct = count(entries)
	for k, v in pairs(entries) do
		P.scan_links(v)
		return
	end

	print("Loaded", ct, "entries.")
	

end




function P.test()
	P.parse_file("../data/test-mystery.txt")
end


P.test()


return P