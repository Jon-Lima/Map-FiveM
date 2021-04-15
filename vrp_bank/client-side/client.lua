local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")

RegisterNetEvent("vrp_bank:checkATM")
AddEventHandler("vrp_bank:checkATM", function()
    if PlayerNearATM() then
        Atm = true
        TaskStartScenarioInPlace(PlayerPedId(), "PROP_HUMAN_ATM", 0, true)
        SendNUIMessage({['action'] = "showATM"})
        TriggerServerEvent("vrp_bank:checkWallet")
        SetNuiFocus(true, true)
  --  else
   --     TriggerEvent("Notify", "negado", "Você precisa estar próximo de um Caixa Eletrônico.")
    end
end)

--[[CreateThread(function()
    for k,v in pairs(Config.Banks) do
        v.blip = AddBlipForCoord(v.Location, v.Location, v.Location)
        SetBlipSprite(v.blip, v.id)
        SetBlipAsShortRange(v.blip, true)
        BeginTextCommandSetBlipName("STRING")
        EndTextCommandSetBlipName(v.blip)
    end
end)]]

CreateThread(function()
    while true do
        local wait = 400
            local plyPed = PlayerPedId()
            local pos = GetEntityCoords(plyPed)

            for k,v in pairs(Config.Banks) do
                if (#(v.Location - pos) < 1) then
				wait = 1
                    drawTxt(v.Location.x, v.Location.y, v.Location.z, "[E] Usar Banco")
                    if IsControlJustPressed(0, 38) then
                        SendNUIMessage({['action'] = "show"})
                        TriggerServerEvent("vrp_bank:checkWallet")
                        print(json.encode(LocalPlayer))
                        SetNuiFocus(true, true)
                    end
                elseif (#(v.Location - pos) < 4.5) then
				wait = 1
                 drawTxt(v.Location.x, v.Location.y, v.Location.z, "Usar Banco")
            end
        end
		Citizen.Wait(wait)
    end
end)

RegisterKeyMapping("atm","Abrir Caixa Eletrônico","keyboard","e")

RegisterNetEvent("checkWallet")
AddEventHandler("checkWallet", function(bank, cash, identidade)
--   local id = PlayerId()
--   local Name = GetPlayerName(id)
	Name = identidade
    SendNUIMessage({["action"] = "checkWallet", ["bank"] = bank, ["cash"] = cash, ["player"] = Name}) 
end)

RegisterNetEvent("vrp_bank:refreshBank")
AddEventHandler("vrp_bank:refreshBank", function()
    OpenBankAccount()
end)

RegisterNetEvent("vrp_bank:refreshAtm")
AddEventHandler("vrp_bank:refreshAtm", function()
    OpenAtmAccount()
end)

RegisterNUICallback("doDeposit", function(data)
    if tonumber(data.amount) ~= nil and tonumber(data.amount) > 0 then
        TriggerServerEvent("vrp_bank:doQuickDeposit", data.amount)
        OpenBankAccount()
    end
end)

RegisterNUICallback("doWithdraw", function(data)
    if tonumber(data.amount) ~= nil and tonumber(data.amount) > 0 then
        TriggerServerEvent("vrp_bank:doQuickWithdraw", data.amount)
        OpenBankAccount()
    end
end)

RegisterNUICallback("doWithdrawATM", function(data)
    if tonumber(data.amount) ~= nil and tonumber(data.amount) > 0 then
        TriggerServerEvent("vrp_bank:doQuickWithdrawATM", data.amount)
        OpenAtmAccount()
    end
end)

RegisterNUICallback("closeNUI", function()
    NuiCloser()
end)

RegisterCommand("hidenui", function()
    NuiCloser()
end)

RegisterCommand("atm", function()
    TriggerEvent("vrp_bank:checkATM")
end)

-- functions
function drawTxt(x, y, z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 370
    DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 41, 11, 41, 68)
end

function OpenBankAccount()
    SetNuiFocus(true, true)
    SendNUIMessage({['action'] = "show"})
    SendNUIMessage({['action'] = "update", ["data"] = LocalPlayer})
    TriggerServerEvent("vrp_bank:checkWallet")
end

function OpenAtmAccount()
    SetNuiFocus(true, true)
    SendNUIMessage({['action'] = "showATM"})
    SendNUIMessage({['action'] = "update", ["data"] = LocalPlayer})
    TriggerServerEvent("vrp_bank:checkWallet")
end

function NuiCloser()
    SetNuiFocus(false, false)
    ClearPedTasks(PlayerPedId())
end

function PlayerNearATM()
    for i = 1, #Config.Atms do
        local obj = GetClosestObjectOfType(GetEntityCoords(PlayerPedId()), 0.75, Config.Atms[i], 0, 0, 0)
        if DoesEntityExist(obj) then
            TaskTurnPedToFaceEntity(PlayerPedId(), obj, 3.0)
            return true
        end
    end
    return false
end
