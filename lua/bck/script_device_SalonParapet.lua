local NazwaCzujnika="Salon Parapet"
local Adres="192.168.1.10"
commandArray = {}

if devicechanged[NazwaCzujnika] then
    commandArray[1]={['OpenURL']=Adres..'/control?cmd=oled,5,1,Salon:'}
    commandArray[2]={['OpenURL']=Adres..'/control?cmd=oled,5,10,'..otherdevices_svalues[NazwaCzujnika]..'*C'}
   end
return commandArray
