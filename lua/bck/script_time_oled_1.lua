--~/domoticz/scripts/lua/script_time_check.lua

local Adres="192.168.1.10"
local NazwaCzujnika="Salon Parapet"
local NazwaDrugiego="Gabinet"
local NazwaTrzeciego="Wnetrze"
local NazwaCzwartego="Południe"
local NazwaPiatego="Północ"
local NazwaSzostego="(Internet) Warunki"


function round(num, numDecimalPlaces)
  local mult = 10^(numDecimalPlaces or 0)
  return math.floor(num * mult + 0.5) / mult
end

commandArray = {}
time = os.date("*t")
if (time.min % 15 == 1) then

    commandArray[1]={['OpenURL']=Adres..'/control?cmd=oledcmd,clear'}
    print("oled cleared")

end
if (time.min % 2 == 0) then

    commandArray[1]={['OpenURL']=Adres..'/control?cmd=oledcmd,clear'}
  
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

    commandArray[2]={['OpenURL']=Adres..'/control?cmd=oled,5,1,Wewnatrz'}
    commandArray[3]={['OpenURL']=Adres..'/control?cmd=oled,6,1,Temp'}
    commandArray[4]={['OpenURL']=Adres..'/control?cmd=oled,7,1,Wilg'}
    
    commandArray[5]={['OpenURL']=Adres..'/control?cmd=oled,6,12,'..avg}
    commandArray[6]={['OpenURL']=Adres..'/control?cmd=oled,7,12,'..sensorHumidity..'%'}
    commandArray[7]={['OpenURL']=Adres..'/control?cmd=oled,8,11,'..sensorHumidityStatus}

    sensorTemperature1, sensorHumidity1, sensorHumidityStatus1 = otherdevices_svalues[NazwaSzostego]:match("([^;]+);([^;]+);([^;]+)")
    local avg1=(otherdevices_svalues[NazwaCzwartego]+otherdevices_svalues[NazwaPiatego])/2
    avg1 = round(avg1,1)
    sensorHumidity1 = round(sensorHumidity1,0)

    commandArray[8]={['OpenURL']=Adres..'/control?cmd=oled,1,1,Zewnatrz'}
    commandArray[9]={['OpenURL']=Adres..'/control?cmd=oled,2,1,Temp'}
    commandArray[10]={['OpenURL']=Adres..'/control?cmd=oled,3,1,Wilg'}
    
    commandArray[11]={['OpenURL']=Adres..'/control?cmd=oled,2,12,'..avg1}
    commandArray[12]={['OpenURL']=Adres..'/control?cmd=oled,3,12,'..sensorHumidity1..'%'}

   end
if (time.min % 2 == 1) then
    commandArray[1]={['OpenURL']=Adres..'/control?cmd=oledcmd,clear'}
    if (time.hour >= 6 and time.hour < 12) then
        commandArray[4]={['OpenURL']=Adres..'/control?cmd=oled,4,3,Milego'}
        commandArray[5]={['OpenURL']=Adres..'/control?cmd=oled,6,1,Poranka:)'}
        print("Time set to Morning")
    end
    if (time.hour >= 12 and time.hour < 18) then
        commandArray[4]={['OpenURL']=Adres..'/control?cmd=oled,4,3,Milego'}
        commandArray[5]={['OpenURL']=Adres..'/control?cmd=oled,6,1,Popoludnia'}
        print("Time set to Afternoon")
    end
    if (time.hour >= 18 and time.hour < 22) then
        commandArray[4]={['OpenURL']=Adres..'/control?cmd=oled,4,3,Spokojnego'}
        commandArray[5]={['OpenURL']=Adres..'/control?cmd=oled,6,1,Wieczoru'}
        print("Time set to Evening")
    end
    if (time.hour >= 22 or time.hour < 6) then
        commandArray[4]={['OpenURL']=Adres..'/control?cmd=oled,4,3,Dobrej'}
        commandArray[5]={['OpenURL']=Adres..'/control?cmd=oled,6,1,Nocy'}
        print("Time set to Night")
    end
end
return commandArray
