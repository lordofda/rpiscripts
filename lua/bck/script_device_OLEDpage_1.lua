
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

sensorTemperature1, sensorHumidity1, sensorHumidityStatus1 = otherdevices_svalues[NazwaSzostego]:match("([^;]+);([^;]+);([^;]+)")
local avg1=(otherdevices_svalues[NazwaCzwartego]+otherdevices_svalues[NazwaPiatego])/2
avg1 = round(avg1,1)
sensorHumidity1 = round(sensorHumidity1,0)

print(devicechanged['OLED page'])

if (devicechanged['OLED page'] == "Wilgotnosc") then
    commandArray[#commandArray +1]={['OpenURL']=Adres..'/control?cmd=oledcmd,clear'}
    commandArray[#commandArray +1]={['OpenURL']=Adres..'/control?cmd=oled,5,1,Wewnatrz'}
    commandArray[#commandArray +1]={['OpenURL']=Adres..'/control?cmd=oled,6,1,Temp'}
    commandArray[#commandArray +1]={['OpenURL']=Adres..'/control?cmd=oled,7,1,Wilg'}
    
    commandArray[#commandArray +1]={['OpenURL']=Adres..'/control?cmd=oled,6,12,'..avg}
    commandArray[#commandArray +1]={['OpenURL']=Adres..'/control?cmd=oled,7,12,'..sensorHumidity..'%'}
    commandArray[#commandArray +1]={['OpenURL']=Adres..'/control?cmd=oled,8,11,'..sensorHumidityStatus}


    commandArray[#commandArray +1]={['OpenURL']=Adres..'/control?cmd=oled,1,1,Zewnatrz'}
    commandArray[#commandArray +1]={['OpenURL']=Adres..'/control?cmd=oled,2,1,Temp'}
    commandArray[#commandArray +1]={['OpenURL']=Adres..'/control?cmd=oled,3,1,Wilg'}
    
    commandArray[#commandArray +1]={['OpenURL']=Adres..'/control?cmd=oled,2,12,'..avg1}
    commandArray[#commandArray +1]={['OpenURL']=Adres..'/control?cmd=oled,3,12,'..sensorHumidity1..'%'}

   end

if (devicechanged['OLED page'] == "Powitanie") then
    commandArray[#commandArray +1]={['OpenURL']=Adres..'/control?cmd=oledcmd,clear'}
    commandArray[#commandArray +1]={['OpenURL']=Adres..'/control?cmd=oled,1,1,Z:'..avg1}
    commandArray[#commandArray +1]={['OpenURL']=Adres..'/control?cmd=oled,1,10,W:'..avg}

    if (time.hour >= 6 and time.hour < 12) then
        commandArray[#commandArray +1]={['OpenURL']=Adres..'/control?cmd=oled,4,1,Milego'}
        commandArray[#commandArray +1]={['OpenURL']=Adres..'/control?cmd=oled,6,3,Poranka:)'}
        print("Time set to Morning")
    end
    if (time.hour >= 12 and time.hour < 18) then
        commandArray[#commandArray +1]={['OpenURL']=Adres..'/control?cmd=oled,4,1,Milego'}
        commandArray[#commandArray +1]={['OpenURL']=Adres..'/control?cmd=oled,6,3,Popoludnia'}
        print("Time set to Afternoon")
    end
    if (time.hour >= 18 and time.hour < 22) then
        commandArray[#commandArray +1]={['OpenURL']=Adres..'/control?cmd=oled,4,1,Spokojnego'}
        commandArray[#commandArray +1]={['OpenURL']=Adres..'/control?cmd=oled,6,3,Wieczoru'}
        print("Time set to Evening")
    end
    if (time.hour >= 22 or time.hour < 6) then
        commandArray[#commandArray +1]={['OpenURL']=Adres..'/control?cmd=oled,4,1,Dobrej'}
        commandArray[#commandArray +1]={['OpenURL']=Adres..'/control?cmd=oled,6,3,Nocy'}
        print("Time set to Night")
    end
    commandArray[#commandArray +1]={['OpenURL']=Adres..'/control?cmd=oled,3,1,----------------'}
    commandArray[#commandArray +1]={['OpenURL']=Adres..'/control?cmd=oled,7,1,----------------'}
end
if (devicechanged['OLED page'] == "Zanieczyszczenie") then

    commandArray[#commandArray +1]={['OpenURL']=Adres..'/control?cmd=oledcmd,clear'}
    commandArray[#commandArray +1]={['OpenURL']=Adres..'/control?cmd=oled,1,1,Typ'}
    commandArray[#commandArray +1]={['OpenURL']=Adres..'/control?cmd=oled,1,7,ug/m3'}
    commandArray[#commandArray +1]={['OpenURL']=Adres..'/control?cmd=oled,1,13,Norm'}

    commandArray[#commandArray +1]={['OpenURL']=Adres..'/control?cmd=oled,2,1,----------------'}

    commandArray[#commandArray +1]={['OpenURL']=Adres..'/control?cmd=oled,3,1,CO:'}
    commandArray[#commandArray +1]={['OpenURL']=Adres..'/control?cmd=oled,4,1,PM10:'}
    commandArray[#commandArray +1]={['OpenURL']=Adres..'/control?cmd=oled,6,1,NO2:'}
    commandArray[#commandArray +1]={['OpenURL']=Adres..'/control?cmd=oled,7,1,SO2:'}

    if not (otherdevices_svalues['CO'] == "brak danych") then
        commandArray[#commandArray +1]={['OpenURL']=Adres..'/control?cmd=oled,3,7,'..round(otherdevices_svalues['CO'],0)}
    else
	commandArray[#commandArray +1]={['OpenURL']=Adres..'/control?cmd=oled,3,7,---'}
    end
    if not (otherdevices_svalues['PM10'] == "brak danych") then
        commandArray[#commandArray +1]={['OpenURL']=Adres..'/control?cmd=oled,4,7,'..round(otherdevices_svalues['PM10'],0)}
    else
        commandArray[#commandArray +1]={['OpenURL']=Adres..'/control?cmd=oled,4,7,---'}
    end
    if not (otherdevices_svalues['NO2'] == "brak danych") then
        commandArray[#commandArray +1]={['OpenURL']=Adres..'/control?cmd=oled,6,7,'..round(otherdevices_svalues['NO2'],0)}
    else
        commandArray[#commandArray +1]={['OpenURL']=Adres..'/control?cmd=oled,6,7,---'}
    end
    if not (otherdevices_svalues['SO2'] == "brak danych") then
        commandArray[#commandArray +1]={['OpenURL']=Adres..'/control?cmd=oled,7,7,'..round(otherdevices_svalues['SO2'],0)}
    else
        commandArray[#commandArray +1]={['OpenURL']=Adres..'/control?cmd=oled,7,7,---'}
    end	

    commandArray[#commandArray +1]={['OpenURL']=Adres..'/control?cmd=oled,3,13,10k'}
    commandArray[#commandArray +1]={['OpenURL']=Adres..'/control?cmd=oled,4,14,50'}
    commandArray[#commandArray +1]={['OpenURL']=Adres..'/control?cmd=oled,6,13,200'}
    commandArray[#commandArray +1]={['OpenURL']=Adres..'/control?cmd=oled,7,13,350'}

end
return commandArray
