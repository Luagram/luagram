#!/usr/bin/env lua5.3
local functionDo = {}
local functionCo = {}
local functionUp = {}
local functionTi = {}
local tdbot = {
get_update = true,
config = {}
}
local luaGrem =  require('tdlua') 
local client = luaGrem()
-----------------------------------------------
function functionCo._CALL_(update)
if update and type(update) == 'table' then
for i = 0 , #functionUp do
if not functionUp[i].filters then
send_update = true
update_message = update
elseif update.tdbot and functionUp[i].filters and functionDo.in_array(functionUp[i].filters,  update.tdbot) then
send_update = true
update_message = update
else
send_update = false
end
if update_message and send_update and type(update_message) == 'table' then
xpcall(functionUp[i].def, functionCo.print_error, update_message)
end
update_message = nil
send_update = nil
end
end
end
function functionCo.change_table(input, send)
if send then
changes ={
tdbot = string.reverse('epyt@')
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
res[key] = functionCo.change_table(value, send)
end
end
return res
else
return input
end
end
function functionCo.run_table(input)
local to_original = functionCo.change_table(input, true)
local result = client:execute(to_original)
if type(result) ~= 'table' then
return nil
else
return functionCo.change_table(result)
end
end
function functionCo.print_error(err)
  print('There is an error in the file, please correct it '.. err)
end
function functionCo.send_tdlib(input)
local to_original = functionCo.change_table(input, true)
client:send(to_original)
end
functionCo.send_tdlib{
tdbot = 'getAuthorizationState'
}
luaGrem.setLogLevel(3)
luaGrem.setLogPath('/usr/lib/x86_64-linux-gnu/lua/lua5.3/.tdbot.log')
-----------------------------------------------functionDo
function functionDo.len(input)
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
function functionDo.match(...)
local val = {}
  for no,v in ipairs({...}) do
val[v] = true
end
return val
end
function functionDo.secToClock(seconds)
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
function functionDo.number_format(num)
local out = tonumber(num)
  while true do
out,i= string.gsub(out,'^(-?%d+)(%d%d%d)', '%1,%2')
if (i==0) then
break
end
end
return out
end
function functionDo.base64_encode(str)
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
function functionDo.base64_decode(str)
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
function functionDo.exists(file)
 local ok, err, code = os.rename(file, file)
 if not ok then
if code == 13 then
 return true
end
 end
 return ok, err
end
function functionDo.in_array(table, value)
  for k,v in pairs(table) do
if value == v then
return true
end
end
return false
end
function functionDo.add_events(def,filters)
if type(def) ~= 'function' then
functionCo.print_error('the add_events def must be a function !')
return {
tdbot = false,
}
  elseif type(filters) ~= 'table' then
functionCo.print_error('the add_events filters must be a table !')
return {
tdbot = false,
}
else
local function_id = #functionUp + 1
functionUp[function_id] = {}
functionUp[function_id].def = def
functionUp[function_id].filters = filters
return {
tdbot = true,
}
end
end


function functionDo.set_timer(seconds, def, argv)
if type(seconds) ~= 'number' then
return {
tdbot = false,
message = 'set_timer(int seconds, funtion def, table)'
}
elseif type(def) ~= 'function' then
return {
tdbot = false,
message = 'set_timer(int seconds, funtion def, table)'
}
end
functionTi[#functionTi + 1] = {
def = def,
argv = argv,
run_in = os.time() + seconds
}
return {
tdbot = true,
run_in = os.time() + seconds,
timer_id = #functionTi
}
end
function functionDo.get_timer(timer_id)
local timer_data = functionTi[timer_id]
if timer_data then
return {
tdbot = true,
run_in = timer_data.run_in,
argv = timer_data.argv
}
  else
return {
tdbot = false,
}
end
end
function functionDo.cancel_timer(timer_id)
if functionTi[timer_id] then
table.remove(functionTi,timer_id)
return {
tdbot = true
}
  else
return {
tdbot = false
}
end
end

function functionDo.replyMarkup(input)
if type(input.type) ~= 'string' then
return nil
end
local _type = string.lower(input.type)
if _type == 'inline' then
local result = {
tdbot = 'replyMarkupInlineKeyboard',
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
  tdbot = 'inlineKeyboardButton',
text = value.text,
type = {
tdbot = 'inlineKeyboardButtonTypeUrl',
  url = value.url
}
}
elseif value.data and value.text then
result.rows[new_id][rows_new_id] = {
tdbot = 'inlineKeyboardButton',
  text = value.text,
  type = {
data = functionDo.base64_encode(value.data), -- Base64 only
tdbot = 'inlineKeyboardButtonTypeCallback',
}
}
  elseif value.forward_text and value.id and value.url and value.text then
result.rows[new_id][rows_new_id] = {
tdbot = 'inlineKeyboardButton',
  text = value.text,
  type = {
id = value.id,
url = value.url,
forward_text = value.forward_text,
tdbot = 'inlineKeyboardButtonTypeLoginUrl',
}
}
  elseif value.query and value.text then
result.rows[new_id][rows_new_id] = {
tdbot = 'inlineKeyboardButton',
  text = value.text,
  type = {
query = value.query,
tdbot = 'inlineKeyboardButtonTypeSwitchInline',
}
}
end
end
end
return result
elseif _type == 'keyboard' then
local result = {
tdbot = 'replyMarkupShowKeyboard',
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
tdbot = 'keyboardButtonTypeRequestLocation'
},
tdbot = 'keyboardButton',
  text = value.text
}
  elseif value.type == 'requestphone' and value.text then
result.rows[new_id][rows_new_id] = {
  type = {
tdbot = 'keyboardButtonTypeRequestPhoneNumber'
},
tdbot = 'keyboardButton',
  text = value.text
}
  elseif value.type == 'requestpoll' and value.text then
result.rows[new_id][rows_new_id] = {
  type = {
tdbot = 'keyboardButtonTypeRequestPoll',
force_regular = value.force_regular,
force_quiz = value.force_quiz
},
tdbot = 'keyboardButton',
  text = value.text
}
  elseif value.type == 'text' and value.text then
result.rows[new_id][rows_new_id] = {
  type = {
tdbot = 'keyboardButtonTypeText'
},
tdbot = 'keyboardButton',
  text = value.text
}
end
end
end
end
return result
elseif _type == 'forcereply' then
return {
tdbot = 'replyMarkupForceReply',
is_personal = input.is_personal
}
elseif _type == 'remove' then
return {
tdbot = 'replyMarkupRemoveKeyboard',
is_personal = input.is_personal
}
end
end
function functionDo.addProxy(proxy_type, server, port, username, password_secret, http_only)
if type(proxy_type) ~= 'string' then
return {
tdbot = false
}
end
local proxy_type = string.lower(proxy_type)
if proxy_type == 'mtproto' then
_type_ = {
tdbot = 'proxyTypeMtproto',
secret = password_secret
}
elseif proxy_Type == 'socks5' then
_type_ = {
tdbot = 'proxyTypeSocks5',
username = username,
password = password_secret
}
elseif proxy_Type == 'http' then
_type_ = {
tdbot = 'proxyTypeHttp',
username = username,
password = password_secret,
http_only = http_only
}
  else
return {
tdbot = false
}
end
return functionCo.run_table{
tdbot = 'addProxy',
server = server,
port = port,
type = _type_
}
end
function functionDo.enableProxy(proxy_id)
return functionCo.run_table{
 tdbot = 'enableProxy',
proxy_id = proxy_id
}
end
function functionDo.pingProxy(proxy_id)
return functionCo.run_table{
 tdbot = 'pingProxy',
proxy_id = proxy_id
}
end
function functionDo.disableProxy(proxy_id)
return functionCo.run_table{
 tdbot = 'disableProxy',
proxy_id = proxy_id
}
end
function functionDo.getProxies()
return functionCo.run_table{
tdbot = 'getProxies'
}
end
function functionDo.getChatId(chat_id)
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
function functionDo.getInputFile(file, conversion_str, expected_size)
local str = tostring(file)
if (conversion_str and expectedsize) then
return {
tdbot = 'inputFileGenerated',
original_path = tostring(file),
conversion = tostring(conversion_str),
expected_size = expected_size
}
  else
if str:match('/') then
return {
tdbot = 'inputFileLocal',
  path = file
}
  elseif str:match('^%d+$') then
return {
tdbot = 'inputFileId',
  id = file
}
else
return {
tdbot = 'inputFileRemote',
  id = file
}
end
end
end
function functionDo.getParseMode(parse_mode)
if parse_mode then
local mode = parse_mode:lower()
if mode == 'markdown' or mode == 'md' then
return {
tdbot = 'textParseModeMarkdown',
}
elseif mode == 'html' or mode == 'lg' then
return {
tdbot = 'textParseModeHTML'
}
end
end
end
function functionDo.parseTextEntities(text, parse_mode)
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
return functionCo.run_table{
tdbot = 'parseTextEntities',
text = tostring(text),
parse_mode = functionDo.getParseMode(parse_mode)
}
end
function functionDo.vectorize(table)
if type(table) == 'table' then
return table
  else
