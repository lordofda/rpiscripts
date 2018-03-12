local NazwaCzujnika="Salon Parapet"
local NazwaDrugiego="Gabinet"
local NazwaTrzeciego="Wnetrze"
local Adres="192.168.1.10"

function round(num, numDecimalPlaces)
  local mult = 10^(numDecimalPlaces or 0)
  return math.floor(num * mult + 0.5) / mult
end

commandArray = {}

if devicechanged[NazwaCzujnika] then
    sensorTemperature, sensorHumidity, sensorHumidityStatus = otherdevices_svalues[NazwaTrzeciego]:match("([^;]+);([^;]+);([^;]+)")
    if sensorHumidityStatus=="0" then
      sensorHumidityStatus="Norm"
    elseif sensorHumidityStatus=="1" then
      sensorHumidityStatus="Komf"
    elseif sensorHumidityStatus=="2" then
      sensorHumidityStatus="Sucho"
    elseif sensorHumidityStatus=="3" then
      sensorHumidityStatus="Wilg"
    end
    local avg=(otherdevices_svalues[NazwaCzujnika]+otherdevices_svalues[NazwaDrugiego]+sensorTemperature)/3
    avg = round(avg,1)
    sensorHumidity = round(sensorHumidity,0)

    commandArray[1]={['OpenURL']=Adres..'/control?cmd=oled,5,1,Wewnatrz'}
    commandArray[2]={['OpenURL']=Adres..'/control?cmd=oled,6,1,Temp'}
    commandArray[3]={['OpenURL']=Adres..'/control?cmd=oled,7,1,Wilg'}
    
    commandArray[4]={['OpenURL']=Adres..'/control?cmd=oled,6,12,'..avg}
    commandArray[5]={['OpenURL']=Adres..'/control?cmd=oled,7,12,'..sensorHumidity..'%'}
    commandArray[6]={['OpenURL']=Adres..'/control?cmd=oled,8,11,'..sensorHumidityStatus}
   end
return commandArray
