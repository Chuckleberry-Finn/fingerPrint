local print_original = print
function _G.print(...)

	local coroutine = getCurrentCoroutine()
	local count = getCallframeTop(coroutine)
	local printText
	for i= count - 1, 0, -1 do
		local o = getCoroutineCallframeStack(coroutine,i)
		if o ~= nil then
			local s = KahluaUtil.rawTostring2(o)
			if s then
				local modFile = s:match(".* | MOD: (.*)")
				if modFile and modFile~="fingerPrint" then
					printText = "\["..modFile.."\] "
				end
			end
		end
	end

	print_original(printText,...)

end




local errorCount = -1
local function parseErrors()
	print("TESTING: parseErrors:")
	local text = ""
	local errors = getLuaDebuggerErrors()
	for i = 1,errors:size() do
		local str = errors:get(i-1)
		str = str:gsub("\t", "    ")
		text = text .. str .. "\n"
	end
	errorCount = getLuaDebuggerErrorCount()
	print("@@@@@@@@@@\n",text,"\n@@@@@@@@@@")
end

local function test() DebugLogStream.printException() end
Events.EveryTenMinutes.Add(test)

local function compareErrorCount()
	print("errorCount: "..errorCount.."  getLuaDebuggerErrorCount():"..getLuaDebuggerErrorCount())
	if errorCount ~= getLuaDebuggerErrorCount() then
		parseErrors()
	end
end
Events.EveryTenMinutes.Add(compareErrorCount)



