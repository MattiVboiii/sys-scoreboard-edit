fx_version 'cerulean'
game 'gta5'
lua54 'yes'
author 'Yacoub'
description 'Enables players to view a menu that displays information about the server and other players'
version '1.0.0'

shared_script 'config.lua'
client_script 'client.lua'
server_script 'server.lua'

ui_page 'html/ui.html'

files {'html/*'}
escrow_ignore {'config.lua', 'client.lua', 'server.lua', }

dependency '/assetpacks'