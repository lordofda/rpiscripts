--~/domoticz/scripts/lua/script_time_check.lua
commandArray = {}
time = os.date("*t")
-- Only operates when minutes is 0 i.e. on the hour
-- Time scripts are only called every minute, so this script will only operate once an hour
if time.min == 7 then
  commandArray[1]={['OpenURL']='192.168.1.10/control?cmd=oledcmd,clear'}
  print("oled cleared")
end
if time.min == 37 then
  commandArray[1]={['OpenURL']='192.168.1.10/control?cmd=oledcmd,clear'}
  print("oled cleared")
end
return commandArray
