local registered_callbacks = {}

Callbacks = {}

function Callbacks.Trigger(name, callback, args)
  local send_event = "FirstResponse:NetCallback:" .. name
  local return_event = "FirstResponse:NetCallback:" .. name .. "_return"
  if not registered_callbacks[return_event] then
    registered_callbacks[return_event] = callback
    RegisterNetEvent(return_event)
    AddEventHandler(return_event, function(data)
      local cb = registered_callbacks[return_event]
      cb(data)
    end)
  end
  TriggerServerEvent(send_event, args)
end

-- USAGE EXAMPLE
-- Citizen.CreateThreadNow(function()
--   Citizen.Wait(1000)
--   Callbacks.Trigger("Testing", function(data)
--     print("CALLBACK TRIGGERED!")
--   end)
-- end)