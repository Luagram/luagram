CLIENT = io.popen("echo $SSH_CLIENT | awk '{ print $1}'"):read('*a')
serpent = dofile("./libs/serpent.lua")
redis = dofile("./libs/redis.lua").connect("127.0.0.1", 6379)
https = require("ssl.https")
JSON = dofile("./libs/dkjson.lua")
http = require("socket.http")
json = dofile("./libs/JSON.lua")
URL = dofile("./libs/url.lua")
-------------------------------------------------------------------
ip_server = string.match(io.popen('hostname -I'):read('*a'),'(%S+)')
whoami = io.popen("whoami"):read('*a'):gsub('[\n\r]+', '')
uptime=io.popen([[echo `uptime | awk -F'( |,|:)+' '{if ($7=="min") m=$6; else {if ($7~/^day/) {d=$6;h=$8;m=$9} else {h=$6;m=$7}}} {print d+0,"D,",h+0,"H,",m+0,"M."}'`]]):read('*a'):gsub('[\n\r]+', '')
CPUPer=io.popen([[echo `top -b -n1 | grep "Cpu(s)" | awk '{print $2 + $4}'`]]):read('*a'):gsub('[\n\r]+', '')
HardDisk=io.popen([[echo `df -lh | awk '{if ($6 == "/") { print $3"/"$2" ( "$5" )" }}'`]]):read('*a'):gsub('[\n\r]+', '')
linux_version=io.popen([[echo `lsb_release -ds`]]):read('*a'):gsub('[\n\r]+', '')
memUsedPrc=io.popen([[echo `free -m | awk 'NR==2{printf "%sMB/%sMB ( %.2f% )\n", $3,$2,$3*100/$2 }'`]]):read('*a'):gsub('[\n\r]+', '')
-------------------------------------------------------------------
TDbot = require('tdbot')
-------------------------------------------------------------------
local infofile = io.open("./sudo.lua","r")
if not infofile then
if not redis:get(CLIENT.."token") then
os.execute('sudo rm -rf setup.lua')
io.write('\27[1;31mSend your Bot Token Now\n\27[0;39;49m')
local TokenBot = io.read()
if TokenBot and TokenBot:match('(%d+):(.*)') then
local url , res = https.request("https://api.telegram.org/bot"..TokenBot.."/getMe")
local Json_Info = JSON.decode(url)
if res ~= 200 then
print('\27[1;34mBot Token is Wrong\n')
else
io.write('\27[1;34mThe token been saved successfully \n\27[0;39;49m')
TheTokenBot = TokenBot:match("(%d+)")
os.execute('sudo rm -fr .infoBot/'..TheTokenBot)
redis:setex(CLIENT.."token",300,TokenBot)
end 
else
print('\27[1;34mToken not saved, try again')
end 
os.execute('lua5.3 start.lua')
end
if not redis:get(CLIENT.."id") then
io.write('\27[1;31mSend Developer ID\n\27[0;39;49m')
local UserId = io.read()
if UserId and UserId:match('%d+') then
io.write('\n\27[1;34mDeveloper ID saved \n\n\27[0;39;49m')
redis:setex(CLIENT.."id",300,UserId)
else
print('\n\27[1;34mDeveloper ID not saved\n')
end 
os.execute('lua5.3 start.lua')
end
local url , res = https.request('https://api.telegram.org/bot'..redis:get(CLIENT.."token")..'/getMe')
local Json_Info = JSON.decode(url)
local Inform = io.open("sudo.lua", 'w')
Inform:write([[
return {
	
Token = "]]..redis:get(CLIENT.."token")..[[",

id = ]]..redis:get(CLIENT.."id")..[[

}
]])
Inform:close()
local start = io.open("start", 'w')
start:write([[
cd $(cd $(dirname $0); pwd)
while(true) do
sudo lua5.3 start.lua
done
]])
start:close()
local Run = io.open("Run", 'w')
Run:write([[
cd $(cd $(dirname $0); pwd)
while(true) do
screen -S ]]..Json_Info.result.username..[[ -X kill
screen -S ]]..Json_Info.result.username..[[ ./start
done
]])
Run:close()
redis:del(CLIENT.."id")
redis:del(CLIENT.."token")
os.execute('cp -a ../luagram/ ../'..Json_Info.result.username..' && rm -fr ~/luagram')
os.execute('cd && cd '..Json_Info.result.username..';chmod +x start;chmod +x Run;./Run')
end
----------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------
Information = dofile('./sudo.lua')
sudoid = Information.id
Token = Information.Token
bot_id = Token:match("(%d+)")
os.execute('sudo rm -fr .infoBot/'..bot_id)
bot = TDbot.set_config{
api_id=16097628,
api_hash='d21f327886534832fdf728117ac7b809',
session_name=bot_id,
token=Token
}
----------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------
function Bot(msg)  
local idbot = false  
if tonumber(msg.sender_id.user_id) == tonumber(bot_id) then  
idbot = true    
end  
return idbot  
end
----------------------------------------------------------------------------------------------------
function Call(data)
if data then
print(serpent.block(data, {comment=false}))   
end
if data and data.tdbot and data.tdbot == "updateChatMember" then
print(data.tdbot)
elseif data and data.tdbot and data.tdbot == "updateSupergroup" then
print(data.tdbot)
elseif data and data.tdbot and data.tdbot == "updateNewMessage" then
if data.message.sender_id.tdbot == "messageSenderChat" then
bot.deleteMessages(data.message.chat_id,{[1]= data.message.id})
return false
end
print(data.tdbot)
Run(data.message,data)
elseif data and data.tdbot and data.tdbot == "updateMessageEdited" then
local msg = bot.getMessage(data.chat_id, data.message_id)
if tonumber(msg.sender_id.user_id) ~= tonumber(bot_id) then  
print(data.tdbot)
end
elseif data and data.tdbot and data.tdbot == "updateNewCallbackQuery" then
print(data.tdbot)
Callback(data)
elseif data and data.tdbot and data.tdbot == "updateMessageSendSucceeded" then
print(data.tdbot)
end
----------------------------------------------------------------------------------------------------
end
TDbot.run(Call)