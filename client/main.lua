--[[ ===================================================== ]] --
--[[           MH Exhaust Flames Script by MaDHouSe        ]] --
--[[ ===================================================== ]] --
local isLoggedIn = false
local exhaustFlames = {}

local function GetDistance(pos1, pos2)
    if pos1 ~= nil and pos2 ~= nil then
        return #(vector3(pos1.x, pos1.y, pos1.z) - vector3(pos2.x, pos2.y, pos2.z))
    else
        print("The function GetDistance() : Can't find a coords to check a distance")
    end
end

--- Round
---@param value number
---@param numDecimalPlaces number
local function Round(value, numDecimalPlaces)
    if not numDecimalPlaces then return math.floor(value + 0.5) end
    local power = 10 ^ numDecimalPlaces
    return math.floor((value * power) + 0.5) / (power)
end

--- LoadFXAssets
---@param asset string
local function LoadFXAssets(asset)
    RequestNamedPtfxAsset(asset)
    while not HasNamedPtfxAssetLoaded(asset) do
        Wait(0)
    end
end

--- UseFxNextCall
---@param asset string
local function UseFxNextCall(asset)
    SetPtfxAssetNextCall(asset)
    UseParticleFxAssetNextCall(asset)
end

--- Check If Vehicle Is Stock
---@param vehicle number
local function IsVehicleStock(vehicle)
    if GetNumVehicleMods(vehicle, 11) ~= 0 then -- If engine can be changed
        if (GetVehicleMod(vehicle, 11) == -1 or GetVehicleMod(vehicle, 11) < Config.MinModkit) and
            Config.IgnoreVehicles[GetVehicleClass(vehicle)] then -- If Stock
            return true
        end
    end
    return false
end

AddEventHandler('playerSpawned', function()
    isLoggedIn = true
    print("[^2" .. GetCurrentResourceName() .. "^7] Created By ^2MaDHouSe^7 (^2https://github.com/MaDHouSe79/^7)")
end)

AddEventHandler('onResourceStop', function(resource)
    if resource == GetCurrentResourceName() then
        isLoggedIn = false
    end
end)

AddEventHandler('onResourceStart', function(resourceName)
    if resourceName == GetCurrentResourceName() then
        isLoggedIn = true
        print("[^2" .. GetCurrentResourceName() .. "^7] Created By ^2MaDHouSe^7 (^2https://github.com/MaDHouSe79/^7)")
    end
end)

CreateThread(function()
    while true do
        local sleep = 1000
        if isLoggedIn then
            local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
            if vehicle ~= 0 and vehicle ~= nil and DoesEntityExist(vehicle) then
                if (GetPedInVehicleSeat(vehicle, -1) == PlayerPedId()) then
                    if GetIsVehicleEngineRunning(vehicle) == 1 and not IsVehicleStock(vehicle) then
                        sleep = 70
                        local vehicle_netid = NetworkGetNetworkIdFromEntity(vehicle)
                        local currentrpm = Round(GetVehicleCurrentRpm(vehicle), 2)
                        local driftMode = false
                        if GetVehicleHandlingFloat(vehicle, "CHandlingData", "fInitialDragCoeff") > 90 then driftMode = true end
                        if not driftMode then
                            if currentrpm > Config.RPM.min and currentrpm < Config.RPM.max then
                                TriggerServerEvent('mh-exhaustflames:server:SyncFlames', {handle = "on", netid = vehicle_netid})
                            else
                                TriggerServerEvent('mh-exhaustflames:server:SyncFlames', {handle = "off", netid = vehicle_netid})
                            end
                        else
                            if currentrpm > Config.RPM.min then
                                TriggerServerEvent('mh-exhaustflames:server:SyncFlames', {handle = "on", netid = vehicle_netid})
                            else
                                TriggerServerEvent('mh-exhaustflames:server:SyncFlames', {handle = "off", netid = vehicle_netid})
                            end
                        end
                    end
                end
            end
        end
        Wait(sleep)
    end
end)

-- Sync Lift Animation
Citizen.CreateThread(function()
    while true do
        local sleep = 100
        if isLoggedIn then
            local Pcoords = GetEntityCoords(PlayerPedId())
            for k, vehicle in pairs(GetGamePool('CVehicle')) do
                if DoesEntityExist(vehicle) then
                    if GetIsVehicleEngineRunning(vehicle) == 1 and not IsVehicleStock(vehicle) then
                        if Entity(vehicle).state and Entity(vehicle).state.flames then
                            local Vcoords = GetEntityCoords(vehicle)
                            local distance = GetDistance(Vcoords, Pcoords)
                            if distance < 100 then
                                sleep = 70
                                LoadFXAssets("veh_xs_vehicle_mods")
                                for _, bone in pairs(Config.exhaust_location) do
                                    if GetEntityBoneIndexByName(vehicle, bone) ~= -1 then
                                        if exhaustFlames[bone] == nil then
                                            exhaustFlames[bone] = {}
                                            UseFxNextCall("veh_xs_vehicle_mods")
                                            exhaustFlames[bone] = StartParticleFxLoopedOnEntityBone("veh_nitrous", vehicle, 0.0, -0.02, 0.0, 0.0, 0.0, 0.0, GetEntityBoneIndexByName(vehicle, bone), Config.ParticleSize, 0.0, 0.0, 0.0)
                                        end
                                    end
                                end
                                Wait(500)
                                for index, _ in pairs(exhaustFlames) do
                                    StopParticleFxLooped(exhaustFlames[index], 1)
                                    exhaustFlames[index] = nil
                                end
                            end
                        end
                    end
                end
            end
        end
        Wait(sleep)
    end
end)
