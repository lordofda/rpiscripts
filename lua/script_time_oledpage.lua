-- The print command will output lua print statements to the domoticz log for debugging.
-- List all otherdevices states for debugging: 
--   for i, v in pairs(otherdevices) do print(i, v) end
-- List all otherdevices svalues for debugging: 
--   for i, v in pairs(otherdevices_svalues) do print(i, v) end

t1 = os.time()
s = otherdevices_lastupdate['OLED page']
-- returns a date time like 2013-07-11 17:23:12

year = string.sub(s, 1, 4)
month = string.sub(s, 6, 7)
day = string.sub(s, 9, 10)
hour = string.sub(s, 12, 13)
minutes = string.sub(s, 15, 16)
seconds = string.sub(s, 18, 19)

commandArray = {}

t2 = os.time{year=year, month=month, day=day, hour=hour, min=minutes, sec=seconds}
difference = (os.difftime (t1, t2))
if (difference > 30) then
local page = tonumber(otherdevices_svalues['OLED page'])
	if (page<30) then
	page = tostring(page+10)
		commandArray['OLED page'] = 'Set Level: '..page
	else
		commandArray['OLED page'] = 'Set Level: 10'
	end	
end

return commandArray
