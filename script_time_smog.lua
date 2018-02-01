-- ingests tables: otherdevices,otherdevices_svalues
-- 
-- otherdevices and otherdevices_svalues are two item array for all devices: 
--   otherdevices['yourotherdevicename']="On"
--	otherdevices_svalues['yourotherthermometer'] = string of svalues
--


time = os.date("*t")

commandArray = {}

if (time.min % 1 == 0) then
	print('Air Quality script')	

	json = (loadfile "/home/pi/domoticz/scripts/lua/JSON.lua")()
	
	local config = assert(io.popen('curl http://api.gios.gov.pl/pjp-api/rest/data/getData/5228'))
	local CO = config:read('*all')
	config:close()
	config = assert(io.popen('curl http://api.gios.gov.pl/pjp-api/rest/data/getData/5232'))
        local PM10  = config:read('*all')
        config:close()
	config = assert(io.popen('curl http://api.gios.gov.pl/pjp-api/rest/data/getData/5230'))
        local NO2 = config:read('*all')
        config:close()
	config = assert(io.popen('curl http://api.gios.gov.pl/pjp-api/rest/data/getData/5233'))
        local SO2 = config:read('*all')
        config:close()
	
	local jsonCO = json:decode(CO)
	local jsonPM10 = json:decode(PM10)
	local jsonNO2 = json:decode(NO2)
	local jsonSO2 = json:decode(SO2)

	local extractedCO = jsonCO.values[1].value
	local extractedPM10 = jsonPM10.values[1].value
	local extractedNO2 = jsonNO2.values[1].value
	local extractedSO2 = jsonSO2.values[1].value

	if (extractedCO == nil) then
        	extractedCO = "brak danych"
	end
        if (extractedPM10 == nil) then
                extractedPM10 = "brak danych"
        end
        if (extractedNO2 == nil) then
                extractedNO2 = "brak danych"
        end
        if (extractedSO2 == nil) then
                extractedSO2 = "brak danych"
        end

	print("CO: "..extractedCO.." ; PM10: "..extractedPM10.." ; NO2: "..extractedNO2.." ; SO2: "..extractedSO2)
	commandArray['CO']=extractedCO
        commandArray['PM10']=extractedPM10
        commandArray['NO2']=extractedNO2
        commandArray['SO2']=extractedSO2

end

return commandArray
