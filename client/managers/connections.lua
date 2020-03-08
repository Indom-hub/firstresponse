AddEventHandler("onClientResourceStart", function(resource)
  if resource == GetCurrentResourceName() then
    TriggerServerEvent("FirstResponse:PlayerJoined")
  end
end)