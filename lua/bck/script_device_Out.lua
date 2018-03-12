local NazwaCzujnika="Południe"
local NazwaDrugiego="Północ"
local NazwaTrzeciego="(Internet) Warunki"
local Adres="192.168.1.10"

function round(num, numDecimalPlaces)
  local mult = 10^(numDecimalPlaces or 0)
  return math.floor(num * mult + 0.5) / mult
end

commandArray = {}

if devicechanged[NazwaCzujnika] then
    sensorTemperature, sensorHumidity, sensorHumidityStatus = otherdevices_svalues[NazwaTrzeciego]:match("([^;]+);([^;]+);([^;]+)")
    local avg=(otherdevices_svalues[NazwaCzujnika]+otherdevices_svalues[NazwaDrugiego])/2
    avg = round(avg,1)
    sensorHumidity = round(sensorHumidity,0)

    commandArray[1]={['OpenURL']=Adres..'/control?cmd=oled,1,1,Zewnatrz'}
    commandArray[2]={['OpenURL']=Adres..'/control?cmd=oled,2,1,Temp'}
    commandArray[3]={['OpenURL']=Adres..'/control?cmd=oled,3,1,Wilg'}
    
    commandArray[4]={['OpenURL']=Adres..'/control?cmd=oled,2,12,'..avg}
    commandArray[5]={['OpenURL']=Adres..'/control?cmd=oled,3,12,'..sensorHumidity..'%'}

   end
return commandArray