return {
table
}
end
end
function functionDo.setLimit(limit, num)
local limit = tonumber(limit)
local number = tonumber(num or limit)
return (number >= limit) and limit or number
end
function functionDo.sendMessage(chat_id, reply_to_message_id, input_message_content, parse_mode, disable_notification, from_background, reply_markup)
local tdbot_body, message = {
tdbot = 'sendMessage',
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
local result = functionDo.parseTextEntities(text, parse_mode)
if tdbot_body.input_message_content.text then
tdbot_body.input_message_content.text = result
else
tdbot_body.input_message_content.caption = result
end
return functionCo.run_table(tdbot_body)
else
while #text > 4096 do
  text = string.sub(text, 4096, #text)
  message[#message + 1] = text
end
message[#message + 1] = text
for i = 1, #message do
if input_message_content.text and input_message_content.text.text then
tdbot_body.input_message_content.text.text = message[i]
elseif input_message_content.caption and input_message_content.caption.text then
tdbot_body.input_message_content.caption.text = message[i]
end
return functionCo.run_table(tdbot_body)
end
end
  else
return functionCo.run_table(tdbot_body)
end
end
function functionDo.logOut()
return functionCo.run_table{
tdbot = 'logOut'
}
end
function functionDo.getPasswordState()
return functionCo.run_table{
tdbot = 'getPasswordState'
}
end
function functionDo.setPassword(old_password, new_password, new_hint, set_recovery_email_address, new_recovery_email_address)
return functionCo.run_table{
old_password = tostring(old_password),
new_password = tostring(new_password),
new_hint = tostring(new_hint),
set_recovery_email_address = set_recovery_email_address,
new_recovery_email_address = tostring(new_recovery_email_address)
}
end
function functionDo.getRecoveryEmailAddress(password)
return functionCo.run_table{
tdbot = 'getRecoveryEmailAddress',
password = tostring(password)
}
end
function functionDo.setRecoveryEmailAddress(password, new_recovery_email_address)
return functionCo.run_table{
tdbot = 'setRecoveryEmailAddress',
password = tostring(password),
new_recovery_email_address = tostring(new_recovery_email_address)
}
end
function functionDo.requestPasswordRecovery()
return functionCo.run_table{
tdbot = 'requestPasswordRecovery'
}
end
function functionDo.recoverPassword(recovery_code)
return functionCo.run_table{
tdbot = 'recoverPassword',
recovery_code = tostring(recovery_code)
}
end
function functionDo.createTemporaryPassword(password, valid_for)
local valid_for = valid_for > 86400 and 86400 or valid_for
return functionCo.run_table{
tdbot = 'createTemporaryPassword',
password = tostring(password),
valid_for = valid_for
}
end
function functionDo.getTemporaryPasswordState()
return functionCo.run_table{
tdbot = 'getTemporaryPasswordState'
}
end
function functionDo.getMe()
return functionCo.run_table{
tdbot = 'getMe'
}
end
function functionDo.getUser(user_id)
return functionCo.run_table{
tdbot = 'getUser',
user_id = user_id
}
end
function functionDo.getUserFullInfo(user_id)
return functionCo.run_table{
tdbot = 'getUserFullInfo',
user_id = user_id
}
end
function functionDo.getBasicGroup(basic_group_id)
return functionCo.run_table{
tdbot = 'getBasicGroup',
basic_group_id = functionDo.getChatId(basic_group_id).id
}
end
function functionDo.getBasicGroupFullInfo(basic_group_id)
return functionCo.run_table{
tdbot = 'getBasicGroupFullInfo',
basic_group_id = functionDo.getChatId(basic_group_id).id
}
end
function functionDo.getSupergroup(supergroup_id)
return functionCo.run_table{
tdbot = 'getSupergroup',
supergroup_id = functionDo.getChatId(supergroup_id).id
}
end
function functionDo.getSupergroupFullInfo(supergroup_id)
return functionCo.run_table{
tdbot = 'getSupergroupFullInfo',
supergroup_id = functionDo.getChatId(supergroup_id).id
}
end
function functionDo.getSecretChat(secret_chat_id)
return functionCo.run_table{
tdbot = 'getSecretChat',
secret_chat_id = secret_chat_id
}
end
function functionDo.getChat(chat_id)
return functionCo.run_table{
tdbot = 'getChat',
chat_id = chat_id
}
end
function functionDo.getMessage(chat_id, message_id)
return functionCo.run_table{
tdbot = 'getMessage',
chat_id = chat_id,
message_id = message_id
}
end
function functionDo.getRepliedMessage(chat_id, message_id)
return functionCo.run_table{
tdbot = 'getRepliedMessage',
chat_id = chat_id,
message_id = message_id
}
end
function functionDo.getChatPinnedMessage(chat_id)
return functionCo.run_table{
tdbot = 'getChatPinnedMessage',
chat_id = chat_id
}
end
function functionDo.unpinAllChatMessages(chat_id)
return functionCo.run_table{
tdbot = 'unpinAllChatMessages',
chat_id = chat_id
}
end
function functionDo.getMessages(chat_id, message_ids)
return functionCo.run_table{
tdbot = 'getMessages',
chat_id = chat_id,
message_ids = functionDo.vectorize(message_ids)
}
end
function functionDo.getFile(file_id)
return functionCo.run_table{
tdbot = 'getFile',
file_id = file_id
}
end
function functionDo.getRemoteFile(remote_file_id, file_type)
return functionCo.run_table{
tdbot = 'getRemoteFile',
remote_file_id = tostring(remote_file_id),
file_type = {
tdbot = 'fileType' .. file_type or 'Unknown'
}
}
end
function functionDo.getChats(chat_list, offset_order, offset_chat_id, limit)
local limit = limit or 20
local offset_order = offset_order or '9223372036854775807'
local offset_chat_id = offset_chat_id or 0
local filter = (string.lower(tostring(chat_list)) == 'archive') and 'chatListArchive' or 'chatListMain'
return functionCo.run_table{
tdbot = 'getChats',
offset_order = offset_order,
offset_chat_id = offset_chat_id,
limit = functionDo.setLimit(100, limit),
chat_list = {
tdbot = filter
}
}
end
function functionDo.searchPublicChat(username)
return functionCo.run_table{
tdbot = 'searchPublicChat',
username = tostring(username)
}
end
function functionDo.searchPublicChats(query)
return functionCo.run_table{
tdbot = 'searchPublicChats',
query = tostring(query)
}
end
function functionDo.searchChats(query, limit)
return functionCo.run_table{
tdbot = 'searchChats',
query = tostring(query),
limit = limit
}
end
function functionDo.checkChatUsername(chat_id, username)
return functionCo.run_table{
tdbot = 'checkChatUsername',
chat_id = chat_id,
username = tostring(username)
}
end
function functionDo.searchChatsOnServer(query, limit)
return functionCo.run_table{
tdbot = 'searchChatsOnServer',
query = tostring(query),
limit = limit
}
end
function functionDo.clearRecentlyFoundChats()
return functionCo.run_table{
tdbot = 'clearRecentlyFoundChats'
}
end
function functionDo.getTopChats(category, limit)
return functionCo.run_table{
tdbot = 'getTopChats',
category = {
tdbot = 'topChatCategory' .. category
},
limit = functionDo.setLimit(30, limit)
}
end
function functionDo.removeTopChat(category, chat_id)
return functionCo.run_table{
tdbot = 'removeTopChat',
category = {
tdbot = 'topChatCategory' .. category
},
chat_id = chat_id
}
end
function functionDo.addRecentlyFoundChat(chat_id)
return functionCo.run_table{
tdbot = 'addRecentlyFoundChat',
chat_id = chat_id
}
end
function functionDo.getCreatedPublicChats()
return functionCo.run_table{
tdbot = 'getCreatedPublicChats'
}
end
function functionDo.removeRecentlyFoundChat(chat_id)
return functionCo.run_table{
tdbot = 'removeRecentlyFoundChat',
chat_id = chat_id
}
end
function functionDo.getChatHistory(chat_id, from_message_id, offset, limit, only_local)
return functionCo.run_table{
tdbot = 'getChatHistory',
chat_id = chat_id,
from_message_id = from_message_id,
offset = offset,
limit = functionDo.setLimit(100, limit),
only_local = only_local
}
end
function functionDo.getGroupsInCommon(user_id, offset_chat_id, limit)
return functionCo.run_table{
tdbot = 'getGroupsInCommon',
user_id = user_id,
offset_chat_id = offset_chat_id or 0,
limit = functionDo.setLimit(100, limit)
}
end
function functionDo.searchMessages(query, offset_date, offset_chat_id, offset_message_id, limit)
return functionCo.run_table{
tdbot = 'searchMessages',
query = tostring(query),
offset_date = offset_date or 0,
offset_chat_id = offset_chat_id or 0,
offset_message_id = offset_message_id or 0,
limit = functionDo.setLimit(100, limit)
}
end
function functionDo.searchChatMessages(chat_id, query, filter, sender_user_id, from_message_id, offset, limit)
return functionCo.run_table{
tdbot = 'searchChatMessages',
chat_id = chat_id,
query = tostring(query),
sender_user_id = sender_user_id or 0,
from_message_id = from_message_id or 0,
offset = offset or 0,
limit = functionDo.setLimit(100, limit),
filter = {
tdbot = 'searchMessagesFilter' .. filter
}
}
end
function functionDo.searchSecretMessages(chat_id, query, from_search_id, limit, filter)
local filter = filter or 'Empty'
return functionCo.run_table{
tdbot = 'searchSecretMessages',
chat_id = chat_id or 0,
query = tostring(query),
from_search_id = from_search_id or 0,
limit = functionDo.setLimit(100, limit),
filter = {
tdbot = 'searchMessagesFilter' .. filter
}
}
end
function functionDo.deleteChatHistory(chat_id, remove_from_chat_list)
return functionCo.run_table{
tdbot = 'deleteChatHistory',
chat_id = chat_id,
remove_from_chat_list = remove_from_chat_list
}
end
function functionDo.searchCallMessages(from_message_id, limit, only_missed)
return functionCo.run_table{
tdbot = 'searchCallMessages',
from_message_id = from_message_id or 0,
limit = functionDo.setLimit(100, limit),
only_missed = only_missed
}
end
function functionDo.getChatMessageByDate(chat_id, date)
return functionCo.run_table{
tdbot = 'getChatMessageByDate',
chat_id = chat_id,
date = date
}
end
function functionDo.getPublicMessageLink(chat_id, message_id, for_album)
return functionCo.run_table{
tdbot = 'getPublicMessageLink',
chat_id = chat_id,
message_id = message_id,
for_album = for_album
}
end
function functionDo.sendMessageAlbum(chat_id, reply_to_message_id, input_message_contents, disable_notification, from_background)
return functionCo.run_table{
tdbot = 'sendMessageAlbum',
chat_id = chat_id,
reply_to_message_id = reply_to_message_id or 0,
disable_notification = disable_notification,
from_background = from_background,
input_message_contents = functionDo.vectorize(input_message_contents)
}
end
function functionDo.sendBotStartMessage(bot_user_id, chat_id, parameter)
return functionCo.run_table{
tdbot = 'sendBotStartMessage',
bot_user_id = bot_user_id,
chat_id = chat_id,
parameter = tostring(parameter)
}
end
function functionDo.sendInlineQueryResultMessage(chat_id, reply_to_message_id, disable_notification, from_background, query_id, result_id)
return functionCo.run_table{
tdbot = 'sendInlineQueryResultMessage',
chat_id = chat_id,
reply_to_message_id = reply_to_message_id,
disable_notification = disable_notification,
from_background = from_background,
query_id = query_id,
result_id = tostring(result_id)
}
end
function functionDo.forwardMessages(chat_id, from_chat_id, message_ids, disable_notification, from_background, as_album, send_copy, remove_caption)
return functionCo.run_table{
tdbot = 'forwardMessages',
chat_id = chat_id,
from_chat_id = from_chat_id,
message_ids = functionDo.vectorize(message_ids),
disable_notification = disable_notification,
from_background = from_background,
as_album = as_album,
send_copy = send_copy,
remove_caption = remove_caption
}
end
function functionDo.sendChatSetTtlMessage(chat_id, ttl)
return functionCo.run_table{
tdbot = 'sendChatSetTtlMessage',
chat_id = chat_id,
ttl = ttl
}
end
function functionDo.sendChatScreenshotTakenNotification(chat_id)
return functionCo.run_table{
tdbot = 'sendChatScreenshotTakenNotification',
chat_id = chat_id
}
end
function functionDo.deleteMessages(chat_id, message_ids, revoke)
return functionCo.run_table{
tdbot = 'deleteMessages',
chat_id = chat_id,
message_ids = functionDo.vectorize(message_ids),
revoke = revoke
}
end
function functionDo.deleteChatMessagesFromUser(chat_id, user_id)
return functionCo.run_table{
tdbot = 'deleteChatMessagesFromUser',
chat_id = chat_id,
user_id = user_id
}
end
function functionDo.editMessageText(chat_id, message_id, text, parse_mode, disable_web_page_preview, clear_draft, reply_markup)
local tdbot_body = {
tdbot = 'editMessageText',
chat_id = chat_id,
message_id = message_id,
reply_markup = reply_markup,
input_message_content = {
tdbot = 'inputMessageText',
disable_web_page_preview = disable_web_page_preview,
text = {
  text = text
},
clear_draft = clear_draft
}
}
if parse_mode then
tdbot_body.input_message_content.text = functionDo.parseTextEntities(text, parse_mode)
end
return functionCo.run_table(tdbot_body)
end
function functionDo.editMessageCaption(chat_id, message_id, caption, parse_mode, reply_markup)
local tdbot_body = {
tdbot = 'editMessageCaption',
chat_id = chat_id,
message_id = message_id,
reply_markup = reply_markup,
caption = caption
}
if parse_mode then
tdbot_body.caption = functionDo.parseTextEntities(text,parse_mode)
end
return functionCo.run_table(tdbot_body)
end
function functionDo.getTextEntities(text)
return functionCo.run_table{
tdbot = 'getTextEntities',
text = tostring(text)
}
end
function functionDo.getFileMimeType(file_name)
return functionCo.run_table{
tdbot = 'getFileMimeType',
file_name = tostring(file_name)
}
end
function functionDo.getFileExtension(mime_type)
return functionCo.run_table{
tdbot = 'getFileExtension',
mime_type = tostring(mime_type)
}
end
function functionDo.getInlineQueryResults(bot_user_id, chat_id, latitude, longitude, query, offset)
return functionCo.run_table{
tdbot = 'getInlineQueryResults',
bot_user_id = bot_user_id,
chat_id = chat_id,
user_location = {
tdbot = 'location',
latitude = latitude,
longitude = longitude
},
query = tostring(query),
offset = tostring(offset)
}
end
function functionDo.answerCallbackQuery(callback_query_id, text, show_alert, url, cache_time)
return functionCo.run_table{
tdbot = 'answerCallbackQuery',
  callback_query_id = callback_query_id,
  show_alert = show_alert,
  cache_time = cache_time,
  text = text,
  url = url,
}
end
function functionDo.getCallbackQueryAnswer(chat_id, message_id, payload, data, game_short_name)
return functionCo.run_table{
tdbot = 'getCallbackQueryAnswer',
chat_id = chat_id,
message_id = message_id,
payload = {
tdbot = 'callbackQueryPayload' .. payload,
data = data,
game_short_name = game_short_name
}
}
end
function functionDo.deleteChatReplyMarkup(chat_id, message_id)
return functionCo.run_table{
tdbot = 'deleteChatReplyMarkup',
chat_id = chat_id,
message_id = message_id
}
end
function functionDo.sendChatAction(chat_id, action, progress)
return functionCo.run_table{
tdbot = 'sendChatAction',
chat_id = chat_id,
action = {
tdbot = 'chatAction' .. action,
progress = progress or 100
}
}
end
function functionDo.openChat(chat_id)
return functionCo.run_table{
tdbot = 'openChat',
chat_id = chat_id
}
end
function functionDo.closeChat(chat_id)
return functionCo.run_table{
tdbot = 'closeChat',
chat_id = chat_id
}
end
function functionDo.viewMessages(chat_id, message_ids, force_read)
return functionCo.run_table{
tdbot = 'viewMessages',
chat_id = chat_id,
message_ids = functionDo.vectorize(message_ids),
force_read = force_read
}
end
function functionDo.openMessageContent(chat_id, message_id)
return functionCo.run_table{
tdbot = 'openMessageContent',
chat_id = chat_id,
message_id = message_id
}
end
function functionDo.readAllChatMentions(chat_id)
return functionCo.run_table{
tdbot = 'readAllChatMentions',
chat_id = chat_id
}
end
function functionDo.createPrivateChat(user_id, force)
return functionCo.run_table{
tdbot = 'createPrivateChat',
user_id = user_id,
force = force
}
end
function functionDo.createBasicGroupChat(basic_group_id, force)
return functionCo.run_table{
tdbot = 'createBasicGroupChat',
basic_group_id = functionDo.getChatId(basic_group_id).id,
force = force
}
end
function functionDo.createSupergroupChat(supergroup_id, force)
return functionCo.run_table{
tdbot = 'createSupergroupChat',
supergroup_id = functionDo.getChatId(supergroup_id).id,
force = force
}
end
function functionDo.createSecretChat(secret_chat_id)
return functionCo.run_table{
tdbot = 'createSecretChat',
secret_chat_id = secret_chat_id
}
end
function functionDo.createNewBasicGroupChat(user_ids, title)
return functionCo.run_table{
tdbot = 'createNewBasicGroupChat',
user_ids = functionDo.vectorize(user_ids),
title = tostring(title)
}
end
function functionDo.createNewSupergroupChat(title, is_channel, description)
return functionCo.run_table{
tdbot = 'createNewSupergroupChat',
title = tostring(title),
is_channel = is_channel,
description = tostring(description)
}
end
function functionDo.createNewSecretChat(user_id)
return functionCo.run_table{
tdbot = 'createNewSecretChat',
user_id = tonumber(user_id)
}
end
function functionDo.upgradeBasicGroupChatToSupergroupChat(chat_id)
return functionCo.run_table{
tdbot = 'upgradeBasicGroupChatToSupergroupChat',
chat_id = chat_id
}
end
function functionDo.setChatPermissions(chat_id, can_send_messages, can_send_media_messages, can_send_polls, can_send_other_messages, can_add_web_page_previews, can_change_info, can_invite_users, can_pin_messages)
return functionCo.run_table{
tdbot = 'setChatPermissions',
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
function functionDo.setChatTitle(chat_id, title)
return functionCo.run_table{
tdbot = 'setChatTitle',
chat_id = chat_id,
title = tostring(title)
}
end
function functionDo.setChatPhoto(chat_id, photo)
return functionCo.run_table{
tdbot = 'setChatPhoto',
chat_id = chat_id,
photo = {tdbot = 'inputChatPhotoStatic', photo = getInputFile(photo)}
}
end 
function functionDo.setChatDraftMessage(chat_id, reply_to_message_id, text, parse_mode, disable_web_page_preview, clear_draft)
local tdbot_body = {
tdbot = 'setChatDraftMessage',
chat_id = chat_id,
draft_message = {
tdbot = 'draftMessage',
reply_to_message_id = reply_to_message_id,
input_message_text = {
tdbot = 'inputMessageText',
  disable_web_page_preview = disable_web_page_preview,
  text = {text = text},
  clear_draft = clear_draft
}
}
}
if parse_mode then
tdbot_body.draft_message.input_message_text.text = functionDo.parseTextEntities(text, parse_mode)
end
return functionCo.run_table(tdbot_body)
end
function functionDo.toggleChatIsPinned(chat_id, is_pinned)
return functionCo.run_table{
tdbot = 'toggleChatIsPinned',
chat_id = chat_id,
is_pinned = is_pinned
}
end
function functionDo.setChatClientData(chat_id, client_data)
return functionCo.run_table{
tdbot = 'setChatClientData',
chat_id = chat_id,
client_data = tostring(client_data)
}
end
function functionDo.addChatMember(chat_id, user_id, forward_limit)
return functionCo.run_table{
tdbot = 'addChatMember',
chat_id = chat_id,
user_id = user_id,
forward_limit = functionDo.setLimit(300, forward_limit)
}
end
function functionDo.addChatMembers(chat_id, user_ids)
return functionCo.run_table{
tdbot = 'addChatMembers',
chat_id = chat_id,
user_ids = functionDo.vectorize(user_ids)
}
end
function functionDo.setChatMemberStatus(chat_id, user_id, status, right)
local right = right and functionDo.vectorize(right) or {}
local status = string.lower(status)
if status == 'creator' then
chat_member_status = {
tdbot = 'chatMemberStatusCreator',
is_member = right[1] or 1
}
elseif status == 'administrator' then
chat_member_status = {
tdbot = 'chatMemberStatusAdministrator',
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
tdbot = 'chatPermissions',
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
tdbot = 'chatMemberStatusRestricted'
}
elseif status == 'banned' then
chat_member_status = {
tdbot = 'chatMemberStatusBanned',
banned_until_date = right[1] or 0
}
end
return functionCo.run_table{
tdbot = 'setChatMemberStatus',
chat_id = chat_id,
member_id = {_='messageSenderUser', user_id = user_id},
status = chat_member_status or {}
}
end
function functionDo.SetAdmin(chat_id, user_id,right)
chat_member_status = {
tdbot = 'chatMemberStatusAdministrator',
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
return functionCo.run_table{
tdbot = 'setChatMemberStatus',
chat_id = chat_id,
member_id = {_='messageSenderUser', user_id = user_id},
status = chat_member_status or {}
}
end

function functionDo.getChatMember(chat_id, user_id)
return functionCo.run_table{
tdbot = 'getChatMember',
chat_id = chat_id,
member_id = {_='messageSenderUser', user_id = user_id}
}
end 
function functionDo.searchChatMembers(chat_id, query, limit)
return functionCo.run_table{
tdbot = 'searchChatMembers',
chat_id = chat_id,
query = tostring(query),
limit = functionDo.setLimit(200, limit)
}
end
function functionDo.getChatAdministrators(chat_id)
return functionCo.run_table{
tdbot = 'getChatAdministrators',
chat_id = chat_id
}
end
function functionDo.setPinnedChats(chat_ids)
return functionCo.run_table{
tdbot = 'setPinnedChats',
chat_ids = functionDo.vectorize(chat_ids)
}
end
function functionDo.downloadFile(file_id, priority)
return functionCo.run_table{
tdbot = 'downloadFile',
file_id = file_id,
priority = priority or 32
}
end
function functionDo.cancelDownloadFile(file_id, only_if_pending)
return functionCo.run_table{
tdbot = 'cancelDownloadFile',
file_id = file_id,
only_if_pending = only_if_pending
}
end
function functionDo.uploadFile(file, file_type, priority)
local ftype = file_type or 'Unknown'
return functionCo.run_table{
tdbot = 'uploadFile',
file = functionDo.getInputFile(file),
file_type = {
tdbot = 'fileType' .. ftype
},
priority = priority or 32
}
end
function functionDo.cancelUploadFile(file_id)
return functionCo.run_table{
tdbot = 'cancelUploadFile',
file_id = file_id
}
end
function functionDo.deleteFile(file_id)
return functionCo.run_table{
tdbot = 'deleteFile',
file_id = file_id
}
end
function functionDo.generateChatInviteLink(chat_id,name,expire_date,member_limit,creates_join_request)
return functionCo.run_table{
tdbot = 'createChatInviteLink',
chat_id = chat_id,
name = tostring(name),
expire_date = tonumber(expire_date),
member_limit = tonumber(member_limit),
creates_join_request = creates_join_request
}
end 
function functionDo.joinChatByUsernam(username)
if type(username) == 'string' and 5 <= #username then
local result = functionDo.searchPublicChat(username)
if result.type and result.type.tdbot == 'chatTypeSupergroup' then
return functionCo.run_table{
tdbot = 'joinChat',
  chat_id = result.id
}
else
return result
end
end
end
function functionDo.checkChatInviteLink(invite_link)
return functionCo.run_table{
tdbot = 'checkChatInviteLink',
invite_link = tostring(invite_link)
}
end
function functionDo.joinChatByInviteLink(invite_link)
return functionCo.run_table{
tdbot = 'joinChatByInviteLink',
invite_link = tostring(invite_link)
}
end
function functionDo.leaveChat(chat_id)
return functionCo.run_table{
tdbot = 'leaveChat',
chat_id = chat_id
}
end
function functionDo.createCall(user_id, udp_p2p, udp_reflector, min_layer, max_layer)
return functionCo.run_table{
tdbot = 'createCall',
user_id = user_id,
protocol = {
tdbot = 'callProtocol',
udp_p2p = udp_p2p,
udp_reflector = udp_reflector,
min_layer = min_layer or 65,
max_layer = max_layer or 65
}
}
end
function functionDo.acceptCall(call_id, udp_p2p, udp_reflector, min_layer, max_layer)
return functionCo.run_table{
tdbot = 'acceptCall',
call_id = call_id,
protocol = {
tdbot = 'callProtocol',
udp_p2p = udp_p2p,
udp_reflector = udp_reflector,
min_layer = min_layer or 65,
max_layer = max_layer or 65
}
}
end
function functionDo.blockUser(user_id)
return functionCo.run_table{
tdbot = 'blockUser',
user_id = user_id
}
end
function functionDo.unblockUser(user_id)
return functionCo.run_table{
tdbot = 'unblockUser',
user_id = user_id
}
end
function functionDo.getBlockedUsers(offset, limit)
return functionCo.run_table{
tdbot = 'getBlockedUsers',
offset = offset or 0,
limit = functionDo.setLimit(100, limit)
}
end
function functionDo.getContacts()
return functionCo.run_table{
tdbot = 'getContacts'
}
end
function functionDo.importContacts(contacts)
local result = {}
  for key, value in pairs(contacts) do
result[#result + 1] = {
tdbot = 'contact',
phone_number = tostring(value.phone_number),
first_name = tostring(value.first_name),
last_name = tostring(value.last_name),
user_id = value.user_id or 0
}
end
return functionCo.run_table{
tdbot = 'importContacts',
contacts = result
}
end
function functionDo.searchContacts(query, limit)
return functionCo.run_table{
tdbot = 'searchContacts',
query = tostring(query),
limit = limit
}
end
function functionDo.removeContacts(user_ids)
return functionCo.run_table{
tdbot = 'removeContacts',
user_ids = functionDo.vectorize(user_ids)
}
end
function functionDo.getImportedContactCount()
return functionCo.run_table{
tdbot = 'getImportedContactCount'
}
end
function functionDo.changeImportedContacts(phone_number, first_name, last_name, user_id)
return functionCo.run_table{
tdbot = 'changeImportedContacts',
contacts = {
tdbot = 'contact',
phone_number = tostring(phone_number),
first_name = tostring(first_name),
last_name = tostring(last_name),
user_id = user_id or 0
}
}
end
function functionDo.clearImportedContacts()
return functionCo.run_table{
tdbot = 'clearImportedContacts'
}
end
function functionDo.getUserProfilePhotos(user_id, offset, limit)
return functionCo.run_table{
tdbot = 'getUserProfilePhotos',
user_id = user_id,
offset = offset or 0,
limit = functionDo.setLimit(100, limit)
}
end
function functionDo.getStickers(emoji, limit)
return functionCo.run_table{
tdbot = 'getStickers',
emoji = tostring(emoji),
limit = functionDo.setLimit(100, limit)
}
end
function functionDo.searchStickers(emoji, limit)
return functionCo.run_table{
tdbot = 'searchStickers',
emoji = tostring(emoji),
limit = limit
}
end
function functionDo.getArchivedStickerSets(is_masks, offset_sticker_set_id, limit)
return functionCo.run_table{
tdbot = 'getArchivedStickerSets',
is_masks = is_masks,
offset_sticker_set_id = offset_sticker_set_id,
limit = limit
}
end
function functionDo.getTrendingStickerSets()
return functionCo.run_table{
tdbot = 'getTrendingStickerSets'
}
end
function functionDo.getAttachedStickerSets(file_id)
return functionCo.run_table{
tdbot = 'getAttachedStickerSets',
file_id = file_id
}
end
function functionDo.getStickerSet(set_id)
return functionCo.run_table{
tdbot = 'getStickerSet',
set_id = set_id
}
end
function functionDo.searchStickerSet(name)
return functionCo.run_table{
tdbot = 'searchStickerSet',
name = tostring(name)
}
end
function functionDo.searchInstalledStickerSets(is_masks, query, limit)
return functionCo.run_table{
tdbot = 'searchInstalledStickerSets',
is_masks = is_masks,
query = tostring(query),
limit = limit
}
end
function functionDo.searchStickerSets(query)
return functionCo.run_table{
tdbot = 'searchStickerSets',
query = tostring(query)
}
end
function functionDo.changeStickerSet(set_id, is_installed, is_archived)
return functionCo.run_table{
tdbot = 'changeStickerSet',
set_id = set_id,
is_installed = is_installed,
is_archived = is_archived
}
end
function functionDo.viewTrendingStickerSets(sticker_set_ids)
return functionCo.run_table{
tdbot = 'viewTrendingStickerSets',
sticker_set_ids = functionDo.vectorize(sticker_set_ids)
}
end
function functionDo.reorderInstalledStickerSets(is_masks, sticker_set_ids)
return functionCo.run_table{
tdbot = 'reorderInstalledStickerSets',
is_masks = is_masks,
sticker_set_ids = functionDo.vectorize(sticker_set_ids)
}
end
function functionDo.getRecentStickers(is_attached)
return functionCo.run_table{
tdbot = 'getRecentStickers',
is_attached = is_attached
}
end
function functionDo.addRecentSticker(is_attached, sticker)
return functionCo.run_table{
tdbot = 'addRecentSticker',
is_attached = is_attached,
sticker = functionDo.getInputFile(sticker)
}
end
function functionDo.clearRecentStickers(is_attached)
return functionCo.run_table{
tdbot = 'clearRecentStickers',
is_attached = is_attached
}
end
function functionDo.getFavoriteStickers()
return functionCo.run_table{
tdbot = 'getFavoriteStickers'
}
end
function functionDo.addFavoriteSticker(sticker)
return functionCo.run_table{
tdbot = 'addFavoriteSticker',
sticker = functionDo.getInputFile(sticker)
}
end
function functionDo.removeFavoriteSticker(sticker)
return functionCo.run_table{
tdbot = 'removeFavoriteSticker',
sticker = functionDo.getInputFile(sticker)
}
end
function functionDo.getStickerEmojis(sticker)
return functionCo.run_table{
tdbot = 'getStickerEmojis',
sticker = functionDo.getInputFile(sticker)
}
end
function functionDo.getSavedAnimations()
return functionCo.run_table{
tdbot = 'getSavedAnimations'
}
end
function functionDo.addSavedAnimation(animation)
return functionCo.run_table{
tdbot = 'addSavedAnimation',
animation = functionDo.getInputFile(animation)
}
end
function functionDo.removeSavedAnimation(animation)
return functionCo.run_table{
tdbot = 'removeSavedAnimation',
animation = functionDo.getInputFile(animation)
}
end
function functionDo.getRecentInlineBots()
return functionCo.run_table{
tdbot = 'getRecentInlineBots'
}
end
function functionDo.searchHashtags(prefix, limit)
return functionCo.run_table{
tdbot = 'searchHashtags',
prefix = tostring(prefix),
limit = limit
}
end
function functionDo.removeRecentHashtag(hashtag)
return functionCo.run_table{
tdbot = 'removeRecentHashtag',
hashtag = tostring(hashtag)
}
end
function functionDo.getWebPagePreview(text)
return functionCo.run_table{
tdbot = 'getWebPagePreview',
text = {
text = text
}
}
end
function functionDo.getWebPageInstantView(url, force_full)
return functionCo.run_table{
tdbot = 'getWebPageInstantView',
url = tostring(url),
force_full = force_full
}
end
function functionDo.getNotificationSettings(scope, chat_id)
return functionCo.run_table{
tdbot = 'getNotificationSettings',
scope = {
tdbot = 'notificationSettingsScope' .. scope,
chat_id = chat_id
}
}
end
function functionDo.setNotificationSettings(scope, chat_id, mute_for, sound, show_preview)
return functionCo.run_table{
tdbot = 'setNotificationSettings',
scope = {
tdbot = 'notificationSettingsScope' .. scope,
chat_id = chat_id
},
notification_settings = {
tdbot = 'notificationSettings',
mute_for = mute_for,
sound = tostring(sound),
show_preview = show_preview
}
}
end
function functionDo.resetAllNotificationSettings()
return functionCo.run_table{
tdbot = 'resetAllNotificationSettings'
}
end
function functionDo.setProfilePhoto(photo)
return functionCo.run_table{
tdbot = 'setProfilePhoto',
photo = functionDo.getInputFile(photo)
}
end
function functionDo.deleteProfilePhoto(profile_photo_id)
return functionCo.run_table{
tdbot = 'deleteProfilePhoto',
profile_photo_id = profile_photo_id
}
end
function functionDo.setName(first_name, last_name)
return functionCo.run_table{
tdbot = 'setName',
first_name = tostring(first_name),
last_name = tostring(last_name)
}
end
function functionDo.setBio(bio)
return functionCo.run_table{
tdbot = 'setBio',
bio = tostring(bio)
}
end
function functionDo.setUsername(username)
return functionCo.run_table{
tdbot = 'setUsername',
username = tostring(username)
}
end
function functionDo.getActiveSessions()
return functionCo.run_table{
tdbot = 'getActiveSessions'
}
end
function functionDo.terminateAllOtherSessions()
return functionCo.run_table{
tdbot = 'terminateAllOtherSessions'
}
end
function functionDo.terminateSession(session_id)
return functionCo.run_table{
tdbot = 'terminateSession',
session_id = session_id
}
end
function functionDo.toggleBasicGroupAdministrators(basic_group_id, everyone_is_administrator)
return functionCo.run_table{
tdbot = 'toggleBasicGroupAdministrators',
basic_group_id = functionDo.getChatId(basic_group_id).id,
everyone_is_administrator = everyone_is_administrator
}
end
function functionDo.setSupergroupUsername(supergroup_id, username)
return functionCo.run_table{
tdbot = 'setSupergroupUsername',
supergroup_id = functionDo.getChatId(supergroup_id).id,
username = tostring(username)
}
end
function functionDo.setSupergroupStickerSet(supergroup_id, sticker_set_id)
return functionCo.run_table{
tdbot = 'setSupergroupStickerSet',
supergroup_id = functionDo.getChatId(supergroup_id).id,
sticker_set_id = sticker_set_id
}
end
function functionDo.toggleSupergroupInvites(supergroup_id, anyone_can_invite)
return functionCo.run_table{
tdbot = 'toggleSupergroupInvites',
supergroup_id = functionDo.getChatId(supergroup_id).id,
anyone_can_invite = anyone_can_invite
}
end
function functionDo.toggleSupergroupSignMessages(supergroup_id, sign_messages)
return functionCo.run_table{
tdbot = 'toggleSupergroupSignMessages',
supergroup_id = functionDo.getChatId(supergroup_id).id,
sign_messages = sign_messages
}
end
function functionDo.toggleSupergroupIsAllHistoryAvailable(supergroup_id, is_all_history_available)
return functionCo.run_table{
tdbot = 'toggleSupergroupIsAllHistoryAvailable',
supergroup_id = functionDo.getChatId(supergroup_id).id,
is_all_history_available = is_all_history_available
}
end
function functionDo.setChatDescription(chat_id, description)
return functionCo.run_table{
tdbot = 'setChatDescription',
chat_id = chat_id,
description = tostring(description)
}
end
function functionDo.pinChatMessage(chat_id, message_id, disable_notification)
return functionCo.run_table{
tdbot = 'pinChatMessage',
chat_id = chat_id,
message_id = message_id,
disable_notification = disable_notification
}
end
function functionDo.unpinChatMessage(chat_id)
return functionCo.run_table{
tdbot = 'unpinChatMessage',
chat_id = chat_id
}
end
function functionDo.reportSupergroupSpam(supergroup_id, user_id, message_ids)
return functionCo.run_table{
tdbot = 'reportSupergroupSpam',
supergroup_id = functionDo.getChatId(supergroup_id).id,
user_id = user_id,
message_ids = functionDo.vectorize(message_ids)
}
end
function functionDo.getSupergroupMembers(supergroup_id, filter, query, offset, limit)
local filter = filter or 'Recent'
return functionCo.run_table{
tdbot = 'getSupergroupMembers',
supergroup_id = functionDo.getChatId(supergroup_id).id,
filter = {
tdbot = 'supergroupMembersFilter' .. filter,
query = query
},
offset = offset or 0,
limit = functionDo.setLimit(200, limit)
}
end
function functionDo.deleteSupergroup(supergroup_id)
return functionCo.run_table{
tdbot = 'deleteSupergroup',
supergroup_id = functionDo.getChatId(supergroup_id).id
}
end
function functionDo.closeSecretChat(secret_chat_id)
return functionCo.run_table{
tdbot = 'closeSecretChat',
secret_chat_id = secret_chat_id
}
end
function functionDo.getChatEventLog(chat_id, query, from_event_id, limit, filters, user_ids)
local filters = filters or {1,1,1,1,1,1,1,1,1,1}
return functionCo.run_table{
tdbot = 'getChatEventLog',
chat_id = chat_id,
query = tostring(query) or '',
from_event_id = from_event_id or 0,
limit = functionDo.setLimit(100, limit),
filters = {
tdbot = 'chatEventLogFilters',
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
user_ids = functionDo.vectorize(user_ids)
}
end
function functionDo.getSavedOrderInfo()
return functionCo.run_table{
tdbot = 'getSavedOrderInfo'
}
end
function functionDo.deleteSavedOrderInfo()
return functionCo.run_table{
tdbot = 'deleteSavedOrderInfo'
}
end
function functionDo.deleteSavedCredentials()
return functionCo.run_table{
tdbot = 'deleteSavedCredentials'
}
end
function functionDo.getSupportUser()
return functionCo.run_table{
tdbot = 'getSupportUser'
}
end
function functionDo.getWallpapers()
return functionCo.run_table{
tdbot = 'getWallpapers'
}
end
function functionDo.setUserPrivacySettingRules(setting, rules, allowed_user_ids, restricted_user_ids)
local setting_rules = {
[0] = {
tdbot = 'userPrivacySettingRule' .. rules
}
}
if allowed_user_ids then
setting_rules[#setting_rules + 1] = {
{
tdbot = 'userPrivacySettingRuleAllowUsers',
  user_ids = functionDo.vectorize(allowed_user_ids)
}
}
elseif restricted_user_ids then
setting_rules[#setting_rules + 1] = {
{
tdbot = 'userPrivacySettingRuleRestrictUsers',
  user_ids = functionDo.vectorize(restricted_user_ids)
}
}
end
return functionCo.run_table{
tdbot = 'setUserPrivacySettingRules',
setting = {
tdbot = 'userPrivacySetting' .. setting
},
rules = {
tdbot = 'userPrivacySettingRules',
rules = setting_rules
}
}
end
function functionDo.getUserPrivacySettingRules(setting)
return functionCo.run_table{
tdbot = 'getUserPrivacySettingRules',
setting = {
tdbot = 'userPrivacySetting' .. setting
}
}
end
function functionDo.getOption(name)
return functionCo.run_table{
tdbot = 'getOption',
name = tostring(name)
}
end
function functionDo.setOption(name, option_value, value)
return functionCo.run_table{
tdbot = 'setOption',
name = tostring(name),
value = {
tdbot = 'optionValue' .. option_value,
value = value
}
}
end
function functionDo.setAccountTtl(ttl)
return functionCo.run_table{
tdbot = 'setAccountTtl',
ttl = {
tdbot = 'accountTtl',
days = ttl
}
}
end
function functionDo.getAccountTtl()
return functionCo.run_table{
tdbot = 'getAccountTtl'
}
end
function functionDo.deleteAccount(reason)
return functionCo.run_table{
tdbot = 'deleteAccount',
reason = tostring(reason)
}
end
function functionDo.getChatReportSpamState(chat_id)
return functionCo.run_table{
tdbot = 'getChatReportSpamState',
chat_id = chat_id
}
end
function functionDo.reportChat(chat_id, reason, text, message_ids)
return functionCo.run_table{
tdbot = 'reportChat',
chat_id = chat_id,
reason = {
tdbot = 'chatReportReason' .. reason,
text = text
},
message_ids = functionDo.vectorize(message_ids)
}
end
function functionDo.getStorageStatistics(chat_limit)
return functionCo.run_table{
tdbot = 'getStorageStatistics',
chat_limit = chat_limit
}
end
function functionDo.getStorageStatisticsFast()
return functionCo.run_table{
tdbot = 'getStorageStatisticsFast'
}
end
function functionDo.optimizeStorage(size, ttl, count, immunity_delay, file_type, chat_ids, exclude_chat_ids, chat_limit)
local file_type = file_type or ''
return functionCo.run_table{
tdbot = 'optimizeStorage',
size = size or -1,
ttl = ttl or -1,
count = count or -1,
immunity_delay = immunity_delay or -1,
file_type = {
tdbot = 'fileType' .. file_type
},
chat_ids = functionDo.vectorize(chat_ids),
exclude_chat_ids = functionDo.vectorize(exclude_chat_ids),
chat_limit = chat_limit
}
end
function functionDo.setNetworkType(type)
return functionCo.run_table{
tdbot = 'setNetworkType',
type = {
tdbot = 'networkType' .. type
},
}
end
function functionDo.getNetworkStatistics(only_current)
return functionCo.run_table{
tdbot = 'getNetworkStatistics',
only_current = only_current
}
end
function functionDo.addNetworkStatistics(entry, file_type, network_type, sent_bytes, received_bytes, duration)
local file_type = file_type or 'None'
return functionCo.run_table{
tdbot = 'addNetworkStatistics',
entry = {
tdbot = 'networkStatisticsEntry' .. entry,
file_type = {
tdbot = 'fileType' .. file_type
},
network_type = {
tdbot = 'networkType' .. network_type
},
sent_bytes = sent_bytes,
received_bytes = received_bytes,
duration = duration
}
}
end
function functionDo.resetNetworkStatistics()
return functionCo.run_table{
tdbot = 'resetNetworkStatistics'
}
end
function functionDo.getCountryCode()
return functionCo.run_table{
tdbot = 'getCountryCode'
}
end
function functionDo.getInviteText()
return functionCo.run_table{
tdbot = 'getInviteText'
}
end
function functionDo.getTermsOfService()
return functionCo.run_table{
tdbot = 'getTermsOfService'
}
end
function functionDo.sendText(chat_id, reply_to_message_id, text, parse_mode, disable_web_page_preview, clear_draft, disable_notification, from_background, reply_markup)
local input_message_content = {
tdbot = 'inputMessageText',
disable_web_page_preview = disable_web_page_preview,
text = {text = text},
clear_draft = clear_draft
}
return functionDo.sendMessage(chat_id, reply_to_message_id, input_message_content, parse_mode, disable_notification, from_background, reply_markup)
end
function functionDo.sendAnimation(chat_id, reply_to_message_id, animation, caption, parse_mode, duration, width, height, thumbnail, thumb_width, thumb_height, disable_notification, from_background, reply_markup)
local input_message_content = {
tdbot = 'inputMessageAnimation',
animation = functionDo.getInputFile(animation),
thumbnail = {
tdbot = 'inputThumbnail',
thumbnail = functionDo.getInputFile(thumbnail),
width = thumb_width,
height = thumb_height
},
caption = {text = caption},
duration = duration,
width = width,
height = height
}
return functionDo.sendMessage(chat_id, reply_to_message_id, input_message_content, parse_mode, disable_notification, from_background, reply_markup)
end
function functionDo.sendAudio(chat_id, reply_to_message_id, audio, caption, parse_mode, duration, title, performer, thumbnail, thumb_width, thumb_height, disable_notification, from_background, reply_markup)
local input_message_content = {
tdbot = 'inputMessageAudio',
audio = functionDo.getInputFile(audio),
album_cover_thumbnail = {
tdbot = 'inputThumbnail',
thumbnail = functionDo.getInputFile(thumbnail),
width = thumb_width,
height = thumb_height
},
caption = {text = caption},
duration = duration,
title = tostring(title),
performer = tostring(performer)
}
return functionDo.sendMessage(chat_id, reply_to_message_id, input_message_content, parse_mode, disable_notification, from_background, reply_markup)
end
function functionDo.sendDocument(chat_id, reply_to_message_id, document, caption, parse_mode, thumbnail, thumb_width, thumb_height, disable_notification, from_background, reply_markup)
local input_message_content = {
tdbot = 'inputMessageDocument',
document = functionDo.getInputFile(document),
thumbnail = {
tdbot = 'inputThumbnail',
thumbnail = functionDo.getInputFile(thumbnail),
width = thumb_width,
height = thumb_height
},
caption = {text = caption}
}
return functionDo.sendMessage(chat_id, reply_to_message_id, input_message_content, parse_mode, disable_notification, from_background, reply_markup)
end
function functionDo.sendPhoto(chat_id, reply_to_message_id, photo, caption, parse_mode, added_sticker_file_ids, width, height, ttl, thumbnail, thumb_width, thumb_height, disable_notification, from_background, reply_markup)
local input_message_content = {
tdbot = 'inputMessagePhoto',
photo = functionDo.getInputFile(photo),
thumbnail = {
tdbot = 'inputThumbnail',
thumbnail = functionDo.getInputFile(thumbnail),
width = thumb_width,
height = thumb_height
},
caption = {text = caption},
added_sticker_file_ids = functionDo.vectorize(added_sticker_file_ids),
width = width,
height = height,
ttl = ttl or 0
}
return functionDo.sendMessage(chat_id, reply_to_message_id, input_message_content, parse_mode, disable_notification, from_background, reply_markup)
end
function functionDo.sendSticker(chat_id, reply_to_message_id, sticker, width, height, disable_notification, thumbnail, thumb_width, thumb_height, from_background, reply_markup)
local input_message_content = {
tdbot = 'inputMessageSticker',
sticker = functionDo.getInputFile(sticker),
thumbnail = {
tdbot = 'inputThumbnail',
thumbnail = functionDo.getInputFile(thumbnail),
width = thumb_width,
height = thumb_height
},
width = width,
height = height
}
return functionDo.sendMessage(chat_id, reply_to_message_id, input_message_content, nil, disable_notification, from_background, reply_markup)
end
function functionDo.sendVideo(chat_id, reply_to_message_id, video, caption, parse_mode, added_sticker_file_ids, duration, width, height, ttl, thumbnail, thumb_width, thumb_height, disable_notification, from_background, reply_markup)
local input_message_content = {
tdbot = 'inputMessageVideo',
video = functionDo.getInputFile(video),
thumbnail = {
tdbot = 'inputThumbnail',
thumbnail = functionDo.getInputFile(thumbnail),
width = thumb_width,
height = thumb_height
},
caption = {text = caption},
added_sticker_file_ids = functionDo.vectorize(added_sticker_file_ids),
duration = duration,
width = width,
height = height,
ttl = ttl
}
return functionDo.sendMessage(chat_id, reply_to_message_id, input_message_content, parse_mode, disable_notification, from_background, reply_markup)
end
function functionDo.sendVideoNote(chat_id, reply_to_message_id, video_note, duration, length, thumbnail, thumb_width, thumb_height, disable_notification, from_background, reply_markup)
local input_message_content = {
tdbot = 'inputMessageVideoNote',
video_note = functionDo.getInputFile(video_note),
thumbnail = {
tdbot = 'inputThumbnail',
thumbnail = functionDo.getInputFile(thumbnail),
width = thumb_width,
height = thumb_height
},
duration = duration,
length = length
}
return functionDo.sendMessage(chat_id, reply_to_message_id, input_message_content, nil, disable_notification, from_background, reply_markup)
end
function functionDo.sendVoiceNote(chat_id, reply_to_message_id, voice_note, caption, parse_mode, duration, waveform, disable_notification, from_background, reply_markup)
local input_message_content = {
tdbot = 'inputMessageVoiceNote',
voice_note = functionDo.getInputFile(voice_note),
caption = {text = caption},
duration = duration,
waveform = waveform
}
return functionDo.sendMessage(chat_id, reply_to_message_id, input_message_content, parse_mode, disable_notification, from_background, reply_markup)
end
function functionDo.sendLocation(chat_id, reply_to_message_id, latitude, longitude, disable_notification, from_background, reply_markup)
local input_message_content = {
tdbot = 'inputMessageLocation',
location = {
tdbot = 'location',
latitude = latitude,
longitude = longitude
},
live_period = liveperiod
}
return functionDo.sendMessage(chat_id, reply_to_message_id, input_message_content, nil, disable_notification, from_background, reply_markup)
end
function functionDo.sendVenue(chat_id, reply_to_message_id, latitude, longitude, title, address, provider, id, disable_notification, from_background, reply_markup)
local input_message_content = {
tdbot = 'inputMessageVenue',
venue = {
tdbot = 'venue',
location = {
tdbot = 'location',
  latitude = latitude,
  longitude = longitude
},
title = tostring(title),
address = tostring(address),
provider = tostring(provider),
id = tostring(id)
}
}
return functionDo.sendMessage(chat_id, reply_to_message_id, input_message_content, nil, disable_notification, from_background, reply_markup)
end
function functionDo.sendContact(chat_id, reply_to_message_id, phone_number, first_name, last_name, user_id, disable_notification, from_background, reply_markup)
local input_message_content = {
tdbot = 'inputMessageContact',
contact = {
tdbot = 'contact',
phone_number = tostring(phone_number),
first_name = tostring(first_name),
last_name = tostring(last_name),
user_id = user_id
}
}
return functionDo.sendMessage(chat_id, reply_to_message_id, input_message_content, nil, disable_notification, from_background, reply_markup)
end
function functionDo.sendInvoice(chat_id, reply_to_message_id, invoice, title, description, photo_url, photo_size, photo_width, photo_height, payload, provider_token, provider_data, start_parameter, disable_notification, from_background, reply_markup)
local input_message_content = {
tdbot = 'inputMessageInvoice',
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
return functionDo.sendMessage(chat_id, reply_to_message_id, input_message_content, nil, disable_notification, from_background, reply_markup)
end
function functionDo.sendForwarded(chat_id, reply_to_message_id, from_chat_id, message_id, in_game_share, disable_notification, from_background, reply_markup)
local input_message_content = {
tdbot = 'inputMessageForwarded',
from_chat_id = from_chat_id,
message_id = message_id,
in_game_share = in_game_share
}
return functionDo.sendMessage(chat_id, reply_to_message_id, input_message_content, nil, disable_notification, from_background, reply_markup)
end
function functionDo.sendPoll(chat_id, reply_to_message_id, question, options, pollType,op,is_anonymous, allow_multiple_answers)
if pollType == "Quiz" then
typet = {
explanation = {
text = op
},
tdbot = 'pollType'..pollType,
allow_multiple_answers = allow_multiple_answers
}
else
typet = {
tdbot = 'pollType'..pollType,
allow_multiple_answers = allow_multiple_answers
}
end
local input_message_content = {
tdbot = 'inputMessagePoll',
is_anonymous = is_anonymous,
question = question,
type = typet,
options = options
}
return functionDo.sendMessage(chat_id, reply_to_message_id, input_message_content)
end
function functionDo.getPollVoters(chat_id, message_id, option_id, offset, limit)
return functionCo.run_table{
tdbot = 'getPollVoters',
chat_id = chat_id,
message_id = message_id,
option_id = option_id,
limit = functionDo.setLimit(50 , limit),
offset = offset
}
end
function functionDo.setPollAnswer(chat_id, message_id, option_ids)
return functionCo.run_table{
tdbot = 'setPollAnswer',
chat_id = chat_id,
message_id = message_id,
option_ids = option_ids
}
end
function functionDo.stopPoll(chat_id, message_id, reply_markup)
return functionCo.run_table{
tdbot = 'stopPoll',
chat_id = chat_id,
message_id = message_id,
reply_markup = reply_markup
}
end
function functionDo.getInputMessage(value)
if type(value) ~= 'table' then
return value
end
if type(value.type) == 'string' then
if value.parse_mode and value.caption then
caption = functionDo.parseTextEntities(value.caption, value.parse_mode)
  elseif value.caption and not value.parse_mode then
caption = {
  text = value.caption
}
  elseif value.parse_mode and value.text then
text = functionDo.parseTextEntities(value.text, value.parse_mode)
  elseif not value.parse_mode and value.text then
text = {
  text = value.text
}
end
value.type = string.lower(value.type)
if value.type == 'text' then
return {
tdbot = 'inputMessageText',
  disable_web_page_preview = value.disable_web_page_preview,
  text = text,
  clear_draft = value.clear_draft
}
  elseif value.type == 'animation' then
return {
tdbot = 'inputMessageAnimation',
  animation = functionDo.getInputFile(value.animation),
  thumbnail = {
tdbot = 'inputThumbnail',
thumbnail = functionDo.getInputFile(value.thumbnail),
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
tdbot = 'inputMessageAudio',
  audio = functionDo.getInputFile(value.audio),
  album_cover_thumbnail = {
tdbot = 'inputThumbnail',
thumbnail = functionDo.getInputFile(value.thumbnail),
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
tdbot = 'inputMessageDocument',
  document = functionDo.getInputFile(value.document),
  thumbnail = {
tdbot = 'inputThumbnail',
thumbnail = functionDo.getInputFile(value.thumbnail),
width = value.thumb_width,
height = value.thumb_height
},
  caption = caption
}
  elseif value.type == 'photo' then
return {
tdbot = 'inputMessagePhoto',
  photo = functionDo.getInputFile(value.photo),
  thumbnail = {
tdbot = 'inputThumbnail',
thumbnail = functionDo.getInputFile(value.thumbnail),
width = value.thumb_width,
height = value.thumb_height
},
  caption = caption,
  added_sticker_file_ids = functionDo.vectorize(value.added_sticker_file_ids),
  width = value.width,
  height = value.height,
  ttl = value.ttl or 0
}
  elseif value.text == 'video' then
return {
tdbot = 'inputMessageVideo',
  video = functionDo.getInputFile(value.video),
  thumbnail = {
tdbot = 'inputThumbnail',
thumbnail = functionDo.getInputFile(value.thumbnail),
width = value.thumb_width,
height = value.thumb_height
},
  caption = caption,
  added_sticker_file_ids = functionDo.vectorize(value.added_sticker_file_ids),
  duration = value.duration,
  width = value.width,
  height = value.height,
  ttl = value.ttl or 0
}
  elseif value.text == 'videonote' then
return {
tdbot = 'inputMessageVideoNote',
  video_note = functionDo.getInputFile(value.video_note),
  thumbnail = {
tdbot = 'inputThumbnail',
thumbnail = functionDo.getInputFile(value.thumbnail),
width = value.thumb_width,
height = value.thumb_height
},
  duration = value.duration,
  length = value.length
}
  elseif value.text == 'voice' then
return {
tdbot = 'inputMessageVoiceNote',
  voice_note = functionDo.getInputFile(value.voice_note),
  caption = caption,
  duration = value.duration,
  waveform = value.waveform
}
  elseif value.text == 'location' then
return {
tdbot = 'inputMessageLocation',
  location = {
tdbot = 'location',
latitude = value.latitude,
longitude = value.longitude
},
  live_period = value.liveperiod
}
  elseif value.text == 'contact' then
return {
tdbot = 'inputMessageContact',
  contact = {
tdbot = 'contact',
phone_number = tostring(value.phone_number),
first_name = tostring(value.first_name),
last_name = tostring(value.last_name),
user_id = value.user_id
}
}
  elseif value.text == 'contact' then
return {
tdbot = 'inputMessageContact',
  contact = {
tdbot = 'contact',
phone_number = tostring(value.phone_number),
first_name = tostring(value.first_name),
last_name = tostring(value.last_name),
user_id = value.user_id
}
}
end
end
end
function functionDo.editInlineMessageText(inline_message_id, input_message_content, reply_markup)
return functionCo.run_table{
tdbot = 'editInlineMessageText',
input_message_content = functionDo.getInputMessage(input_message_content),
reply_markup = reply_markup
}
end
function functionDo.answerInlineQuery(inline_query_id, results, next_offset, switch_pm_text, switch_pm_parameter, is_personal, cache_time)
local answerInlineQueryResults = {}
  for key, value in pairs(results) do
local newAnswerInlineQueryResults_id = #answerInlineQueryResults + 1
if type(value) == 'table' and type(value.type) == 'string' then
value.type = string.lower(value.type)
if value.type == 'gif' then
  answerInlineQueryResults[newAnswerInlineQueryResults_id] = {
tdbot = 'inputInlineQueryResultAnimatedGif',
id = value.id,
title = value.title,
thumbnail_url = value.thumbnail_url,
gif_url = value.gif_url,
gif_duration = value.gif_duration,
gif_width = value.gif_width,
gif_height = value.gif_height,
reply_markup = functionDo.replyMarkup{
type = 'inline',
data = value.reply_markup
},
input_message_content = functionDo.getInputMessage(value.input)
}
elseif value.type == 'mpeg4' then
  answerInlineQueryResults[newAnswerInlineQueryResults_id] = {
tdbot = 'inputInlineQueryResultAnimatedMpeg4',
id = value.id,
title = value.title,
thumbnail_url = value.thumbnail_url,
mpeg4_url = value.mpeg4_url,
mpeg4_duration = value.mpeg4_duration,
mpeg4_width = value.mpeg4_width,
mpeg4_height = value.mpeg4_height,
reply_markup = functionDo.replyMarkup{
type = 'inline',
data = value.reply_markup
},
input_message_content = functionDo.getInputMessage(value.input)
}
elseif value.type == 'article' then
  answerInlineQueryResults[newAnswerInlineQueryResults_id] = {
tdbot = 'inputInlineQueryResultArticle',
id = value.id,
url = value.url,
hide_url = value.hide_url,
title = value.title,
description = value.description,
thumbnail_url = value.thumbnail_url,
thumbnail_width = value.thumbnail_width,
thumbnail_height = value.thumbnail_height,
reply_markup = functionDo.replyMarkup{
type = 'inline',
data = value.reply_markup
},
input_message_content = functionDo.getInputMessage(value.input)
}
elseif value.type == 'audio' then
  answerInlineQueryResults[newAnswerInlineQueryResults_id] = {
tdbot = 'inputInlineQueryResultAudio',
id = value.id,
title = value.title,
performer = value.performer,
audio_url = value.audio_url,
audio_duration = value.audio_duration,
reply_markup = functionDo.replyMarkup{
type = 'inline',
data = value.reply_markup
},
input_message_content = functionDo.getInputMessage(value.input)
}
elseif value.type == 'contact' then
  answerInlineQueryResults[newAnswerInlineQueryResults_id] = {
tdbot = 'inputInlineQueryResultContact',
id = value.id,
contact = value.contact,
thumbnail_url = value.thumbnail_url,
thumbnail_width = value.thumbnail_width,
thumbnail_height = thumbnail_height.description,
reply_markup = functionDo.replyMarkup{
type = 'inline',
data = value.reply_markup
},
input_message_content = functionDo.getInputMessage(value.input)
}
elseif value.type == 'document' then
  answerInlineQueryResults[newAnswerInlineQueryResults_id] = {
tdbot = 'inputInlineQueryResultDocument',
id = value.id,
title = value.title,
description = value.description,
document_url = value.document_url,
mime_type = value.mime_type,
thumbnail_url = value.thumbnail_url,
thumbnail_width = value.thumbnail_width,
thumbnail_height = value.thumbnail_height,
reply_markup = functionDo.replyMarkup{
type = 'inline',
data = value.reply_markup
},
input_message_content = functionDo.getInputMessage(value.input)
}
elseif value.type == 'game' then
  answerInlineQueryResults[newAnswerInlineQueryResults_id] = {
tdbot = 'inputInlineQueryResultGame',
id = value.id,
game_short_name = value.game_short_name,
reply_markup = functionDo.replyMarkup{
type = 'inline',
data = value.reply_markup
},
input_message_content = functionDo.getInputMessage(value.input)
}
elseif value.type == 'location' then
  answerInlineQueryResults[newAnswerInlineQueryResults_id] = {
tdbot = 'inputInlineQueryResultLocation',
id = value.id,
location = value.location,
live_period = value.live_period,
title = value.title,
thumbnail_url = value.thumbnail_url,
thumbnail_width = value.thumbnail_width,
thumbnail_height = value.thumbnail_height,
reply_markup = functionDo.replyMarkup{
type = 'inline',
data = value.reply_markup
},
input_message_content = functionDo.getInputMessage(value.input)
}
elseif value.type == 'photo' then
  answerInlineQueryResults[newAnswerInlineQueryResults_id] = {
tdbot = 'inputInlineQueryResultPhoto',
id = value.id,
title = value.title,
description = value.description,
thumbnail_url = value.thumbnail_url,
photo_url = value.photo_url,
photo_width = value.photo_width,
photo_height = value.photo_height,
reply_markup = functionDo.replyMarkup{
type = 'inline',
data = value.reply_markup
},
input_message_content = functionDo.getInputMessage(value.input)
}
elseif value.type == 'sticker' then
  answerInlineQueryResults[newAnswerInlineQueryResults_id] = {
tdbot = 'inputInlineQueryResultSticker',
id = value.id,
thumbnail_url = value.thumbnail_url,
sticker_url = value.sticker_url,
sticker_width = value.sticker_width,
sticker_height = value.sticker_height,
photo_width = value.photo_width,
photo_height = value.photo_height,
reply_markup = functionDo.replyMarkup{
type = 'inline',
data = value.reply_markup
},
input_message_content = functionDo.getInputMessage(value.input)
}
elseif value.type == 'sticker' then
  answerInlineQueryResults[newAnswerInlineQueryResults_id] = {
tdbot = 'inputInlineQueryResultSticker',
id = value.id,
thumbnail_url = value.thumbnail_url,
sticker_url = value.sticker_url,
sticker_width = value.sticker_width,
sticker_height = value.sticker_height,
photo_width = value.photo_width,
photo_height = value.photo_height,
reply_markup = functionDo.replyMarkup{
type = 'inline',
data = value.reply_markup
},
input_message_content = functionDo.getInputMessage(value.input)
}
elseif value.type == 'video' then
  answerInlineQueryResults[newAnswerInlineQueryResults_id] = {
tdbot = 'inputInlineQueryResultVideo',
id = value.id,
title = value.title,
description = value.description,
thumbnail_url = value.thumbnail_url,
video_url = value.video_url,
mime_type = value.mime_type,
video_width = value.video_width,
video_height = value.video_height,
video_duration = value.video_duration,
reply_markup = functionDo.replyMarkup{
type = 'inline',
data = value.reply_markup
},
input_message_content = functionDo.getInputMessage(value.input)
}
elseif value.type == 'videonote' then
  answerInlineQueryResults[newAnswerInlineQueryResults_id] = {
tdbot = 'inputInlineQueryResultVoiceNote',
id = value.id,
title = value.title,
voice_note_url = value.voice_note_url,
voice_note_duration = value.voice_note_duration,
reply_markup = functionDo.replyMarkup{
type = 'inline',
data = value.reply_markup
},
input_message_content = functionDo.getInputMessage(value.input)
}
end
end
end
return functionCo.run_table{
tdbot = 'answerInlineQuery',
inline_query_id = inline_query_id,
next_offset = next_offset,
switch_pm_text = switch_pm_text,
switch_pm_parameter = switch_pm_parameter,
is_personal = is_personal,
cache_time = cache_time,
results = answerInlineQueryResults,
}
end
function tdbot.VERSION()
  print('login')
return true
end
function tdbot.run(main_def, filters)
if type(main_def) ~= 'function' then
functionCo.print_error('the run main_def must be a main function !')
os.exit(1)
  else
functionUp[0] = {}
functionUp[0].def = main_def
functionUp[0].filters = filters
end
  while tdbot.get_update do
for timer_id, timer_data in pairs(functionTi) do
if os.time() >= timer_data.run_in then
  xpcall(timer_data.def, functionCo.print_error,timer_data.argv)
  table.remove(functionTi,timer_id)
end
end
local update = functionCo.change_table(client:receive(1))
if update then
if type(update) ~= 'table' then
goto finish
end
if tdbot.login(update) then
functionCo._CALL_(update)
end
end
::finish::
end
end
function tdbot.set_config(data)
tdbot.VERSION()
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
if not data.token and not functionDo.exists('.CallBack-Bot/'..data.session_name) then
io.write('Please enter Token or Phone to call')
local phone_token = io.read()
if phone_token:match('%d+:') then
tdbot.config.is_bot = true
tdbot.config.token = phone_token
else
tdbot.config.is_bot = false
tdbot.config.phone = phone_token
end
elseif data.token and not functionDo.exists('.CallBack-Bot/'..data.session_name) then
tdbot.config.is_bot = true
tdbot.config.token = data.token
end
if not functionDo.exists('.CallBack-Bot') then
os.execute('sudo mkdir .CallBack-Bot')
end
tdbot.config.encryption_key = data.encryption_key or ''
tdbot.config.parameters = {
tdbot = 'setTdlibParameters',
use_message_database = data.use_message_database or true,
api_id = data.api_id,
api_hash = data.api_hash,
use_secret_chats = use_secret_chats or true,
system_language_code = data.language_code or 'en',
device_model = 'tdbot',
system_version = data.system_version or 'linux',
application_version = '1.0',
enable_storage_optimizer = data.enable_storage_optimizer or true,
use_pfs = data.use_pfs or true,
database_directory = '.CallBack-Bot/'..data.session_name
}
return functionDo
end
function tdbot.login(state)
if state.name == 'version' and state.value and state.value.value then
elseif state.authorization_state and state.authorization_state.tdbot == 'error' and (state.authorization_state.message == 'PHONE_NUMBER_INVALID' or state.authorization_state.message == 'ACCESS_TOKEN_INVALID') then
if state.authorization_state.message == 'PHONE_NUMBER_INVALID' then
print('Phone Number invalid Error ?!')
else
print('Token Bot invalid Error ?!')
end
io.write('Please Use Token or Phone to call : ')
local phone_token = io.read()
if phone_token:match('%d+:') then
functionCo.send_tdlib{
tdbot = 'checkAuthenticationBotToken',
token = phone_token
}
else
functionCo.send_tdlib{
tdbot = 'setAuthenticationPhoneNumber',
phone_number = phone_token
}
end
elseif state.authorization_state and state.authorization_state.tdbot == 'error' and state.authorization_state.message == 'PHONE_CODE_INVALID' then
io.write('The Code : ')
local code = io.read()
functionCo.send_tdlib{
tdbot = 'checkAuthenticationCode',
code = code
}
elseif state.authorization_state and state.authorization_state.tdbot == 'error' and state.authorization_state.message == 'PASSWORD_HASH_INVALID' then
print('two-step is wrong !')
io.write('The Password : ')
local password = io.read()
functionCo.send_tdlib{
tdbot = 'checkAuthenticationPassword',
password = password
}
elseif state.tdbot == 'authorizationStateWaitTdlibParameters' or (state.authorization_state and state.authorization_state.tdbot == 'authorizationStateWaitTdlibParameters') then
functionCo.send_tdlib{
tdbot = 'setTdlibParameters',
parameters = tdbot.config.parameters
}
elseif state.authorization_state and state.authorization_state.tdbot == 'authorizationStateWaitEncryptionKey' then
functionCo.send_tdlib{
tdbot = 'checkDatabaseEncryptionKey',
encryption_key = tdbot.config.encryption_key
}
elseif state.authorization_state and state.authorization_state.tdbot == 'authorizationStateWaitPhoneNumber' then
if tdbot.config.is_bot then
functionCo.send_tdlib{
tdbot = 'checkAuthenticationBotToken',
token = tdbot.config.token
}
else
functionCo.send_tdlib{
tdbot = 'setAuthenticationPhoneNumber',
phone_number = tdbot.config.phone
}
end
elseif state.authorization_state and state.authorization_state.tdbot == 'authorizationStateWaitCode' then
io.write('The Password : ')
local code = io.read()
functionCo.send_tdlib{
tdbot = 'checkAuthenticationCode',
code = code
}
elseif state.authorization_state and state.authorization_state.tdbot == 'authorizationStateWaitPassword' then
io.write('Password [ '..state.authorization_state.password_hint..' ] : ')
local password = io.read()
functionCo.send_tdlib{
tdbot = 'checkAuthenticationPassword',
password = password
}
elseif state.authorization_state and state.authorization_state.tdbot == 'authorizationStateWaitRegistration' then
io.write('The First name : ')
local first_name = io.read()
io.write('The Last name : ')
local last_name = io.read()
functionCo.send_tdlib{
tdbot = 'registerUser',
first_name = first_name,
last_name = last_name
}
elseif state.authorization_state and state.authorization_state.tdbot == 'authorizationStateReady' then
print("The files have been connected and played ...")
elseif state.authorization_state and state.authorization_state.tdbot == 'authorizationStateClosed' then
print('- تم تسجيل الخروج .')
tdbot.get_update = false
elseif state.tdbot == 'error' and state.message then
elseif not (state.tdbot and functionDo.in_array({'updateConnectionState', 'updateSelectedBackground', 'updateConnectionState', 'updateOption',}, state.tdbot)) then
return true
end
end
return tdbot