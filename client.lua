-- local QBCore = exports['qb-core']:GetCoreObject()
-- local scoreboardOpen = false
-- local playerOptin = {}
-- -- Functions
-- local function DrawText3D(x, y, z, text)
--     SetTextScale(0.35, 0.35)
--     SetTextFont(4)
--     SetTextProportional(1)
--     SetTextColour(255, 255, 255, 215)
--     BeginTextCommandDisplayText('STRING')
--     SetTextCentre(true)
--     AddTextComponentSubstringPlayerName(text)
--     SetDrawOrigin(x, y, z, 0)
--     EndTextCommandDisplayText(0.0, 0.0)
--     local factor = (string.len(text)) / 370
--     DrawRect(0.0, 0.0 + 0.0125, 0.017 + factor, 0.03, 0, 0, 0, 75)
--     ClearDrawOrigin()
-- end
-- local function GetPlayers()
--     local players = {}
--     local activePlayers = GetActivePlayers()
--     for i = 1, #activePlayers do
--         local player = activePlayers[i]
--         local ped = GetPlayerPed(player)
--         if DoesEntityExist(ped) then players[#players + 1] = player end
--     end
--     return players
-- end
-- local function GetPlayersFromCoords(coords, distance)
--     local players = GetPlayers()
--     local closePlayers = {}
--     coords = coords or GetEntityCoords(PlayerPedId())
--     distance = distance or 5.0
--     for i = 1, #players do
--         local player = players[i]
--         local target = GetPlayerPed(player)
--         local targetCoords = GetEntityCoords(target)
--         local targetdistance = #(targetCoords -
--                                    vector3(coords.x, coords.y, coords.z))
--         if targetdistance <= distance then
--             closePlayers[#closePlayers + 1] = player
--         end
--     end
--     return closePlayers
-- end
-- -- Events
-- RegisterNetEvent('qb-scoreboard:client:SetActivityBusy',
--                  function(activity, busy)
--     Config.IllegalActions[activity].busy = busy
-- end)
-- -- Threads
-- CreateThread(function()
--     Wait(1000)
--     local actions = {}
--     for k, v in pairs(Config.IllegalActions) do actions[k] = v.label end
--     SendNUIMessage({action = 'setup', items = actions})
-- end)
-- CreateThread(function()
--     while true do
--         local loop = 100
--         QBCore.Functions.TriggerCallback(
--             'qb-scoreboard:server:GetScoreboardData',
--             function(players, cops, playerList, info)
--                 playerOptin = playerList
--                 local packetLossValue = NetworkGetAveragePacketLossForPlayer(
--                                             playerId) * 100
--                 SendNUIMessage({
--                     action = 'open',
--                     players = players,
--                     maxPlayers = Config.MaxPlayers,
--                     requiredCops = Config.IllegalActions,
--                     currentCops = cops,
--                     ambulanceCount = info.ambulanceCount,
--                     mechanicCount = info.mechanicCount,
--                     taxiCount = info.taxiCount,
--                     servername = info.servername,
--                     ping = info.ping,
--                     name = info.name,
--                     job = info.job,
--                     grade = info.grade,
--                     duty = info.duty,
--                     id = GetPlayerServerId(PlayerId()),
--                     packetLoss = packetLossValue .. '%'
--                 })
--                 scoreboardOpen = true
--             end)
--         if scoreboardOpen then
--             for _, player in pairs(GetPlayersFromCoords(GetEntityCoords(
--                                                             PlayerPedId()), 10.0)) do
--                 local playerId = GetPlayerServerId(player)
--                 local playerPed = GetPlayerPed(player)
--                 local playerCoords = GetEntityCoords(playerPed)
--                 if Config.ShowIDforALL or playerOptin[playerId].optin then
--                     loop = 0
--                     DrawText3D(playerCoords.x, playerCoords.y,
--                                playerCoords.z + 1.0, '[' .. playerId .. ']')
--                 end
--             end
--         end
--         Wait(loop)
--     end
-- end)
------------------- UNDER IS THE TOGGLE REAL ONE DONT REMOVE! -------------------
local QBCore = exports['qb-core']:GetCoreObject()
local scoreboardOpen = false
local playerOptin = {}

-- Functions

local function DrawText3D(x, y, z, text)
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    BeginTextCommandDisplayText('STRING')
    SetTextCentre(true)
    AddTextComponentSubstringPlayerName(text)
    SetDrawOrigin(x, y, z, 0)
    EndTextCommandDisplayText(0.0, 0.0)
    local factor = (string.len(text)) / 370
    DrawRect(0.0, 0.0 + 0.0125, 0.017 + factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end

local function GetPlayers()
    local players = {}
    local activePlayers = GetActivePlayers()
    for i = 1, #activePlayers do
        local player = activePlayers[i]
        local ped = GetPlayerPed(player)
        if DoesEntityExist(ped) then players[#players + 1] = player end
    end
    return players
end

local function GetPlayersFromCoords(coords, distance)
    local players = GetPlayers()
    local closePlayers = {}

    coords = coords or GetEntityCoords(PlayerPedId())
    distance = distance or 5.0

    for i = 1, #players do
        local player = players[i]
        local target = GetPlayerPed(player)
        local targetCoords = GetEntityCoords(target)
        local targetdistance = #(targetCoords -
                                   vector3(coords.x, coords.y, coords.z))
        if targetdistance <= distance then
            closePlayers[#closePlayers + 1] = player
        end
    end

    return closePlayers
end

-- Events

RegisterNetEvent('qb-scoreboard:client:SetActivityBusy',
                 function(activity, busy)
    Config.IllegalActions[activity].busy = busy
end)

-- Command

if Config.Toggle then
    RegisterCommand('scoreboard', function()
        if not scoreboardOpen then
            QBCore.Functions.TriggerCallback(
                'qb-scoreboard:server:GetScoreboardData',
                function(players, cops, playerList, info)
                    playerOptin = playerList
                    local packetLossValue =
                        NetworkGetAveragePacketLossForPlayer(playerId) * 100
                    SendNUIMessage({
                        action = 'open',
                        players = players,
                        maxPlayers = Config.MaxPlayers,
                        requiredCops = Config.IllegalActions,
                        currentCops = cops,
                        ambulanceCount = info.ambulanceCount,
                        mechanicCount = info.mechanicCount,
                        taxiCount = info.taxiCount,
                        realestateCount = info.realestateCount,
                        lawyerCount = info.lawyerCount,
                        servername = info.servername,
                        ping = info.ping,
                        name = info.name,
                        job = info.job,
                        grade = info.grade,
                        duty = info.duty,
                        id = GetPlayerServerId(PlayerId()),
                        packetLoss = packetLossValue .. '%'
                    })
                    scoreboardOpen = true
                end)
        else
            SendNUIMessage({action = 'close'})

            scoreboardOpen = false
        end
    end, false)

    RegisterKeyMapping('scoreboard', 'Open Scoreboard', 'keyboard',
                       Config.OpenKey)
else
    RegisterCommand('+scoreboard', function()
        if scoreboardOpen then return end
        QBCore.Functions.TriggerCallback(
            'qb-scoreboard:server:GetScoreboardData',
            function(players, cops, playerList, info)
                playerOptin = playerList
                local packetLossValue = NetworkGetAveragePacketLossForPlayer(
                                            playerId) * 100
                SendNUIMessage({
                    action = 'open',
                    players = players,
                    maxPlayers = Config.MaxPlayers,
                    requiredCops = Config.IllegalActions,
                    currentCops = cops,
                    ambulanceCount = info.ambulanceCount,
                    mechanicCount = info.mechanicCount,
                    taxiCount = info.taxiCount,
                    realestateCount = info.realestateCount,
                    lawyerCount = info.lawyerCount,
                    servername = info.servername,
                    ping = info.ping,
                    name = info.name,
                    job = info.job,
                    grade = info.grade,
                    duty = info.duty,
                    id = GetPlayerServerId(PlayerId()),
                    packetLoss = packetLossValue .. '%'
                })
                scoreboardOpen = true
            end)
    end, false)

    RegisterCommand('-scoreboard', function()
        if not scoreboardOpen then return end
        SendNUIMessage({action = 'close'})

        scoreboardOpen = false
    end, false)

    RegisterKeyMapping('+scoreboard', 'Open Scoreboard', 'keyboard',
                       Config.OpenKey)
end

-- Threads

CreateThread(function()
    Wait(1000)
    local actions = {}
    for k, v in pairs(Config.IllegalActions) do actions[k] = v.label end
    SendNUIMessage({action = 'setup', items = actions})
end)

CreateThread(function()
    while true do
        local loop = 1500
        if scoreboardOpen then
            QBCore.Functions.TriggerCallback(
                'qb-scoreboard:server:GetScoreboardData',
                function(players, cops, playerList, info)
                    playerOptin = playerList
                    local packetLossValue =
                        NetworkGetAveragePacketLossForPlayer(playerId) * 100
                    SendNUIMessage({
                        action = 'open',
                        players = players,
                        maxPlayers = Config.MaxPlayers,
                        requiredCops = Config.IllegalActions,
                        currentCops = cops,
                        ambulanceCount = info.ambulanceCount,
                        mechanicCount = info.mechanicCount,
                        taxiCount = info.taxiCount,
                        realestateCount = info.realestateCount,
                        lawyerCount = info.lawyerCount,
                        servername = info.servername,
                        ping = info.ping,
                        name = info.name,
                        job = info.job,
                        grade = info.grade,
                        duty = info.duty,
                        id = GetPlayerServerId(PlayerId()),
                        packetLoss = packetLossValue .. '%'
                    })
                    scoreboardOpen = true
                end)
        end
        Wait(loop)
    end
end)

CreateThread(function()
    while true do
        local loop = 100
        if scoreboardOpen then
            for _, player in pairs(GetPlayersFromCoords(GetEntityCoords(
                                                            PlayerPedId()), 10.0)) do
                local playerId = GetPlayerServerId(player)
                local playerPed = GetPlayerPed(player)
                local playerCoords = GetEntityCoords(playerPed)
                if Config.ShowIDforALL or playerOptin[playerId].optin then
                    loop = 0
                    DrawText3D(playerCoords.x, playerCoords.y,
                               playerCoords.z + 1.0, '[' .. playerId .. ']')
                end
            end
        end
        Wait(loop)
    end
end)
