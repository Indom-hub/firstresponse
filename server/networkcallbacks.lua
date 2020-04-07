local registered_callbacks = {}

Callbacks = {}

function Callbacks.Register(name, callback)
  if not registered_callbacks[name] then
    registered_callbacks[name] = callback
    local event = "FirstResponse:NetCallback:" .. name
    RegisterNetEvent(event)
    AddEventHandler(event, function(args)
      print("TRIGGERED: " .. event)
      local src = source
      registered_callbacks[name](args, function(data)
        TriggerClientEvent(event .. "_return", src, data)
      end)
    end)
  end
end

-- USAGE EXAMPLE
-- Citizen.CreateThread(function()
--   Callbacks.Register("Testing", function(data, send)
--     print(json.encode(data))
--     send() -- trigger the callback to send back to the client (You don't need to pass anything. Leave nil if you want)
--   end)
-- end)