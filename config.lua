Config = Config or {}

-- Open scoreboard key
Config.OpenKey = 'HOME' -- https://docs.fivem.net/docs/game-references/input-mapper-parameter-ids/keyboard/

Config.Toggle = true -- If this is false the scoreboard stays open only when you hold the OpenKey button, if this is true the scoreboard will be openned and closed with the OpenKey button

-- Max Server Players
Config.MaxPlayers = GetConvarInt('sv_maxclients', 2) -- It returns 48 if it cant find the Convar Int

-- Minimum Police for Actions
Config.IllegalActions = {
    ['storerobbery'] = {minimumPolice = 2, busy = false, label = 'Store Robbery 💵'},
    ['bankrobbery'] = {minimumPolice = 3, busy = false, label = 'Fleeca Bank 💰'},
    ['jewellery'] = {minimumPolice = 2, busy = false, label = 'Jewellery 💎'},
    ['pacific'] = {minimumPolice = 5, busy = false, label = 'Pacific Bank 💰'},
    ['paleto'] = {minimumPolice = 4, busy = false, label = 'Paleto Bay Bank 💰'},
    ['houserobbery'] = {minimumPolice = 2, busy = false, label = 'House Robbery 🏠'},
    ['yacht'] = {minimumPolice = 5, busy = false, label = 'Yacht Heist 🚢'}
}

-- Show ID's for all players or Opted in Staff  Hurts Performance
Config.ShowIDforALL = false
