-- The print command will output lua print statements to the domoticz log for debugging.
-- List all otherdevices states for debugging: 
--   for i, v in pairs(otherdevices) do print(i, v) end
-- List all otherdevices svalues for debugging: 
--   for i, v in pairs(otherdevices_svalues) do print(i, v) end

t1 = os.time()
s = otherdevices_lastupdate['Pobudka']

year = string.sub(s, 1, 4)
month = string.sub(s, 6, 7)
day = string.sub(s, 9, 10)
hour = string.sub(s, 12, 13)
minutes = string.sub(s, 15, 16)
seconds = string.sub(s, 18, 19)

t2 = os.time{year=year, month=month, day=day, hour=hour, min=minutes, sec=seconds}
difference = (os.difftime (t1, t2))

function round(num, numDecimalPlaces)
  local mult = 10^(numDecimalPlaces or 0)
  return math.floor(num * mult + 0.5) / mult
end

local speed = 30
speed = 255/30
speed = round(speed,0)

commandArray = {}

if (difference < 120 and otherdevices_svalues['Pobudka']=='0') then
	commandArray['OpenURL'] = '192.168.1.2:8080/json.htm?type=command&param=udevice&idx=39&nvalue=0&svalue=0'
end

if (otherdevices_svalues['Pobudka']=='10') then
	local page = tonumber(otherdevices_svalues['Rotary'])
	if (page<255) then
		page = tostring(page+speed)
		commandArray['OpenURL'] = '192.168.1.2:8080/json.htm?type=command&param=udevice&idx=39&nvalue=0&svalue='..page
	end
end

return commandArray
