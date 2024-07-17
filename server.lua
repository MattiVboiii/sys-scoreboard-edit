local QBCore = exports['qb-core']:GetCoreObject()

QBCore.Functions.CreateCallback('qb-scoreboard:server:GetScoreboardData', function(source, cb)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Player ~= nil then
        name = Player.PlayerData.charinfo.firstname .. ' ' .. Player.PlayerData.charinfo.lastname
        job = Player.PlayerData.job.label
        duty = Player.PlayerData.job.onduty
        grade = Player.PlayerData.job.grade.name
    end
    local ping = GetPlayerPing(src)
    local totalPlayers = 0
    local policeCount = 0
    local players = {}
    local info = {
        servername = GetConvar('sv_hostname'),
        ping = ping .. 'ms',
        name = name,
        ambulanceCount = 0,
        mechanicCount = 0,
        taxiCount = 0,
        job = job,
        duty = duty,
        grade = grade

    }

    for _, v in pairs(QBCore.Functions.GetQBPlayers()) do
        if v then
            totalPlayers += 1

            if v.PlayerData.job.name == 'police' and v.PlayerData.job.onduty then
                policeCount += 1
            end

            if v.PlayerData.job.name == 'ambulance' and v.PlayerData.job.onduty then
                info.ambulanceCount += 1
            end
            if v.PlayerData.job.name == 'mechanic' and v.PlayerData.job.onduty then
                info.mechanicCount += 1
            end
            if v.PlayerData.job.name == 'taxi' and v.PlayerData.job.onduty then
                info.taxiCount += 1
            end


            players[v.PlayerData.source] = {}
            players[v.PlayerData.source].optin = QBCore.Functions.IsOptin(v.PlayerData.source)
        end
    end
    cb(totalPlayers, policeCount, players, info)
end)

RegisterNetEvent('qb-scoreboard:server:SetActivityBusy', function(activity, bool)
    Config.IllegalActions[activity].busy = bool
    TriggerClientEvent('qb-scoreboard:client:SetActivityBusy', -1, activity, bool)
end)

