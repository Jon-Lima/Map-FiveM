local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
vRP = Proxy.getInterface("vRP")

RegisterServerEvent("vrp_bank:doQuickDeposit")
AddEventHandler("vrp_bank:doQuickDeposit", function(amount)
    local src = source
    local user_id = vRP.getUserId(src)
    local curBank = vRP.getMoney(user_id)
    while user_id == nil do Wait(0) end
    if tonumber(amount) <= curBank then
        vRP.tryDeposit(user_id, tonumber(amount))
        TriggerClientEvent("vrp_bank:refreshBank", src)
		TriggerClientEvent("Notify",src,"sucesso","Você depositou R$".. amount ..".")
    else 
		TriggerClientEvent("Notify",src,"negado","Você não possui R$".. amount ..".")
    end
end)

RegisterServerEvent("vrp_bank:doQuickWithdraw")
AddEventHandler("vrp_bank:doQuickWithdraw", function(amount)
    local src = source
    local user_id = vRP.getUserId(src)
    local curBank = vRP.getBankMoney(user_id)
    while user_id == nil do Wait(0) end
    if tonumber(amount) <= curBank then
		vRP.tryWithdraw(user_id,tonumber(amount))
        TriggerClientEvent("vrp_bank:refreshBank", src)
		TriggerClientEvent("Notify",src,"sucesso","Você sacou R$".. amount ..".")
    else
		TriggerClientEvent("Notify",src,"negado","Você não possui R$".. amount ..".")
    end
end)

RegisterServerEvent("vrp_bank:doQuickWithdrawATM")
AddEventHandler("vrp_bank:doQuickWithdrawATM", function(amount)
    local src = source
    local user_id = vRP.getUserId(src)
    local curBank = vRP.getBankMoney(user_id)
    while user_id == nil do Wait(0) end
    if tonumber(amount) <= curBank then
        vRP.tryWithdraw(user_id, tonumber(amount))
        TriggerClientEvent("vrp_bank:refreshAtm", src)
        TriggerClientEvent("Notify",src,"sucesso","Você sacou R$".. amount ..".")
    else
        TriggerClientEvent("Notify",src,"negado","Você não possui R$".. amount ..".")
    end
end)

RegisterServerEvent("vrp_bank:checkWallet")
AddEventHandler("vrp_bank:checkWallet", function()
    local src = source
    local user_id = vRP.getUserId(src)
	local identity = vRP.getUserIdentity(user_id)
    local bank = vRP.getBankMoney(user_id)
    local cash = vRP.getMoney(user_id)
    TriggerClientEvent("checkWallet", src, bank, cash, identity.name.." "..identity.firstname)
end)