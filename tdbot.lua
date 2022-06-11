#!/usr/bin/env lua5.3
local luatele_function, function_core, update_functions, luatele_timer = {}, {}, {}, {}
local luatele = {get_update = true,config = {}}
local LuaTele =  require('tdlua') 
local client = LuaTele()
-----------------------------------------------
function function_core._CALL_(update)
if update and type(update) == 'table' then
for i = 0 , #update_functions do
if not update_functions[i].filters then
send_update = true
update_message = update
elseif update.luatele and update_functions[i].filters and luatele_function.in_array(update_functions[i].filters,  update.luatele) then
send_update = true
update_message = update
else
send_update = false
end
if update_message and send_update and type(update_message) == 'table' then
xpcall(update_functions[i].def, function_core.print_error, update_message)
end
update_message = nil
send_update = nil
end
end
end
function function_core.change_table(input, send)
if send then
changes ={
luatele = string.reverse('epyt@')
}
rems = {
}
  else
changes = {
_ = string.reverse('eletaul'),
}
rems = {
string.reverse('epyt@')
}
end
if type(input) == 'table' then
local res = {}
for key,value in pairs(input) do
for k, rem in pairs(rems) do
if key == rem then
value = nil
end
end
local key = changes[key] or key
if type(value) ~= 'table' then
res[key] = value
else
res[key] = function_core.change_table(value, send)
end
end
return res
else
return input
end
end
function function_core.run_table(input)
local to_original = function_core.change_table(input, true)
local result = client:execute(to_original)
if type(result) ~= 'table' then
return nil
else
return function_core.change_table(result)
end
end
function function_core.print_error(err)
  print('There is an error in the file, please correct it '.. err)
end
function function_core.send_tdlib(input)
local to_original = function_core.change_table(input, true)
client:send(to_original)
end
function_core.send_tdlib{
luatele = 'getAuthorizationState'
}
LuaTele.setLogLevel(3)
LuaTele.setLogPath('/usr/lib/x86_64-linux-gnu/lua/5.3/.luatele.log')
-----------------------------------------------luatele_function
function luatele_function.len(input)
if type(input) == 'table' then
size = 0
for key,value in pairs(input) do
size = size + 1
end
return size
  else
size = tostring(input)
return #size
end
end
function luatele_function.match(...)
local val = {}
  for no,v in ipairs({...}) do
val[v] = true
end
return val
end
function luatele_function.secToClock(seconds)
local seconds = tonumber(seconds)
if seconds <= 0 then
return {hours=00,mins=00,secs=00}
  else
local hours = string.format("%02.f", math.floor(seconds / 3600));
local mins = string.format("%02.f", math.floor(seconds / 60 - ( hours*60 ) ));
local secs = string.format("%02.f", math.floor(seconds - hours * 3600 - mins * 60));
return {hours=hours,mins=mins,secs=secs}
end
end
function luatele_function.number_format(num)
local out = tonumber(num)
  while true do
