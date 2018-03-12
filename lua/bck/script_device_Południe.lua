local NazwaCzujnika="Południe"
local Adres="192.168.1.10"
commandArray = {}

if devicechanged[NazwaCzujnika] then
    commandArray['OpenURL']=Adres..'/control?cmd=oled,3,1,Poludnie:'..otherdevices_svalues[NazwaCzujnika]..'*C'
   end
return commandArray
