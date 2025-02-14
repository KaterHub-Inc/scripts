--setup
local alphabet = "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ+/"
local base = {}

for i = 0, 63 do
	base[i] = alphabet:sub(i+1,i+1)
	base[alphabet:sub(i+1,i+1)] = i
end

local S1 = {}  --B64 Character 1-2 for ASCII character 1-2
local S2 = {}  --B64 Character 3-4 for ASCII character 2-3
local S3 = {}  --ASCII Character 1 for B64 characters 1-2
local S4 = {}  --ASCII Character 2 for B64 characters 2-3
local S5 = {}  --ASCII Character 3 for B64 characters 3-4

--[[
for C1 = 0, 255 do
	for C2 = 0, 255 do
		for C3 = 0, 255 do
			local Sum = C1 * 65536 + C2 * 256 + C3
			
			local B1 = base[ bit32.extract(Sum, 0,6) ]
			local B2 = base[ bit32.extract(Sum, 6,6) ]
			local B3 = base[ bit32.extract(Sum,12,6) ]
			local B4 = base[ bit32.extract(Sum,18,6) ]
			
			S1[string.char(C1, C2)] = B1 .. B2
			S2[string.char(C2, C3)] = B3 .. B4
			S3[B1 .. B2] = string.char(C1)
			S4[B2 .. B3] = string.char(C2)
			S5[B3 .. B4] = string.char(C3)
		end
	end
end
]]

local C1 = 0
local C2 = 0
local C3 = 0

for C1 = 0, 255 do
	for C2 = 0, 255 do
		local Sum = C3 * 65536 + C2 * 256 + C1
		
		local B1 = base[ bit32.extract(Sum, 0,6) ]
		local B2 = base[ bit32.extract(Sum, 6,6) ]
		
		S1[string.char(C1, C2)] = B1 .. B2
		S3[B1 .. B2] = string.char(C1)
	end
end

for C2 = 0, 255 do
	for C3 = 0, 255 do
		local Sum = C3 * 65536 + C2 * 256 + C1
		
		local B3 = base[ bit32.extract(Sum,12,6) ]
		local B4 = base[ bit32.extract(Sum,18,6) ]

		S2[string.char(C2, C3)] = B3 .. B4
		S5[B3 .. B4] = string.char(C3)
	end
end

for C1 = 0, 192, 64 do
	for C2 = 0, 255 do
		for C3 = 0, 3 do
			local Sum = C3 * 65536 + C2 * 256 + C1
			
			local B2 = base[ bit32.extract(Sum, 6,6) ]
			local B3 = base[ bit32.extract(Sum,12,6) ]
			
			S4[B2 .. B3] = string.char(C2)
		end
	end
end


local function Encode(Data : string) : string
	if Data == 0 then return "" end --Empty string
	
	local padding = -#Data % 3
	Data ..= string.rep("\0", padding) --Add padding
	
	local resault = table.create(#Data/3*2+1, "    ")
	resault[1] = base[padding] --The first entry to hold how much padding there is
	
	local index = 2
	for i = 1, #Data, 3 do
		--Get the B64 characters for ascii characters
		resault[index  ] = S1[Data:sub(i,  i+1)]
		resault[index+1] = S2[Data:sub(i+1,i+2)]
		index += 2
	end
	
	return table.concat(resault,"")
end

local function Decode(Data : string) : string
	if Data == "E" or Data == "" then return "" end --Indicator of empty data
	
	local padding = base[Data:sub(1,1)] --How many characters are to remove from the end
	local resault = table.create((#Data-1)/4*3, "   ")
	
	local index = 1
	for i = 2, #Data, 4 do --Start at second character
		--Get the ascii characters for B64 characters
		resault[index  ] = S3[Data:sub(i,  i+1)]
		resault[index+1] = S4[Data:sub(i+1,i+2)]
		resault[index+2] = S5[Data:sub(i+2,i+3)]
		index += 3
	end
	
	local concatted = table.concat(resault)
	return concatted:sub(1, #concatted-padding) --remove last characters
end

return {encode = Encode, decode = Decode}