out,i= string.gsub(out,'^(-?%d+)(%d%d%d)', '%1,%2')
if (i==0) then
break
end
end
return out
end
function luatele_function.base64_encode(str)
	local Base ='ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'
	return ((str:gsub('.', function(x)
			local r,Base='',x:byte()
			for i=8,1,-1 do r=r..(Base%2^i-Base%2^(i-1)>0 and '1' or '0') end
			return r;
	end)..'0000'):gsub('%d%d%d?%d?%d?%d?', function(x)
			if (#x < 6) then return '' end
			local c=0
			for i=1,6 do c=c+(x:sub(i,i)=='1' and 2^(6-i) or 0) end
			return Base:sub(c+1,c+1)
	end)..({ '', '==', '=' })[#str%3+1])
end
function luatele_function.base64_decode(str)
	local Base ='ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'
  str = string.gsub(str, '[^'..Base..'=]', '')
return (str:gsub('.', function(x)
if (x == '=') then
return ''
end
local r,f='',(Base:find(x)-1)
for i=6,1,-1 do r=r..(f%2^i-f%2^(i-1)>0 and '1' or '0') end
return r;
end):gsub('%d%d%d?%d?%d?%d?%d?%d?', function(x)
if (#x ~= 8) then
return ''
end
local c=0
for i=1,8 do c=c+(x:sub(i,i)=='1' and 2^(8-i) or 0) end
return string.char(c)
end))
end
function luatele_function.exists(file)
 local ok, err, code = os.rename(file, file)
 if not ok then
if code == 13 then
 return true
end
 end
 return ok, err
end
function luatele_function.in_array(table, value)
  for k,v in pairs(table) do
if value == v then
return true
end
end
return false
end
function luatele_function.add_events(def,filters)
if type(def) ~= 'function' then
function_core.print_error('the add_events def must be a function !')
return {
luatele = false,
}
  elseif type(filters) ~= 'table' then
function_core.print_error('the add_events filters must be a table !')
return {
luatele = false,
}
else
local function_id = #update_functions + 1
update_functions[function_id] = {}
update_functions[function_id].def = def
update_functions[function_id].filters = filters
return {
luatele = true,
}
end
end


function luatele_function.set_timer(seconds, def, argv)
if type(seconds) ~= 'number' then
return {
luatele = false,
message = 'set_timer(int seconds, funtion def, table)'
}
elseif type(def) ~= 'function' then
return {
luatele = false,
message = 'set_timer(int seconds, funtion def, table)'
}
end
luatele_timer[#luatele_timer + 1] = {
def = def,
argv = argv,
run_in = os.time() + seconds
}
return {
luatele = true,
run_in = os.time() + seconds,
timer_id = #luatele_timer
}
end
function luatele_function.get_timer(timer_id)
local timer_data = luatele_timer[timer_id]
if timer_data then
return {
luatele = true,
run_in = timer_data.run_in,
argv = timer_data.argv
}
  else
return {
luatele = false,
}
end
end
function luatele_function.cancel_timer(timer_id)
if luatele_timer[timer_id] then
table.remove(luatele_timer,timer_id)
return {
luatele = true
}
  else
return {
luatele = false
}
end
end

function luatele_function.replyMarkup(input)
if type(input.type) ~= 'string' then
return nil
end
local _type = string.lower(input.type)
if _type == 'inline' then
local result = {
luatele = 'replyMarkupInlineKeyboard',
rows = {
}
}
for _, rows in pairs(input.data) do
local new_id = #result.rows + 1
result.rows[new_id] = {}
for key, value in pairs(rows) do
  local rows_new_id = #result.rows[new_id] + 1
if value.url and value.text then
result.rows[new_id][rows_new_id] = {
  luatele = 'inlineKeyboardButton',
text = value.text,
type = {
luatele = 'inlineKeyboardButtonTypeUrl',
  url = value.url
}
}
elseif value.data and value.text then
result.rows[new_id][rows_new_id] = {
luatele = 'inlineKeyboardButton',
  text = value.text,
  type = {
data = luatele_function.base64_encode(value.data), -- Base64 only
luatele = 'inlineKeyboardButtonTypeCallback',
}
}
  elseif value.forward_text and value.id and value.url and value.text then
result.rows[new_id][rows_new_id] = {
luatele = 'inlineKeyboardButton',
  text = value.text,
  type = {
id = value.id,
url = value.url,
forward_text = value.forward_text,
luatele = 'inlineKeyboardButtonTypeLoginUrl',
}
}
  elseif value.query and value.text then
result.rows[new_id][rows_new_id] = {
luatele = 'inlineKeyboardButton',
  text = value.text,
  type = {
query = value.query,
luatele = 'inlineKeyboardButtonTypeSwitchInline',
}
}
end
end
end
return result
elseif _type == 'keyboard' then
local result = {
luatele = 'replyMarkupShowKeyboard',
resize_keyboard = input.resize,
one_time = input.one_time,
is_personal = input.is_personal,
rows = {
}
}
for _, rows in pairs(input.data) do
local new_id = #result.rows + 1
result.rows[new_id] = {}
for key, value in pairs(rows) do
  local rows_new_id = #result.rows[new_id] + 1
if type(value.type) == 'string' then
value.type = string.lower(value.type)
if value.type == 'requestlocation' and value.text then
result.rows[new_id][rows_new_id] = {
  type = {
luatele = 'keyboardButtonTypeRequestLocation'
},
luatele = 'keyboardButton',
  text = value.text
}
  elseif value.type == 'requestphone' and value.text then
result.rows[new_id][rows_new_id] = {
  type = {
luatele = 'keyboardButtonTypeRequestPhoneNumber'
},
luatele = 'keyboardButton',
  text = value.text
}
  elseif value.type == 'requestpoll' and value.text then
result.rows[new_id][rows_new_id] = {
  type = {
luatele = 'keyboardButtonTypeRequestPoll',
force_regular = value.force_regular,
force_quiz = value.force_quiz
},
luatele = 'keyboardButton',
  text = value.text
}
  elseif value.type == 'text' and value.text then
result.rows[new_id][rows_new_id] = {
  type = {
luatele = 'keyboardButtonTypeText'
},
luatele = 'keyboardButton',
  text = value.text
}
end
end
end
end
return result
elseif _type == 'forcereply' then
return {
luatele = 'replyMarkupForceReply',
is_personal = input.is_personal
}
elseif _type == 'remove' then
return {
luatele = 'replyMarkupRemoveKeyboard',
is_personal = input.is_personal
}
end
end
function luatele_function.addProxy(proxy_type, server, port, username, password_secret, http_only)
if type(proxy_type) ~= 'string' then
return {
luatele = false
}
end
local proxy_type = string.lower(proxy_type)
if proxy_type == 'mtproto' then
_type_ = {
luatele = 'proxyTypeMtproto',
secret = password_secret
}
elseif proxy_Type == 'socks5' then
_type_ = {
luatele = 'proxyTypeSocks5',
username = username,
password = password_secret
}
elseif proxy_Type == 'http' then
_type_ = {
luatele = 'proxyTypeHttp',
username = username,
password = password_secret,
http_only = http_only
}
  else
return {
luatele = false
}
end
return function_core.run_table{
luatele = 'addProxy',
server = server,
port = port,
type = _type_
}
end
function luatele_function.enableProxy(proxy_id)
return function_core.run_table{
 luatele = 'enableProxy',
proxy_id = proxy_id
}
end
function luatele_function.pingProxy(proxy_id)
return function_core.run_table{
 luatele = 'pingProxy',
proxy_id = proxy_id
}
end
function luatele_function.disableProxy(proxy_id)
return function_core.run_table{
 luatele = 'disableProxy',
proxy_id = proxy_id
}
end
function luatele_function.getProxies()
return function_core.run_table{
luatele = 'getProxies'
}
end
function luatele_function.getChatId(chat_id)
local chat_id = tostring(chat_id)
if chat_id:match('^-100') then
return {
id = string.sub(chat_id, 5),
type = 'supergroup'
}
  else
local basicgroup_id = string.sub(chat_id, 2)
return {
id = string.sub(chat_id, 2),
type = 'basicgroup'
}
end
end
function luatele_function.getInputFile(file, conversion_str, expected_size)
local str = tostring(file)
if (conversion_str and expectedsize) then
return {
luatele = 'inputFileGenerated',
original_path = tostring(file),
conversion = tostring(conversion_str),
expected_size = expected_size
}
  else
if str:match('/') then
return {
luatele = 'inputFileLocal',
  path = file
}
  elseif str:match('^%d+$') then
return {
luatele = 'inputFileId',
  id = file
}
else
return {
luatele = 'inputFileRemote',
  id = file
}
end
end
end
function luatele_function.getParseMode(parse_mode)
if parse_mode then
local mode = parse_mode:lower()
if mode == 'markdown' or mode == 'md' then
return {
luatele = 'textParseModeMarkdown',
}
elseif mode == 'html' or mode == 'lg' then
return {
luatele = 'textParseModeHTML'
}
end
end
end
function luatele_function.parseTextEntities(text, parse_mode)
if type(parse_mode) == 'string' and string.lower(parse_mode) == 'lg' then
for txt in text:gmatch('%%{(.-)}') do
local _text, text_type = txt:match('(.*),(.*)')
local txt = string.gsub(txt,'+','++')
local text_type = string.gsub(text_type,' ','')
if type(_text) == 'string' and type(text_type) == 'string' then
  for key, value in pairs({['<'] = '&lt;',['>'] = '&gt;'}) do
_text = string.gsub(_text, key, value)
end
if (string.lower(text_type) == 'b' or string.lower(text_type) == 'i' or string.lower(text_type) == 'c') then
local text_type = string.lower(text_type)
local text_type = text_type == 'c' and 'code' or text_type
text = string.gsub(text,'%%{'..txt..'}','<'..text_type..'>'.._text..'</'..text_type..'>')
  else
if type(tonumber(text_type)) == 'number' then
link = 'tg://user?id='..text_type
else
link = text_type
end
text = string.gsub(text, '%%{'..txt..'}', '<a href="'..link..'">'.._text..'</a>')
end
end
end
end
return function_core.run_table{
luatele = 'parseTextEntities',
text = tostring(text),
parse_mode = luatele_function.getParseMode(parse_mode)
}
end
function luatele_function.vectorize(table)
if type(table) == 'table' then
return table
  else
return {
table
}
end
end
function luatele_function.setLimit(limit, num)
local limit = tonumber(limit)
local number = tonumber(num or limit)
return (number >= limit) and limit or number
end
function luatele_function.sendMessage(chat_id, reply_to_message_id, input_message_content, parse_mode, disable_notification, from_background, reply_markup)
local luatele_body, message = {
luatele = 'sendMessage',
chat_id = chat_id,
reply_to_message_id = reply_to_message_id or 0,
disable_notification = disable_notification or 0,
from_background = from_background or 1,
reply_markup = reply_markup,
input_message_content = input_message_content
}, {}
if input_message_content.text then
text = input_message_content.text.text
elseif input_message_content.caption then
text = input_message_content.caption.text
end
if text then
if parse_mode then
local result = luatele_function.parseTextEntities(text, parse_mode)
if luatele_body.input_message_content.text then
luatele_body.input_message_content.text = result
else
luatele_body.input_message_content.caption = result
end
return function_core.run_table(luatele_body)
else
while #text > 4096 do
  text = string.sub(text, 4096, #text)
  message[#message + 1] = text
end
message[#message + 1] = text
for i = 1, #message do
if input_message_content.text and input_message_content.text.text then
luatele_body.input_message_content.text.text = message[i]
elseif input_message_content.caption and input_message_content.caption.text then
luatele_body.input_message_content.caption.text = message[i]
end
return function_core.run_table(luatele_body)
end
end
  else
return function_core.run_table(luatele_body)
end
end
function luatele_function.logOut()
return function_core.run_table{
luatele = 'logOut'
}
end
function luatele_function.getPasswordState()
return function_core.run_table{
luatele = 'getPasswordState'
}
end
function luatele_function.setPassword(old_password, new_password, new_hint, set_recovery_email_address, new_recovery_email_address)
return function_core.run_table{
old_password = tostring(old_password),
new_password = tostring(new_password),
new_hint = tostring(new_hint),
set_recovery_email_address = set_recovery_email_address,
new_recovery_email_address = tostring(new_recovery_email_address)
}
end
function luatele_function.getRecoveryEmailAddress(password)
return function_core.run_table{
luatele = 'getRecoveryEmailAddress',
password = tostring(password)
}
end
function luatele_function.setRecoveryEmailAddress(password, new_recovery_email_address)
return function_core.run_table{
luatele = 'setRecoveryEmailAddress',
password = tostring(password),
new_recovery_email_address = tostring(new_recovery_email_address)
}
end
function luatele_function.requestPasswordRecovery()
return function_core.run_table{
luatele = 'requestPasswordRecovery'
}
end
function luatele_function.recoverPassword(recovery_code)
return function_core.run_table{
luatele = 'recoverPassword',
recovery_code = tostring(recovery_code)
}
end
function luatele_function.createTemporaryPassword(password, valid_for)
local valid_for = valid_for > 86400 and 86400 or valid_for
return function_core.run_table{
luatele = 'createTemporaryPassword',
password = tostring(password),
valid_for = valid_for
}
end
function luatele_function.getTemporaryPasswordState()
return function_core.run_table{
luatele = 'getTemporaryPasswordState'
}
end
function luatele_function.getMe()
return function_core.run_table{
luatele = 'getMe'
}
end
function luatele_function.getUser(user_id)
return function_core.run_table{
luatele = 'getUser',
user_id = user_id
}
end
function luatele_function.getUserFullInfo(user_id)
return function_core.run_table{
luatele = 'getUserFullInfo',
user_id = user_id
}
end
function luatele_function.getBasicGroup(basic_group_id)
return function_core.run_table{
luatele = 'getBasicGroup',
basic_group_id = luatele_function.getChatId(basic_group_id).id
}
end
function luatele_function.getBasicGroupFullInfo(basic_group_id)
return function_core.run_table{
luatele = 'getBasicGroupFullInfo',
basic_group_id = luatele_function.getChatId(basic_group_id).id
}
end
function luatele_function.getSupergroup(supergroup_id)
return function_core.run_table{
luatele = 'getSupergroup',
supergroup_id = luatele_function.getChatId(supergroup_id).id
}
end
function luatele_function.getSupergroupFullInfo(supergroup_id)
return function_core.run_table{
luatele = 'getSupergroupFullInfo',
supergroup_id = luatele_function.getChatId(supergroup_id).id
}
end
function luatele_function.getSecretChat(secret_chat_id)
return function_core.run_table{
luatele = 'getSecretChat',
secret_chat_id = secret_chat_id
}
end
function luatele_function.getChat(chat_id)
return function_core.run_table{
luatele = 'getChat',
chat_id = chat_id
}
end
function luatele_function.getMessage(chat_id, message_id)
return function_core.run_table{
luatele = 'getMessage',
chat_id = chat_id,
message_id = message_id
}
end
function luatele_function.getRepliedMessage(chat_id, message_id)
return function_core.run_table{
luatele = 'getRepliedMessage',
chat_id = chat_id,
message_id = message_id
}
end
function luatele_function.getChatPinnedMessage(chat_id)
return function_core.run_table{
luatele = 'getChatPinnedMessage',
chat_id = chat_id
}
end
function luatele_function.unpinAllChatMessages(chat_id)
return function_core.run_table{
luatele = 'unpinAllChatMessages',
chat_id = chat_id
}
end
function luatele_function.getMessages(chat_id, message_ids)
return function_core.run_table{
luatele = 'getMessages',
chat_id = chat_id,
message_ids = luatele_function.vectorize(message_ids)
}
end
function luatele_function.getFile(file_id)
return function_core.run_table{
luatele = 'getFile',
file_id = file_id
}
end
function luatele_function.getRemoteFile(remote_file_id, file_type)
return function_core.run_table{
luatele = 'getRemoteFile',
remote_file_id = tostring(remote_file_id),
file_type = {
luatele = 'fileType' .. file_type or 'Unknown'
}
}
end
function luatele_function.getChats(chat_list, offset_order, offset_chat_id, limit)
local limit = limit or 20
local offset_order = offset_order or '9223372036854775807'
local offset_chat_id = offset_chat_id or 0
local filter = (string.lower(tostring(chat_list)) == 'archive') and 'chatListArchive' or 'chatListMain'
return function_core.run_table{
luatele = 'getChats',
offset_order = offset_order,
offset_chat_id = offset_chat_id,
limit = luatele_function.setLimit(100, limit),
chat_list = {
luatele = filter
}
}
end
function luatele_function.searchPublicChat(username)
return function_core.run_table{
luatele = 'searchPublicChat',
username = tostring(username)
}
end
function luatele_function.searchPublicChats(query)
return function_core.run_table{
luatele = 'searchPublicChats',
query = tostring(query)
}
end
function luatele_function.searchChats(query, limit)
return function_core.run_table{
luatele = 'searchChats',
query = tostring(query),
limit = limit
}
end
function luatele_function.checkChatUsername(chat_id, username)
return function_core.run_table{
luatele = 'checkChatUsername',
chat_id = chat_id,
username = tostring(username)
}
end
function luatele_function.searchChatsOnServer(query, limit)
return function_core.run_table{
luatele = 'searchChatsOnServer',
query = tostring(query),
limit = limit
}
end
function luatele_function.clearRecentlyFoundChats()
return function_core.run_table{
luatele = 'clearRecentlyFoundChats'
}
end
function luatele_function.getTopChats(category, limit)
return function_core.run_table{
luatele = 'getTopChats',
category = {
luatele = 'topChatCategory' .. category
},
limit = luatele_function.setLimit(30, limit)
}
end
function luatele_function.removeTopChat(category, chat_id)
return function_core.run_table{
luatele = 'removeTopChat',
category = {
luatele = 'topChatCategory' .. category
},
chat_id = chat_id
}
end
function luatele_function.addRecentlyFoundChat(chat_id)
return function_core.run_table{
luatele = 'addRecentlyFoundChat',
chat_id = chat_id
}
end
function luatele_function.getCreatedPublicChats()
return function_core.run_table{
luatele = 'getCreatedPublicChats'
}
end
function luatele_function.removeRecentlyFoundChat(chat_id)
return function_core.run_table{
luatele = 'removeRecentlyFoundChat',
chat_id = chat_id
}
end
function luatele_function.getChatHistory(chat_id, from_message_id, offset, limit, only_local)
return function_core.run_table{
luatele = 'getChatHistory',
chat_id = chat_id,
from_message_id = from_message_id,
offset = offset,
limit = luatele_function.setLimit(100, limit),
only_local = only_local
}
end
function luatele_function.getGroupsInCommon(user_id, offset_chat_id, limit)
return function_core.run_table{
luatele = 'getGroupsInCommon',
user_id = user_id,
offset_chat_id = offset_chat_id or 0,
limit = luatele_function.setLimit(100, limit)
}
end
function luatele_function.searchMessages(query, offset_date, offset_chat_id, offset_message_id, limit)
return function_core.run_table{
luatele = 'searchMessages',
query = tostring(query),
offset_date = offset_date or 0,
offset_chat_id = offset_chat_id or 0,
offset_message_id = offset_message_id or 0,
limit = luatele_function.setLimit(100, limit)
}
end
function luatele_function.searchChatMessages(chat_id, query, filter, sender_user_id, from_message_id, offset, limit)
return function_core.run_table{
luatele = 'searchChatMessages',
chat_id = chat_id,
query = tostring(query),
sender_user_id = sender_user_id or 0,
from_message_id = from_message_id or 0,
offset = offset or 0,
limit = luatele_function.setLimit(100, limit),
filter = {
luatele = 'searchMessagesFilter' .. filter
}
}
end
function luatele_function.searchSecretMessages(chat_id, query, from_search_id, limit, filter)
local filter = filter or 'Empty'
return function_core.run_table{
luatele = 'searchSecretMessages',
chat_id = chat_id or 0,
query = tostring(query),
from_search_id = from_search_id or 0,
limit = luatele_function.setLimit(100, limit),
filter = {
luatele = 'searchMessagesFilter' .. filter
}
}
end
function luatele_function.deleteChatHistory(chat_id, remove_from_chat_list)
return function_core.run_table{
luatele = 'deleteChatHistory',
chat_id = chat_id,
remove_from_chat_list = remove_from_chat_list
}
end
function luatele_function.searchCallMessages(from_message_id, limit, only_missed)
return function_core.run_table{
luatele = 'searchCallMessages',
from_message_id = from_message_id or 0,
limit = luatele_function.setLimit(100, limit),
only_missed = only_missed
}
end
function luatele_function.getChatMessageByDate(chat_id, date)
return function_core.run_table{
luatele = 'getChatMessageByDate',
chat_id = chat_id,
date = date
}
end
function luatele_function.getPublicMessageLink(chat_id, message_id, for_album)
return function_core.run_table{
luatele = 'getPublicMessageLink',
chat_id = chat_id,
message_id = message_id,
for_album = for_album
}
end
function luatele_function.sendMessageAlbum(chat_id, reply_to_message_id, input_message_contents, disable_notification, from_background)
return function_core.run_table{
luatele = 'sendMessageAlbum',
chat_id = chat_id,
reply_to_message_id = reply_to_message_id or 0,
disable_notification = disable_notification,
from_background = from_background,
input_message_contents = luatele_function.vectorize(input_message_contents)
}
end
function luatele_function.sendBotStartMessage(bot_user_id, chat_id, parameter)
return function_core.run_table{
luatele = 'sendBotStartMessage',
bot_user_id = bot_user_id,
chat_id = chat_id,
parameter = tostring(parameter)
}
end
function luatele_function.sendInlineQueryResultMessage(chat_id, reply_to_message_id, disable_notification, from_background, query_id, result_id)
return function_core.run_table{
luatele = 'sendInlineQueryResultMessage',
chat_id = chat_id,
reply_to_message_id = reply_to_message_id,
disable_notification = disable_notification,
from_background = from_background,
query_id = query_id,
result_id = tostring(result_id)
}
end
function luatele_function.forwardMessages(chat_id, from_chat_id, message_ids, disable_notification, from_background, as_album, send_copy, remove_caption)
return function_core.run_table{
luatele = 'forwardMessages',
chat_id = chat_id,
from_chat_id = from_chat_id,
message_ids = luatele_function.vectorize(message_ids),
disable_notification = disable_notification,
from_background = from_background,
as_album = as_album,
send_copy = send_copy,
remove_caption = remove_caption
}
end
function luatele_function.sendChatSetTtlMessage(chat_id, ttl)
return function_core.run_table{
luatele = 'sendChatSetTtlMessage',
chat_id = chat_id,
ttl = ttl
}
end
function luatele_function.sendChatScreenshotTakenNotification(chat_id)
return function_core.run_table{
luatele = 'sendChatScreenshotTakenNotification',
chat_id = chat_id
}
end
function luatele_function.deleteMessages(chat_id, message_ids, revoke)
return function_core.run_table{
luatele = 'deleteMessages',
chat_id = chat_id,
message_ids = luatele_function.vectorize(message_ids),
revoke = revoke
}
end
function luatele_function.deleteChatMessagesFromUser(chat_id, user_id)
return function_core.run_table{
luatele = 'deleteChatMessagesFromUser',
chat_id = chat_id,
user_id = user_id
}
end
function luatele_function.editMessageText(chat_id, message_id, text, parse_mode, disable_web_page_preview, clear_draft, reply_markup)
local luatele_body = {
luatele = 'editMessageText',
chat_id = chat_id,
message_id = message_id,
reply_markup = reply_markup,
input_message_content = {
luatele = 'inputMessageText',
disable_web_page_preview = disable_web_page_preview,
text = {
  text = text
},
clear_draft = clear_draft
}
}
if parse_mode then
luatele_body.input_message_content.text = luatele_function.parseTextEntities(text, parse_mode)
end
return function_core.run_table(luatele_body)
end
function luatele_function.editMessageCaption(chat_id, message_id, caption, parse_mode, reply_markup)
local luatele_body = {
luatele = 'editMessageCaption',
chat_id = chat_id,
message_id = message_id,
reply_markup = reply_markup,
caption = caption
}
if parse_mode then
luatele_body.caption = luatele_function.parseTextEntities(text,parse_mode)
end
return function_core.run_table(luatele_body)
end
function luatele_function.getTextEntities(text)
return function_core.run_table{
luatele = 'getTextEntities',
text = tostring(text)
}
end
function luatele_function.getFileMimeType(file_name)
return function_core.run_table{
luatele = 'getFileMimeType',
file_name = tostring(file_name)
}
end
function luatele_function.getFileExtension(mime_type)
return function_core.run_table{
luatele = 'getFileExtension',
mime_type = tostring(mime_type)
}
end
function luatele_function.getInlineQueryResults(bot_user_id, chat_id, latitude, longitude, query, offset)
return function_core.run_table{
luatele = 'getInlineQueryResults',
bot_user_id = bot_user_id,
chat_id = chat_id,
user_location = {
luatele = 'location',
latitude = latitude,
longitude = longitude
},
query = tostring(query),
offset = tostring(offset)
}
end
function luatele_function.answerCallbackQuery(callback_query_id, text, show_alert, url, cache_time)
return function_core.run_table{
luatele = 'answerCallbackQuery',
  callback_query_id = callback_query_id,
  show_alert = show_alert,
  cache_time = cache_time,
  text = text,
  url = url,
}
end
function luatele_function.getCallbackQueryAnswer(chat_id, message_id, payload, data, game_short_name)
return function_core.run_table{
luatele = 'getCallbackQueryAnswer',
chat_id = chat_id,
message_id = message_id,
payload = {
luatele = 'callbackQueryPayload' .. payload,
data = data,
game_short_name = game_short_name
}
}
end
function luatele_function.deleteChatReplyMarkup(chat_id, message_id)
return function_core.run_table{
luatele = 'deleteChatReplyMarkup',
chat_id = chat_id,
message_id = message_id
}
end
function luatele_function.sendChatAction(chat_id, action, progress)
return function_core.run_table{
luatele = 'sendChatAction',
chat_id = chat_id,
action = {
luatele = 'chatAction' .. action,
progress = progress or 100
}
}
end
function luatele_function.openChat(chat_id)
return function_core.run_table{
luatele = 'openChat',
chat_id = chat_id
}
end
function luatele_function.closeChat(chat_id)
return function_core.run_table{
luatele = 'closeChat',
chat_id = chat_id
}
end
function luatele_function.viewMessages(chat_id, message_ids, force_read)
return function_core.run_table{
luatele = 'viewMessages',
chat_id = chat_id,
message_ids = luatele_function.vectorize(message_ids),
force_read = force_read
}
end
function luatele_function.openMessageContent(chat_id, message_id)
return function_core.run_table{
luatele = 'openMessageContent',
chat_id = chat_id,
message_id = message_id
}
end
function luatele_function.readAllChatMentions(chat_id)
return function_core.run_table{
luatele = 'readAllChatMentions',
chat_id = chat_id
}
end
function luatele_function.createPrivateChat(user_id, force)
return function_core.run_table{
luatele = 'createPrivateChat',
user_id = user_id,
force = force
}
end
function luatele_function.createBasicGroupChat(basic_group_id, force)
return function_core.run_table{
luatele = 'createBasicGroupChat',
basic_group_id = luatele_function.getChatId(basic_group_id).id,
force = force
}
end
function luatele_function.createSupergroupChat(supergroup_id, force)
return function_core.run_table{
luatele = 'createSupergroupChat',
supergroup_id = luatele_function.getChatId(supergroup_id).id,
force = force
}
end
function luatele_function.createSecretChat(secret_chat_id)
return function_core.run_table{
luatele = 'createSecretChat',
secret_chat_id = secret_chat_id
}
end
function luatele_function.createNewBasicGroupChat(user_ids, title)
return function_core.run_table{
luatele = 'createNewBasicGroupChat',
user_ids = luatele_function.vectorize(user_ids),
title = tostring(title)
}
end
function luatele_function.createNewSupergroupChat(title, is_channel, description)
return function_core.run_table{
luatele = 'createNewSupergroupChat',
title = tostring(title),
is_channel = is_channel,
description = tostring(description)
}
end
function luatele_function.createNewSecretChat(user_id)
return function_core.run_table{
luatele = 'createNewSecretChat',
user_id = tonumber(user_id)
}
end
function luatele_function.upgradeBasicGroupChatToSupergroupChat(chat_id)
return function_core.run_table{
luatele = 'upgradeBasicGroupChatToSupergroupChat',
chat_id = chat_id
}
end
function luatele_function.setChatPermissions(chat_id, can_send_messages, can_send_media_messages, can_send_polls, can_send_other_messages, can_add_web_page_previews, can_change_info, can_invite_users, can_pin_messages)
return function_core.run_table{
luatele = 'setChatPermissions',
chat_id = chat_id,
 permissions = {
can_send_messages = can_send_messages,
can_send_media_messages = can_send_media_messages,
can_send_polls = can_send_polls,
can_send_other_messages = can_send_other_messages,
can_add_web_page_previews = can_add_web_page_previews,
can_change_info = can_change_info,
can_invite_users = can_invite_users,
can_pin_messages = can_pin_messages,
}
}
end
function luatele_function.setChatTitle(chat_id, title)
return function_core.run_table{
luatele = 'setChatTitle',
chat_id = chat_id,
title = tostring(title)
}
end
function luatele_function.setChatPhoto(chat_id, photo)
return function_core.run_table{
luatele = 'setChatPhoto',
chat_id = chat_id,
photo = {luatele = 'inputChatPhotoStatic', photo = getInputFile(photo)}
}
end 
function luatele_function.setChatDraftMessage(chat_id, reply_to_message_id, text, parse_mode, disable_web_page_preview, clear_draft)
local luatele_body = {
luatele = 'setChatDraftMessage',
chat_id = chat_id,
draft_message = {
luatele = 'draftMessage',
reply_to_message_id = reply_to_message_id,
input_message_text = {
luatele = 'inputMessageText',
  disable_web_page_preview = disable_web_page_preview,
  text = {text = text},
  clear_draft = clear_draft
}
}
}
if parse_mode then
luatele_body.draft_message.input_message_text.text = luatele_function.parseTextEntities(text, parse_mode)
end
return function_core.run_table(luatele_body)
end
function luatele_function.toggleChatIsPinned(chat_id, is_pinned)
return function_core.run_table{
luatele = 'toggleChatIsPinned',
chat_id = chat_id,
is_pinned = is_pinned
}
end
function luatele_function.setChatClientData(chat_id, client_data)
return function_core.run_table{
luatele = 'setChatClientData',
chat_id = chat_id,
client_data = tostring(client_data)
}
end
function luatele_function.addChatMember(chat_id, user_id, forward_limit)
return function_core.run_table{
luatele = 'addChatMember',
chat_id = chat_id,
user_id = user_id,
forward_limit = luatele_function.setLimit(300, forward_limit)
}
end
function luatele_function.addChatMembers(chat_id, user_ids)
return function_core.run_table{
luatele = 'addChatMembers',
chat_id = chat_id,
user_ids = luatele_function.vectorize(user_ids)
}
end
function luatele_function.setChatMemberStatus(chat_id, user_id, status, right)
local right = right and luatele_function.vectorize(right) or {}
local status = string.lower(status)
if status == 'creator' then
chat_member_status = {
luatele = 'chatMemberStatusCreator',
is_member = right[1] or 1
}
elseif status == 'administrator' then
chat_member_status = {
luatele = 'chatMemberStatusAdministrator',
can_be_edited = right[1] or 1,
can_change_info = right[2] or 0,
can_post_messages = right[3] or 1,
can_edit_messages = right[4] or 1,
can_delete_messages = right[5] or 0,
can_invite_users = right[6] or 1,
can_restrict_members = right[7] or 0,
can_pin_messages = right[8] or 0,
can_manage_video_chats = right[9] or 0,
is_anonymous = right[10] or 0,
can_manage_chat = right[11] or 0,
can_promote_members = right[12] or 0,
custom_title = tostring(right[13]) or ''
}
elseif status == 'restricted' then
chat_member_status = {
permissions = {
luatele = 'chatPermissions',
  can_send_polls = right[2] or 0,
  can_add_web_page_previews = right[3] or 1,
  can_change_info = right[4] or 0,
  can_invite_users = right[5] or 1,
  can_pin_messages = right[6] or 0,
  can_send_media_messages = right[7] or 1,
  can_send_messages = right[8] or 1,
  can_send_other_messages = right[9] or 1
},
is_member = right[1] or 1,
restricted_until_date = right[10] or 0,
luatele = 'chatMemberStatusRestricted'
}
elseif status == 'banned' then
chat_member_status = {
luatele = 'chatMemberStatusBanned',
banned_until_date = right[1] or 0
}
end
return function_core.run_table{
luatele = 'setChatMemberStatus',
chat_id = chat_id,
member_id = {_='messageSenderUser', user_id = user_id},
status = chat_member_status or {}
}
end
function luatele_function.SetAdmin(chat_id, user_id,right)
chat_member_status = {
luatele = 'chatMemberStatusAdministrator',
can_be_edited = right[1] or 1,
can_change_info = right[2] or 1,
can_post_messages = right[3] or 1,
can_edit_messages = right[4] or 1,
can_delete_messages = right[5] or 1,
can_invite_users = right[6] or 1,
can_restrict_members = right[7] or 1,
can_pin_messages = right[8] or 1,
can_manage_video_chats = right[9] or 1,
is_anonymous = right[10] or 1,
can_manage_chat = right[11] or 1,
can_promote_members = right[12] or 0,
custom_title = tostring(right[13]) or ''
}
return function_core.run_table{
luatele = 'setChatMemberStatus',
chat_id = chat_id,
member_id = {_='messageSenderUser', user_id = user_id},
status = chat_member_status or {}
}
end

function luatele_function.getChatMember(chat_id, user_id)
return function_core.run_table{
luatele = 'getChatMember',
chat_id = chat_id,
member_id = {_='messageSenderUser', user_id = user_id}
}
end 
function luatele_function.searchChatMembers(chat_id, query, limit)
return function_core.run_table{
luatele = 'searchChatMembers',
chat_id = chat_id,
query = tostring(query),
limit = luatele_function.setLimit(200, limit)
}
end
function luatele_function.getChatAdministrators(chat_id)
return function_core.run_table{
luatele = 'getChatAdministrators',
chat_id = chat_id
}
end
function luatele_function.setPinnedChats(chat_ids)
return function_core.run_table{
luatele = 'setPinnedChats',
chat_ids = luatele_function.vectorize(chat_ids)
}
end
function luatele_function.downloadFile(file_id, priority)
return function_core.run_table{
luatele = 'downloadFile',
file_id = file_id,
priority = priority or 32
}
end
function luatele_function.cancelDownloadFile(file_id, only_if_pending)
return function_core.run_table{
luatele = 'cancelDownloadFile',
file_id = file_id,
only_if_pending = only_if_pending
}
end
function luatele_function.uploadFile(file, file_type, priority)
local ftype = file_type or 'Unknown'
return function_core.run_table{
luatele = 'uploadFile',
file = luatele_function.getInputFile(file),
file_type = {
luatele = 'fileType' .. ftype
},
priority = priority or 32
}
end
function luatele_function.cancelUploadFile(file_id)
return function_core.run_table{
luatele = 'cancelUploadFile',
file_id = file_id
}
end
function luatele_function.deleteFile(file_id)
return function_core.run_table{
luatele = 'deleteFile',
file_id = file_id
}
end
function luatele_function.generateChatInviteLink(chat_id,name,expire_date,member_limit,creates_join_request)
return function_core.run_table{
luatele = 'createChatInviteLink',
chat_id = chat_id,
name = tostring(name),
expire_date = tonumber(expire_date),
member_limit = tonumber(member_limit),
creates_join_request = creates_join_request
}
end 
function luatele_function.joinChatByUsernam(username)
if type(username) == 'string' and 5 <= #username then
local result = luatele_function.searchPublicChat(username)
if result.type and result.type.luatele == 'chatTypeSupergroup' then
return function_core.run_table{
luatele = 'joinChat',
  chat_id = result.id
}
else
return result
end
end
end
function luatele_function.checkChatInviteLink(invite_link)
return function_core.run_table{
luatele = 'checkChatInviteLink',
invite_link = tostring(invite_link)
}
end
function luatele_function.joinChatByInviteLink(invite_link)
return function_core.run_table{
luatele = 'joinChatByInviteLink',
invite_link = tostring(invite_link)
}
end
function luatele_function.leaveChat(chat_id)
return function_core.run_table{
luatele = 'leaveChat',
chat_id = chat_id
}
end
function luatele_function.createCall(user_id, udp_p2p, udp_reflector, min_layer, max_layer)
return function_core.run_table{
luatele = 'createCall',
user_id = user_id,
protocol = {
luatele = 'callProtocol',
udp_p2p = udp_p2p,
udp_reflector = udp_reflector,
min_layer = min_layer or 65,
max_layer = max_layer or 65
}
}
end
function luatele_function.acceptCall(call_id, udp_p2p, udp_reflector, min_layer, max_layer)
return function_core.run_table{
luatele = 'acceptCall',
call_id = call_id,
protocol = {
luatele = 'callProtocol',
udp_p2p = udp_p2p,
udp_reflector = udp_reflector,
min_layer = min_layer or 65,
max_layer = max_layer or 65
}
}
end
function luatele_function.blockUser(user_id)
return function_core.run_table{
luatele = 'blockUser',
user_id = user_id
}
end
function luatele_function.unblockUser(user_id)
return function_core.run_table{
luatele = 'unblockUser',
user_id = user_id
}
end
function luatele_function.getBlockedUsers(offset, limit)
return function_core.run_table{
luatele = 'getBlockedUsers',
offset = offset or 0,
limit = luatele_function.setLimit(100, limit)
}
end
function luatele_function.getContacts()
return function_core.run_table{
luatele = 'getContacts'
}
end
function luatele_function.importContacts(contacts)
local result = {}
  for key, value in pairs(contacts) do
result[#result + 1] = {
luatele = 'contact',
phone_number = tostring(value.phone_number),
first_name = tostring(value.first_name),
last_name = tostring(value.last_name),
user_id = value.user_id or 0
}
end
return function_core.run_table{
luatele = 'importContacts',
contacts = result
}
end
function luatele_function.searchContacts(query, limit)
return function_core.run_table{
luatele = 'searchContacts',
query = tostring(query),
limit = limit
}
end
function luatele_function.removeContacts(user_ids)
return function_core.run_table{
luatele = 'removeContacts',
user_ids = luatele_function.vectorize(user_ids)
}
end
function luatele_function.getImportedContactCount()
return function_core.run_table{
luatele = 'getImportedContactCount'
}
end
function luatele_function.changeImportedContacts(phone_number, first_name, last_name, user_id)
return function_core.run_table{
luatele = 'changeImportedContacts',
contacts = {
luatele = 'contact',
phone_number = tostring(phone_number),
first_name = tostring(first_name),
last_name = tostring(last_name),
user_id = user_id or 0
}
}
end
function luatele_function.clearImportedContacts()
return function_core.run_table{
luatele = 'clearImportedContacts'
}
end
function luatele_function.getUserProfilePhotos(user_id, offset, limit)
return function_core.run_table{
luatele = 'getUserProfilePhotos',
user_id = user_id,
offset = offset or 0,
limit = luatele_function.setLimit(100, limit)
}
end
function luatele_function.getStickers(emoji, limit)
return function_core.run_table{
luatele = 'getStickers',
emoji = tostring(emoji),
limit = luatele_function.setLimit(100, limit)
}
end
function luatele_function.searchStickers(emoji, limit)
return function_core.run_table{
luatele = 'searchStickers',
emoji = tostring(emoji),
limit = limit
}
end
function luatele_function.getArchivedStickerSets(is_masks, offset_sticker_set_id, limit)
return function_core.run_table{
luatele = 'getArchivedStickerSets',
is_masks = is_masks,
offset_sticker_set_id = offset_sticker_set_id,
limit = limit
}
end
function luatele_function.getTrendingStickerSets()
return function_core.run_table{
luatele = 'getTrendingStickerSets'
}
end
function luatele_function.getAttachedStickerSets(file_id)
return function_core.run_table{
luatele = 'getAttachedStickerSets',
file_id = file_id
}
end
function luatele_function.getStickerSet(set_id)
return function_core.run_table{
luatele = 'getStickerSet',
set_id = set_id
}
end
function luatele_function.searchStickerSet(name)
return function_core.run_table{
luatele = 'searchStickerSet',
name = tostring(name)
}
end
function luatele_function.searchInstalledStickerSets(is_masks, query, limit)
return function_core.run_table{
luatele = 'searchInstalledStickerSets',
is_masks = is_masks,
query = tostring(query),
limit = limit
}
end
function luatele_function.searchStickerSets(query)
return function_core.run_table{
luatele = 'searchStickerSets',
query = tostring(query)
}
end
function luatele_function.changeStickerSet(set_id, is_installed, is_archived)
return function_core.run_table{
luatele = 'changeStickerSet',
set_id = set_id,
is_installed = is_installed,
is_archived = is_archived
}
end
function luatele_function.viewTrendingStickerSets(sticker_set_ids)
return function_core.run_table{
luatele = 'viewTrendingStickerSets',
sticker_set_ids = luatele_function.vectorize(sticker_set_ids)
}
end
function luatele_function.reorderInstalledStickerSets(is_masks, sticker_set_ids)
return function_core.run_table{
luatele = 'reorderInstalledStickerSets',
is_masks = is_masks,
sticker_set_ids = luatele_function.vectorize(sticker_set_ids)
}
end
function luatele_function.getRecentStickers(is_attached)
return function_core.run_table{
luatele = 'getRecentStickers',
is_attached = is_attached
}
end
function luatele_function.addRecentSticker(is_attached, sticker)
return function_core.run_table{
luatele = 'addRecentSticker',
is_attached = is_attached,
sticker = luatele_function.getInputFile(sticker)
}
end
function luatele_function.clearRecentStickers(is_attached)
return function_core.run_table{
luatele = 'clearRecentStickers',
is_attached = is_attached
}
end
function luatele_function.getFavoriteStickers()
return function_core.run_table{
luatele = 'getFavoriteStickers'
}
end
function luatele_function.addFavoriteSticker(sticker)
return function_core.run_table{
luatele = 'addFavoriteSticker',
sticker = luatele_function.getInputFile(sticker)
}
end
function luatele_function.removeFavoriteSticker(sticker)
return function_core.run_table{
luatele = 'removeFavoriteSticker',
sticker = luatele_function.getInputFile(sticker)
}
end
function luatele_function.getStickerEmojis(sticker)
return function_core.run_table{
luatele = 'getStickerEmojis',
sticker = luatele_function.getInputFile(sticker)
}
end
function luatele_function.getSavedAnimations()
return function_core.run_table{
luatele = 'getSavedAnimations'
}
end
function luatele_function.addSavedAnimation(animation)
return function_core.run_table{
luatele = 'addSavedAnimation',
animation = luatele_function.getInputFile(animation)
}
end
function luatele_function.removeSavedAnimation(animation)
return function_core.run_table{
luatele = 'removeSavedAnimation',
animation = luatele_function.getInputFile(animation)
}
end
function luatele_function.getRecentInlineBots()
return function_core.run_table{
luatele = 'getRecentInlineBots'
}
end
function luatele_function.searchHashtags(prefix, limit)
return function_core.run_table{
luatele = 'searchHashtags',
prefix = tostring(prefix),
limit = limit
}
end
function luatele_function.removeRecentHashtag(hashtag)
return function_core.run_table{
luatele = 'removeRecentHashtag',
hashtag = tostring(hashtag)
}
end
function luatele_function.getWebPagePreview(text)
return function_core.run_table{
luatele = 'getWebPagePreview',
text = {
text = text
}
}
end
function luatele_function.getWebPageInstantView(url, force_full)
return function_core.run_table{
luatele = 'getWebPageInstantView',
url = tostring(url),
force_full = force_full
}
end
function luatele_function.getNotificationSettings(scope, chat_id)
return function_core.run_table{
luatele = 'getNotificationSettings',
scope = {
luatele = 'notificationSettingsScope' .. scope,
chat_id = chat_id
}
}
end
function luatele_function.setNotificationSettings(scope, chat_id, mute_for, sound, show_preview)
return function_core.run_table{
luatele = 'setNotificationSettings',
scope = {
luatele = 'notificationSettingsScope' .. scope,
chat_id = chat_id
},
notification_settings = {
luatele = 'notificationSettings',
mute_for = mute_for,
sound = tostring(sound),
show_preview = show_preview
}
}
end
function luatele_function.resetAllNotificationSettings()
return function_core.run_table{
luatele = 'resetAllNotificationSettings'
}
end
function luatele_function.setProfilePhoto(photo)
return function_core.run_table{
luatele = 'setProfilePhoto',
photo = luatele_function.getInputFile(photo)
}
end
function luatele_function.deleteProfilePhoto(profile_photo_id)
return function_core.run_table{
luatele = 'deleteProfilePhoto',
profile_photo_id = profile_photo_id
}
end
function luatele_function.setName(first_name, last_name)
return function_core.run_table{
luatele = 'setName',
first_name = tostring(first_name),
last_name = tostring(last_name)
}
end
function luatele_function.setBio(bio)
return function_core.run_table{
luatele = 'setBio',
bio = tostring(bio)
}
end
function luatele_function.setUsername(username)
return function_core.run_table{
luatele = 'setUsername',
username = tostring(username)
}
end
function luatele_function.getActiveSessions()
return function_core.run_table{
luatele = 'getActiveSessions'
}
end
function luatele_function.terminateAllOtherSessions()
return function_core.run_table{
luatele = 'terminateAllOtherSessions'
}
end
function luatele_function.terminateSession(session_id)
return function_core.run_table{
luatele = 'terminateSession',
session_id = session_id
}
end
function luatele_function.toggleBasicGroupAdministrators(basic_group_id, everyone_is_administrator)
return function_core.run_table{
luatele = 'toggleBasicGroupAdministrators',
basic_group_id = luatele_function.getChatId(basic_group_id).id,
everyone_is_administrator = everyone_is_administrator
}
end
function luatele_function.setSupergroupUsername(supergroup_id, username)
return function_core.run_table{
luatele = 'setSupergroupUsername',
supergroup_id = luatele_function.getChatId(supergroup_id).id,
username = tostring(username)
}
end
function luatele_function.setSupergroupStickerSet(supergroup_id, sticker_set_id)
return function_core.run_table{
luatele = 'setSupergroupStickerSet',
supergroup_id = luatele_function.getChatId(supergroup_id).id,
sticker_set_id = sticker_set_id
}
end
function luatele_function.toggleSupergroupInvites(supergroup_id, anyone_can_invite)
return function_core.run_table{
luatele = 'toggleSupergroupInvites',
supergroup_id = luatele_function.getChatId(supergroup_id).id,
anyone_can_invite = anyone_can_invite
}
end
function luatele_function.toggleSupergroupSignMessages(supergroup_id, sign_messages)
return function_core.run_table{
luatele = 'toggleSupergroupSignMessages',
supergroup_id = luatele_function.getChatId(supergroup_id).id,
sign_messages = sign_messages
}
end
function luatele_function.toggleSupergroupIsAllHistoryAvailable(supergroup_id, is_all_history_available)
return function_core.run_table{
luatele = 'toggleSupergroupIsAllHistoryAvailable',
supergroup_id = luatele_function.getChatId(supergroup_id).id,
is_all_history_available = is_all_history_available
}
end
function luatele_function.setChatDescription(chat_id, description)
return function_core.run_table{
luatele = 'setChatDescription',
chat_id = chat_id,
description = tostring(description)
}
end
function luatele_function.pinChatMessage(chat_id, message_id, disable_notification)
return function_core.run_table{
luatele = 'pinChatMessage',
chat_id = chat_id,
message_id = message_id,
disable_notification = disable_notification
}
end
function luatele_function.unpinChatMessage(chat_id)
return function_core.run_table{
luatele = 'unpinChatMessage',
chat_id = chat_id
}
end
function luatele_function.reportSupergroupSpam(supergroup_id, user_id, message_ids)
return function_core.run_table{
luatele = 'reportSupergroupSpam',
supergroup_id = luatele_function.getChatId(supergroup_id).id,
user_id = user_id,
message_ids = luatele_function.vectorize(message_ids)
}
end
function luatele_function.getSupergroupMembers(supergroup_id, filter, query, offset, limit)
local filter = filter or 'Recent'
return function_core.run_table{
luatele = 'getSupergroupMembers',
supergroup_id = luatele_function.getChatId(supergroup_id).id,
filter = {
luatele = 'supergroupMembersFilter' .. filter,
query = query
},
offset = offset or 0,
limit = luatele_function.setLimit(200, limit)
}
end
function luatele_function.deleteSupergroup(supergroup_id)
return function_core.run_table{
luatele = 'deleteSupergroup',
supergroup_id = luatele_function.getChatId(supergroup_id).id
}
end
function luatele_function.closeSecretChat(secret_chat_id)
return function_core.run_table{
luatele = 'closeSecretChat',
secret_chat_id = secret_chat_id
}
end
function luatele_function.getChatEventLog(chat_id, query, from_event_id, limit, filters, user_ids)
local filters = filters or {1,1,1,1,1,1,1,1,1,1}
return function_core.run_table{
luatele = 'getChatEventLog',
chat_id = chat_id,
query = tostring(query) or '',
from_event_id = from_event_id or 0,
limit = luatele_function.setLimit(100, limit),
filters = {
luatele = 'chatEventLogFilters',
message_edits = filters[0],
message_deletions = filters[1],
message_pins = filters[2],
member_joins = filters[3],
member_leaves = filters[4],
member_invites = filters[5],
member_promotions = filters[6],
member_restrictions = filters[7],
info_changes = filters[8],
setting_changes = filters[9]
},
user_ids = luatele_function.vectorize(user_ids)
}
end
function luatele_function.getSavedOrderInfo()
return function_core.run_table{
luatele = 'getSavedOrderInfo'
}
end
function luatele_function.deleteSavedOrderInfo()
return function_core.run_table{
luatele = 'deleteSavedOrderInfo'
}
end
function luatele_function.deleteSavedCredentials()
return function_core.run_table{
luatele = 'deleteSavedCredentials'
}
end
function luatele_function.getSupportUser()
return function_core.run_table{
luatele = 'getSupportUser'
}
end
function luatele_function.getWallpapers()
return function_core.run_table{
luatele = 'getWallpapers'
}
end
function luatele_function.setUserPrivacySettingRules(setting, rules, allowed_user_ids, restricted_user_ids)
local setting_rules = {
[0] = {
luatele = 'userPrivacySettingRule' .. rules
}
}
if allowed_user_ids then
setting_rules[#setting_rules + 1] = {
{
luatele = 'userPrivacySettingRuleAllowUsers',
  user_ids = luatele_function.vectorize(allowed_user_ids)
}
}
elseif restricted_user_ids then
setting_rules[#setting_rules + 1] = {
{
luatele = 'userPrivacySettingRuleRestrictUsers',
  user_ids = luatele_function.vectorize(restricted_user_ids)
}
}
end
return function_core.run_table{
luatele = 'setUserPrivacySettingRules',
setting = {
luatele = 'userPrivacySetting' .. setting
},
rules = {
luatele = 'userPrivacySettingRules',
rules = setting_rules
}
}
end
function luatele_function.getUserPrivacySettingRules(setting)
return function_core.run_table{
luatele = 'getUserPrivacySettingRules',
setting = {
luatele = 'userPrivacySetting' .. setting
}
}
end
function luatele_function.getOption(name)
return function_core.run_table{
luatele = 'getOption',
name = tostring(name)
}
end
function luatele_function.setOption(name, option_value, value)
return function_core.run_table{
luatele = 'setOption',
name = tostring(name),
value = {
luatele = 'optionValue' .. option_value,
value = value
}
}
end
function luatele_function.setAccountTtl(ttl)
return function_core.run_table{
luatele = 'setAccountTtl',
ttl = {
luatele = 'accountTtl',
days = ttl
}
}
end
function luatele_function.getAccountTtl()
return function_core.run_table{
luatele = 'getAccountTtl'
}
end
function luatele_function.deleteAccount(reason)
return function_core.run_table{
luatele = 'deleteAccount',
reason = tostring(reason)
}
end
function luatele_function.getChatReportSpamState(chat_id)
return function_core.run_table{
luatele = 'getChatReportSpamState',
chat_id = chat_id
}
end
function luatele_function.reportChat(chat_id, reason, text, message_ids)
return function_core.run_table{
luatele = 'reportChat',
chat_id = chat_id,
reason = {
luatele = 'chatReportReason' .. reason,
text = text
},
message_ids = luatele_function.vectorize(message_ids)
}
end
function luatele_function.getStorageStatistics(chat_limit)
return function_core.run_table{
luatele = 'getStorageStatistics',
chat_limit = chat_limit
}
end
function luatele_function.getStorageStatisticsFast()
return function_core.run_table{
luatele = 'getStorageStatisticsFast'
}
end
function luatele_function.optimizeStorage(size, ttl, count, immunity_delay, file_type, chat_ids, exclude_chat_ids, chat_limit)
local file_type = file_type or ''
return function_core.run_table{
luatele = 'optimizeStorage',
size = size or -1,
ttl = ttl or -1,
count = count or -1,
immunity_delay = immunity_delay or -1,
file_type = {
luatele = 'fileType' .. file_type
},
chat_ids = luatele_function.vectorize(chat_ids),
exclude_chat_ids = luatele_function.vectorize(exclude_chat_ids),
chat_limit = chat_limit
}
end
function luatele_function.setNetworkType(type)
return function_core.run_table{
luatele = 'setNetworkType',
type = {
luatele = 'networkType' .. type
},
}
end
function luatele_function.getNetworkStatistics(only_current)
return function_core.run_table{
luatele = 'getNetworkStatistics',
only_current = only_current
}
end
function luatele_function.addNetworkStatistics(entry, file_type, network_type, sent_bytes, received_bytes, duration)
local file_type = file_type or 'None'
return function_core.run_table{
luatele = 'addNetworkStatistics',
entry = {
luatele = 'networkStatisticsEntry' .. entry,
file_type = {
luatele = 'fileType' .. file_type
},
network_type = {
luatele = 'networkType' .. network_type
},
sent_bytes = sent_bytes,
received_bytes = received_bytes,
duration = duration
}
}
end
function luatele_function.resetNetworkStatistics()
return function_core.run_table{
luatele = 'resetNetworkStatistics'
}
end
function luatele_function.getCountryCode()
return function_core.run_table{
luatele = 'getCountryCode'
}
end
function luatele_function.getInviteText()
return function_core.run_table{
luatele = 'getInviteText'
}
end
function luatele_function.getTermsOfService()
return function_core.run_table{
luatele = 'getTermsOfService'
}
end
function luatele_function.sendText(chat_id, reply_to_message_id, text, parse_mode, disable_web_page_preview, clear_draft, disable_notification, from_background, reply_markup)
local input_message_content = {
luatele = 'inputMessageText',
disable_web_page_preview = disable_web_page_preview,
text = {text = text},
clear_draft = clear_draft
}
return luatele_function.sendMessage(chat_id, reply_to_message_id, input_message_content, parse_mode, disable_notification, from_background, reply_markup)
end
function luatele_function.sendAnimation(chat_id, reply_to_message_id, animation, caption, parse_mode, duration, width, height, thumbnail, thumb_width, thumb_height, disable_notification, from_background, reply_markup)
local input_message_content = {
luatele = 'inputMessageAnimation',
animation = luatele_function.getInputFile(animation),
thumbnail = {
luatele = 'inputThumbnail',
thumbnail = luatele_function.getInputFile(thumbnail),
width = thumb_width,
height = thumb_height
},
caption = {text = caption},
duration = duration,
width = width,
height = height
}
return luatele_function.sendMessage(chat_id, reply_to_message_id, input_message_content, parse_mode, disable_notification, from_background, reply_markup)
end
function luatele_function.sendAudio(chat_id, reply_to_message_id, audio, caption, parse_mode, duration, title, performer, thumbnail, thumb_width, thumb_height, disable_notification, from_background, reply_markup)
local input_message_content = {
luatele = 'inputMessageAudio',
audio = luatele_function.getInputFile(audio),
album_cover_thumbnail = {
luatele = 'inputThumbnail',
thumbnail = luatele_function.getInputFile(thumbnail),
width = thumb_width,
height = thumb_height
},
caption = {text = caption},
duration = duration,
title = tostring(title),
performer = tostring(performer)
}
return luatele_function.sendMessage(chat_id, reply_to_message_id, input_message_content, parse_mode, disable_notification, from_background, reply_markup)
end
function luatele_function.sendDocument(chat_id, reply_to_message_id, document, caption, parse_mode, thumbnail, thumb_width, thumb_height, disable_notification, from_background, reply_markup)
local input_message_content = {
luatele = 'inputMessageDocument',
document = luatele_function.getInputFile(document),
thumbnail = {
luatele = 'inputThumbnail',
thumbnail = luatele_function.getInputFile(thumbnail),
width = thumb_width,
height = thumb_height
},
caption = {text = caption}
}
return luatele_function.sendMessage(chat_id, reply_to_message_id, input_message_content, parse_mode, disable_notification, from_background, reply_markup)
end
function luatele_function.sendPhoto(chat_id, reply_to_message_id, photo, caption, parse_mode, added_sticker_file_ids, width, height, ttl, thumbnail, thumb_width, thumb_height, disable_notification, from_background, reply_markup)
local input_message_content = {
luatele = 'inputMessagePhoto',
photo = luatele_function.getInputFile(photo),
thumbnail = {
luatele = 'inputThumbnail',
thumbnail = luatele_function.getInputFile(thumbnail),
width = thumb_width,
height = thumb_height
},
caption = {text = caption},
added_sticker_file_ids = luatele_function.vectorize(added_sticker_file_ids),
width = width,
height = height,
ttl = ttl or 0
}
return luatele_function.sendMessage(chat_id, reply_to_message_id, input_message_content, parse_mode, disable_notification, from_background, reply_markup)
end
function luatele_function.sendSticker(chat_id, reply_to_message_id, sticker, width, height, disable_notification, thumbnail, thumb_width, thumb_height, from_background, reply_markup)
local input_message_content = {
luatele = 'inputMessageSticker',
sticker = luatele_function.getInputFile(sticker),
thumbnail = {
luatele = 'inputThumbnail',
thumbnail = luatele_function.getInputFile(thumbnail),
width = thumb_width,
height = thumb_height
},
width = width,
height = height
}
return luatele_function.sendMessage(chat_id, reply_to_message_id, input_message_content, nil, disable_notification, from_background, reply_markup)
end
function luatele_function.sendVideo(chat_id, reply_to_message_id, video, caption, parse_mode, added_sticker_file_ids, duration, width, height, ttl, thumbnail, thumb_width, thumb_height, disable_notification, from_background, reply_markup)
local input_message_content = {
luatele = 'inputMessageVideo',
video = luatele_function.getInputFile(video),
thumbnail = {
luatele = 'inputThumbnail',
thumbnail = luatele_function.getInputFile(thumbnail),
width = thumb_width,
height = thumb_height
},
caption = {text = caption},
added_sticker_file_ids = luatele_function.vectorize(added_sticker_file_ids),
duration = duration,
width = width,
height = height,
ttl = ttl
}
return luatele_function.sendMessage(chat_id, reply_to_message_id, input_message_content, parse_mode, disable_notification, from_background, reply_markup)
end
function luatele_function.sendVideoNote(chat_id, reply_to_message_id, video_note, duration, length, thumbnail, thumb_width, thumb_height, disable_notification, from_background, reply_markup)
local input_message_content = {
luatele = 'inputMessageVideoNote',
video_note = luatele_function.getInputFile(video_note),
thumbnail = {
luatele = 'inputThumbnail',
thumbnail = luatele_function.getInputFile(thumbnail),
width = thumb_width,
height = thumb_height
},
duration = duration,
length = length
}
return luatele_function.sendMessage(chat_id, reply_to_message_id, input_message_content, nil, disable_notification, from_background, reply_markup)
end
function luatele_function.sendVoiceNote(chat_id, reply_to_message_id, voice_note, caption, parse_mode, duration, waveform, disable_notification, from_background, reply_markup)
local input_message_content = {
luatele = 'inputMessageVoiceNote',
voice_note = luatele_function.getInputFile(voice_note),
caption = {text = caption},
duration = duration,
waveform = waveform
}
return luatele_function.sendMessage(chat_id, reply_to_message_id, input_message_content, parse_mode, disable_notification, from_background, reply_markup)
end
function luatele_function.sendLocation(chat_id, reply_to_message_id, latitude, longitude, disable_notification, from_background, reply_markup)
local input_message_content = {
luatele = 'inputMessageLocation',
location = {
luatele = 'location',
latitude = latitude,
longitude = longitude
},
live_period = liveperiod
}
return luatele_function.sendMessage(chat_id, reply_to_message_id, input_message_content, nil, disable_notification, from_background, reply_markup)
end
function luatele_function.sendVenue(chat_id, reply_to_message_id, latitude, longitude, title, address, provider, id, disable_notification, from_background, reply_markup)
local input_message_content = {
luatele = 'inputMessageVenue',
venue = {
luatele = 'venue',
location = {
luatele = 'location',
  latitude = latitude,
  longitude = longitude
},
title = tostring(title),
address = tostring(address),
provider = tostring(provider),
id = tostring(id)
}
}
return luatele_function.sendMessage(chat_id, reply_to_message_id, input_message_content, nil, disable_notification, from_background, reply_markup)
end
function luatele_function.sendContact(chat_id, reply_to_message_id, phone_number, first_name, last_name, user_id, disable_notification, from_background, reply_markup)
local input_message_content = {
luatele = 'inputMessageContact',
contact = {
luatele = 'contact',
phone_number = tostring(phone_number),
first_name = tostring(first_name),
last_name = tostring(last_name),
user_id = user_id
}
}
return luatele_function.sendMessage(chat_id, reply_to_message_id, input_message_content, nil, disable_notification, from_background, reply_markup)
end
function luatele_function.sendInvoice(chat_id, reply_to_message_id, invoice, title, description, photo_url, photo_size, photo_width, photo_height, payload, provider_token, provider_data, start_parameter, disable_notification, from_background, reply_markup)
local input_message_content = {
luatele = 'inputMessageInvoice',
invoice = invoice,
title = tostring(title),
description = tostring(description),
photo_url = tostring(photo_url),
photo_size = photo_size,
photo_width = photo_width,
photo_height = photo_height,
payload = payload,
provider_token = tostring(provider_token),
provider_data = tostring(provider_data),
start_parameter = tostring(start_parameter)
}
return luatele_function.sendMessage(chat_id, reply_to_message_id, input_message_content, nil, disable_notification, from_background, reply_markup)
end
function luatele_function.sendForwarded(chat_id, reply_to_message_id, from_chat_id, message_id, in_game_share, disable_notification, from_background, reply_markup)
local input_message_content = {
luatele = 'inputMessageForwarded',
from_chat_id = from_chat_id,
message_id = message_id,
in_game_share = in_game_share
}
return luatele_function.sendMessage(chat_id, reply_to_message_id, input_message_content, nil, disable_notification, from_background, reply_markup)
end
function luatele_function.sendPoll(chat_id, reply_to_message_id, question, options, pollType, is_anonymous, allow_multiple_answers)
local input_message_content = {
luatele = 'inputMessagePoll',
is_anonymous = is_anonymous,
question = question,
type = {
luatele = 'pollType'..pollType,
  allow_multiple_answers = allow_multiple_answers
},
options = options
}
return luatele_function.sendMessage(chat_id, reply_to_message_id, input_message_content, parse_mode, disable_notification, from_background, reply_markup)
end
function luatele_function.getPollVoters(chat_id, message_id, option_id, offset, limit)
return function_core.run_table{
luatele = 'getPollVoters',
chat_id = chat_id,
message_id = message_id,
option_id = option_id,
limit = luatele_function.setLimit(50 , limit),
offset = offset
}
end
function luatele_function.setPollAnswer(chat_id, message_id, option_ids)
return function_core.run_table{
luatele = 'setPollAnswer',
chat_id = chat_id,
message_id = message_id,
option_ids = option_ids
}
end
function luatele_function.stopPoll(chat_id, message_id, reply_markup)
return function_core.run_table{
luatele = 'stopPoll',
chat_id = chat_id,
message_id = message_id,
reply_markup = reply_markup
}
end
function luatele_function.getInputMessage(value)
if type(value) ~= 'table' then
return value
end
if type(value.type) == 'string' then
if value.parse_mode and value.caption then
caption = luatele_function.parseTextEntities(value.caption, value.parse_mode)
  elseif value.caption and not value.parse_mode then
caption = {
  text = value.caption
}
  elseif value.parse_mode and value.text then
text = luatele_function.parseTextEntities(value.text, value.parse_mode)
  elseif not value.parse_mode and value.text then
text = {
  text = value.text
}
end
value.type = string.lower(value.type)
if value.type == 'text' then
return {
luatele = 'inputMessageText',
  disable_web_page_preview = value.disable_web_page_preview,
  text = text,
  clear_draft = value.clear_draft
}
  elseif value.type == 'animation' then
return {
luatele = 'inputMessageAnimation',
  animation = luatele_function.getInputFile(value.animation),
  thumbnail = {
luatele = 'inputThumbnail',
thumbnail = luatele_function.getInputFile(value.thumbnail),
width = value.thumb_width,
height = value.thumb_height
},
  caption = caption,
  duration = value.duration,
  width = value.width,
  height = value.height
}
  elseif value.type == 'audio' then
return {
luatele = 'inputMessageAudio',
  audio = luatele_function.getInputFile(value.audio),
  album_cover_thumbnail = {
luatele = 'inputThumbnail',
thumbnail = luatele_function.getInputFile(value.thumbnail),
width = value.thumb_width,
height = value.thumb_height
},
  caption = caption,
  duration = value.duration,
  title = tostring(value.title),
  performer = tostring(value.performer)
}
  elseif value.type == 'document' then
return {
luatele = 'inputMessageDocument',
  document = luatele_function.getInputFile(value.document),
  thumbnail = {
luatele = 'inputThumbnail',
thumbnail = luatele_function.getInputFile(value.thumbnail),
width = value.thumb_width,
height = value.thumb_height
},
  caption = caption
}
  elseif value.type == 'photo' then
return {
luatele = 'inputMessagePhoto',
  photo = luatele_function.getInputFile(value.photo),
  thumbnail = {
luatele = 'inputThumbnail',
thumbnail = luatele_function.getInputFile(value.thumbnail),
width = value.thumb_width,
height = value.thumb_height
},
  caption = caption,
  added_sticker_file_ids = luatele_function.vectorize(value.added_sticker_file_ids),
  width = value.width,
  height = value.height,
  ttl = value.ttl or 0
}
  elseif value.text == 'video' then
return {
luatele = 'inputMessageVideo',
  video = luatele_function.getInputFile(value.video),
  thumbnail = {
luatele = 'inputThumbnail',
thumbnail = luatele_function.getInputFile(value.thumbnail),
width = value.thumb_width,
height = value.thumb_height
},
  caption = caption,
  added_sticker_file_ids = luatele_function.vectorize(value.added_sticker_file_ids),
  duration = value.duration,
  width = value.width,
  height = value.height,
  ttl = value.ttl or 0
}
  elseif value.text == 'videonote' then
return {
luatele = 'inputMessageVideoNote',
  video_note = luatele_function.getInputFile(value.video_note),
  thumbnail = {
luatele = 'inputThumbnail',
thumbnail = luatele_function.getInputFile(value.thumbnail),
width = value.thumb_width,
height = value.thumb_height
},
  duration = value.duration,
  length = value.length
}
  elseif value.text == 'voice' then
return {
luatele = 'inputMessageVoiceNote',
  voice_note = luatele_function.getInputFile(value.voice_note),
  caption = caption,
  duration = value.duration,
  waveform = value.waveform
}
  elseif value.text == 'location' then
return {
luatele = 'inputMessageLocation',
  location = {
luatele = 'location',
latitude = value.latitude,
longitude = value.longitude
},
  live_period = value.liveperiod
}
  elseif value.text == 'contact' then
return {
luatele = 'inputMessageContact',
  contact = {
luatele = 'contact',
phone_number = tostring(value.phone_number),
first_name = tostring(value.first_name),
last_name = tostring(value.last_name),
user_id = value.user_id
}
}
  elseif value.text == 'contact' then
return {
luatele = 'inputMessageContact',
  contact = {
luatele = 'contact',
phone_number = tostring(value.phone_number),
first_name = tostring(value.first_name),
last_name = tostring(value.last_name),
user_id = value.user_id
}
}
end
end
end
function luatele_function.editInlineMessageText(inline_message_id, input_message_content, reply_markup)
return function_core.run_table{
luatele = 'editInlineMessageText',
input_message_content = luatele_function.getInputMessage(input_message_content),
reply_markup = reply_markup
}
end
function luatele_function.answerInlineQuery(inline_query_id, results, next_offset, switch_pm_text, switch_pm_parameter, is_personal, cache_time)
local answerInlineQueryResults = {}
  for key, value in pairs(results) do
local newAnswerInlineQueryResults_id = #answerInlineQueryResults + 1
if type(value) == 'table' and type(value.type) == 'string' then
value.type = string.lower(value.type)
if value.type == 'gif' then
  answerInlineQueryResults[newAnswerInlineQueryResults_id] = {
luatele = 'inputInlineQueryResultAnimatedGif',
id = value.id,
title = value.title,
thumbnail_url = value.thumbnail_url,
gif_url = value.gif_url,
gif_duration = value.gif_duration,
gif_width = value.gif_width,
gif_height = value.gif_height,
reply_markup = luatele_function.replyMarkup{
type = 'inline',
data = value.reply_markup
},
input_message_content = luatele_function.getInputMessage(value.input)
}
elseif value.type == 'mpeg4' then
  answerInlineQueryResults[newAnswerInlineQueryResults_id] = {
luatele = 'inputInlineQueryResultAnimatedMpeg4',
id = value.id,
title = value.title,
thumbnail_url = value.thumbnail_url,
mpeg4_url = value.mpeg4_url,
mpeg4_duration = value.mpeg4_duration,
mpeg4_width = value.mpeg4_width,
mpeg4_height = value.mpeg4_height,
reply_markup = luatele_function.replyMarkup{
type = 'inline',
data = value.reply_markup
},
input_message_content = luatele_function.getInputMessage(value.input)
}
elseif value.type == 'article' then
  answerInlineQueryResults[newAnswerInlineQueryResults_id] = {
luatele = 'inputInlineQueryResultArticle',
id = value.id,
url = value.url,
hide_url = value.hide_url,
title = value.title,
description = value.description,
thumbnail_url = value.thumbnail_url,
thumbnail_width = value.thumbnail_width,
thumbnail_height = value.thumbnail_height,
reply_markup = luatele_function.replyMarkup{
type = 'inline',
data = value.reply_markup
},
input_message_content = luatele_function.getInputMessage(value.input)
}
elseif value.type == 'audio' then
  answerInlineQueryResults[newAnswerInlineQueryResults_id] = {
luatele = 'inputInlineQueryResultAudio',
id = value.id,
title = value.title,
performer = value.performer,
audio_url = value.audio_url,
audio_duration = value.audio_duration,
reply_markup = luatele_function.replyMarkup{
type = 'inline',
data = value.reply_markup
},
input_message_content = luatele_function.getInputMessage(value.input)
}
elseif value.type == 'contact' then
  answerInlineQueryResults[newAnswerInlineQueryResults_id] = {
luatele = 'inputInlineQueryResultContact',
id = value.id,
contact = value.contact,
thumbnail_url = value.thumbnail_url,
thumbnail_width = value.thumbnail_width,
thumbnail_height = thumbnail_height.description,
reply_markup = luatele_function.replyMarkup{
type = 'inline',
data = value.reply_markup
},
input_message_content = luatele_function.getInputMessage(value.input)
}
elseif value.type == 'document' then
  answerInlineQueryResults[newAnswerInlineQueryResults_id] = {
luatele = 'inputInlineQueryResultDocument',
id = value.id,
title = value.title,
description = value.description,
document_url = value.document_url,
mime_type = value.mime_type,
thumbnail_url = value.thumbnail_url,
thumbnail_width = value.thumbnail_width,
thumbnail_height = value.thumbnail_height,
reply_markup = luatele_function.replyMarkup{
type = 'inline',
data = value.reply_markup
},
input_message_content = luatele_function.getInputMessage(value.input)
}
elseif value.type == 'game' then
  answerInlineQueryResults[newAnswerInlineQueryResults_id] = {
luatele = 'inputInlineQueryResultGame',
id = value.id,
game_short_name = value.game_short_name,
reply_markup = luatele_function.replyMarkup{
type = 'inline',
data = value.reply_markup
},
input_message_content = luatele_function.getInputMessage(value.input)
}
elseif value.type == 'location' then
  answerInlineQueryResults[newAnswerInlineQueryResults_id] = {
luatele = 'inputInlineQueryResultLocation',
id = value.id,
location = value.location,
live_period = value.live_period,
title = value.title,
thumbnail_url = value.thumbnail_url,
thumbnail_width = value.thumbnail_width,
thumbnail_height = value.thumbnail_height,
reply_markup = luatele_function.replyMarkup{
type = 'inline',
data = value.reply_markup
},
input_message_content = luatele_function.getInputMessage(value.input)
}
elseif value.type == 'photo' then
  answerInlineQueryResults[newAnswerInlineQueryResults_id] = {
luatele = 'inputInlineQueryResultPhoto',
id = value.id,
title = value.title,
description = value.description,
thumbnail_url = value.thumbnail_url,
photo_url = value.photo_url,
photo_width = value.photo_width,
photo_height = value.photo_height,
reply_markup = luatele_function.replyMarkup{
type = 'inline',
data = value.reply_markup
},
input_message_content = luatele_function.getInputMessage(value.input)
}
elseif value.type == 'sticker' then
  answerInlineQueryResults[newAnswerInlineQueryResults_id] = {
luatele = 'inputInlineQueryResultSticker',
id = value.id,
thumbnail_url = value.thumbnail_url,
sticker_url = value.sticker_url,
sticker_width = value.sticker_width,
sticker_height = value.sticker_height,
photo_width = value.photo_width,
photo_height = value.photo_height,
reply_markup = luatele_function.replyMarkup{
type = 'inline',
data = value.reply_markup
},
input_message_content = luatele_function.getInputMessage(value.input)
}
elseif value.type == 'sticker' then
  answerInlineQueryResults[newAnswerInlineQueryResults_id] = {
luatele = 'inputInlineQueryResultSticker',
id = value.id,
thumbnail_url = value.thumbnail_url,
sticker_url = value.sticker_url,
sticker_width = value.sticker_width,
sticker_height = value.sticker_height,
photo_width = value.photo_width,
photo_height = value.photo_height,
reply_markup = luatele_function.replyMarkup{
type = 'inline',
data = value.reply_markup
},
input_message_content = luatele_function.getInputMessage(value.input)
}
elseif value.type == 'video' then
  answerInlineQueryResults[newAnswerInlineQueryResults_id] = {
luatele = 'inputInlineQueryResultVideo',
id = value.id,
title = value.title,
description = value.description,
thumbnail_url = value.thumbnail_url,
video_url = value.video_url,
mime_type = value.mime_type,
video_width = value.video_width,
video_height = value.video_height,
video_duration = value.video_duration,
reply_markup = luatele_function.replyMarkup{
type = 'inline',
data = value.reply_markup
},
input_message_content = luatele_function.getInputMessage(value.input)
}
elseif value.type == 'videonote' then
  answerInlineQueryResults[newAnswerInlineQueryResults_id] = {
luatele = 'inputInlineQueryResultVoiceNote',
id = value.id,
title = value.title,
voice_note_url = value.voice_note_url,
voice_note_duration = value.voice_note_duration,
reply_markup = luatele_function.replyMarkup{
type = 'inline',
data = value.reply_markup
},
input_message_content = luatele_function.getInputMessage(value.input)
}
end
end
end
return function_core.run_table{
luatele = 'answerInlineQuery',
inline_query_id = inline_query_id,
next_offset = next_offset,
switch_pm_text = switch_pm_text,
switch_pm_parameter = switch_pm_parameter,
is_personal = is_personal,
cache_time = cache_time,
results = answerInlineQueryResults,
}
end
function luatele.VERSION()
  print('login')
return true
end
function luatele.run(main_def, filters)
if type(main_def) ~= 'function' then
function_core.print_error('the run main_def must be a main function !')
os.exit(1)
  else
update_functions[0] = {}
update_functions[0].def = main_def
update_functions[0].filters = filters
end
  while luatele.get_update do
for timer_id, timer_data in pairs(luatele_timer) do
if os.time() >= timer_data.run_in then
  xpcall(timer_data.def, function_core.print_error,timer_data.argv)
  table.remove(luatele_timer,timer_id)
end
end
local update = function_core.change_table(client:receive(1))
if update then
if type(update) ~= 'table' then
goto finish
end
if luatele.login(update) then
function_core._CALL_(update)
end
end
::finish::
end
end
function luatele.set_config(data)
luatele.VERSION()
if not data.api_hash then
print('Please enter AP_HASH to call')
os.exit()
end
if not data.api_id then
print('Please enter API_ID to call')
os.exit()
end
if not data.session_name then
print('please use session_name in your script !')
os.exit()
end
if not data.token and not luatele_function.exists('.infoBot/'..data.session_name) then
io.write('Please enter Token or Phone to call')
local phone_token = io.read()
if phone_token:match('%d+:') then
luatele.config.is_bot = true
luatele.config.token = phone_token
else
luatele.config.is_bot = false
luatele.config.phone = phone_token
end
elseif data.token and not luatele_function.exists('.infoBot/'..data.session_name) then
luatele.config.is_bot = true
luatele.config.token = data.token
end
if not luatele_function.exists('.infoBot') then
os.execute('sudo mkdir .infoBot')
end
luatele.config.encryption_key = data.encryption_key or ''
luatele.config.parameters = {
luatele = 'setTdlibParameters',
use_message_database = data.use_message_database or true,
api_id = data.api_id,
api_hash = data.api_hash,
use_secret_chats = use_secret_chats or true,
system_language_code = data.language_code or 'en',
device_model = 'luatele',
system_version = data.system_version or 'linux',
application_version = '1.0',
enable_storage_optimizer = data.enable_storage_optimizer or true,
use_pfs = data.use_pfs or true,
database_directory = '.infoBot/'..data.session_name
}
return luatele_function
end
function luatele.login(state)
if state.name == 'version' and state.value and state.value.value then
elseif state.authorization_state and state.authorization_state.luatele == 'error' and (state.authorization_state.message == 'PHONE_NUMBER_INVALID' or state.authorization_state.message == 'ACCESS_TOKEN_INVALID') then
if state.authorization_state.message == 'PHONE_NUMBER_INVALID' then
print('Phone Number invalid Error ?!')
else
print('Token Bot invalid Error ?!')
end
io.write('Please Use Token or Phone to call : ')
local phone_token = io.read()
if phone_token:match('%d+:') then
function_core.send_tdlib{
luatele = 'checkAuthenticationBotToken',
token = phone_token
}
else
function_core.send_tdlib{
luatele = 'setAuthenticationPhoneNumber',
phone_number = phone_token
}
end
elseif state.authorization_state and state.authorization_state.luatele == 'error' and state.authorization_state.message == 'PHONE_CODE_INVALID' then
io.write('The Code : ')
local code = io.read()
function_core.send_tdlib{
luatele = 'checkAuthenticationCode',
code = code
}
elseif state.authorization_state and state.authorization_state.luatele == 'error' and state.authorization_state.message == 'PASSWORD_HASH_INVALID' then
print('two-step is wrong !')
io.write('The Password : ')
local password = io.read()
function_core.send_tdlib{
luatele = 'checkAuthenticationPassword',
password = password
}
elseif state.luatele == 'authorizationStateWaitTdlibParameters' or (state.authorization_state and state.authorization_state.luatele == 'authorizationStateWaitTdlibParameters') then
function_core.send_tdlib{
luatele = 'setTdlibParameters',
parameters = luatele.config.parameters
}
elseif state.authorization_state and state.authorization_state.luatele == 'authorizationStateWaitEncryptionKey' then
function_core.send_tdlib{
luatele = 'checkDatabaseEncryptionKey',
encryption_key = luatele.config.encryption_key
}
elseif state.authorization_state and state.authorization_state.luatele == 'authorizationStateWaitPhoneNumber' then
if luatele.config.is_bot then
function_core.send_tdlib{
luatele = 'checkAuthenticationBotToken',
token = luatele.config.token
}
else
function_core.send_tdlib{
luatele = 'setAuthenticationPhoneNumber',
phone_number = luatele.config.phone
}
end
elseif state.authorization_state and state.authorization_state.luatele == 'authorizationStateWaitCode' then
io.write('The Password : ')
local code = io.read()
function_core.send_tdlib{
luatele = 'checkAuthenticationCode',
code = code
}
elseif state.authorization_state and state.authorization_state.luatele == 'authorizationStateWaitPassword' then
io.write('Password [ '..state.authorization_state.password_hint..' ] : ')
local password = io.read()
function_core.send_tdlib{
luatele = 'checkAuthenticationPassword',
password = password
}
elseif state.authorization_state and state.authorization_state.luatele == 'authorizationStateWaitRegistration' then
io.write('The First name : ')
local first_name = io.read()
io.write('The Last name : ')
local last_name = io.read()
function_core.send_tdlib{
luatele = 'registerUser',
first_name = first_name,
last_name = last_name
}
elseif state.authorization_state and state.authorization_state.luatele == 'authorizationStateReady' then
print("- تم اكمال المعلومات جارِ تشغيل البوت .")
elseif state.authorization_state and state.authorization_state.luatele == 'authorizationStateClosed' then
print('- تم تسجيل الخروج .')
luatele.get_update = false
elseif state.luatele == 'error' and state.message then
elseif not (state.luatele and luatele_function.in_array({'updateConnectionState', 'updateSelectedBackground', 'updateConnectionState', 'updateOption',}, state.luatele)) then
return true
end
end
return luatele