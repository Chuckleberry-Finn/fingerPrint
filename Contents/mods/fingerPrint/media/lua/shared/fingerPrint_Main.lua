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


