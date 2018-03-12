-- ingests tables: otherdevices,otherdevices_svalues
-- 
-- otherdevices and otherdevices_svalues are two item array for all devices: 
--   otherdevices['yourotherdevicename']="On"
--	otherdevices_svalues['yourotherthermometer'] = string of svalues
--


time = os.date("*t")

commandArray = {}

if (time.min  == 30) then
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
        config = assert(io.popen('curl http://api.gios.gov.pl/pjp-api/rest/aqindex/getIndex/798'))
        local Index = config:read('*all')
        config:close()
	
	local jsonCO = json:decode(CO)
	local jsonPM10 = json:decode(PM10)
	local jsonNO2 = json:decode(NO2)
	local jsonSO2 = json:decode(SO2)
	local jsonIndex = json:decode(Index)

	local extractedCO = jsonCO.values[1].value
	local extractedPM10 = jsonPM10.values[1].value
	local extractedNO2 = jsonNO2.values[1].value
	local extractedSO2 = jsonSO2.values[1].value

	local i=1

	while  (extractedCO == nil) do
		i=i+1
        	extractedCO = jsonCO.values[i].value
	end
	i=1
	while  (extractedPM10 == nil) do
		i=i+1
        	extractedPM10 = jsonPM10.values[i].value
	end
	i=1
	while  (extractedNO2 == nil) do
		i=i+1
        	extractedNO2 = jsonNO2.values[i].value
	end
	i=1
	while  (extractedSO2 == nil) do
		i=i+1
        	extractedSO2 = jsonSO2.values[i].value
	end


	print("CO: "..extractedCO.." ; PM10: "..extractedPM10.." ; NO2: "..extractedNO2.." ; SO2: "..extractedSO2)
	commandArray[1]={['UpdateDevice']="30|0|"..extractedCO}
        commandArray[2]={['UpdateDevice']="31|0|"..extractedPM10}
        commandArray[3]={['UpdateDevice']="32|0|"..extractedNO2}
        commandArray[4]={['UpdateDevice']="33|0|"..extractedSO2}
	commandArray[5]={['UpdateDevice']="34|0|".."CO:"..jsonIndex.coIndexLevel.indexLevelName..", PM10:"..jsonIndex.pm10IndexLevel.indexLevelName..", NO2:"..jsonIndex.no2IndexLevel.indexLevelName..", SO2:"..jsonIndex.so2IndexLevel.indexLevelName}
end

return commandArray
