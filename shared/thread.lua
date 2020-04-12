Thread = {}
Thread.__index = Thread

function Thread.New(fnc, looped, ms)
  if type(fnc) ~= "function" then return end
  if type(looped) ~= "boolean" then looped = false end
  if type(ms) ~= "number" then ms = 0 end

  local newThread = {}
  setmetatable(newThread, Thread)

  newThread.state = "running"

  Citizen.CreateThread(function()
    if looped then
      while true do

        if newThread.state == "running" then
          fnc(nil)
        end

        if newThread.state == "dead" then
          return
        end

        Citizen.Wait(ms)
      end
    else
      local p = promise.new()
      fnc(p)
      Citizen.Await(p)
      newThread:Kill()
    end
  end)

  return newThread
end

function Thread:Pause()
  if self.state == "dead" then return end
  self.state = "paused"
end

function Thread:Resume()
  if self.state == "dead" then return end
  self.state = "running"
end

function Thread:Kill()
  if self.state == "dead" then return end
  self.state = "dead"
end

function Thread:Status()
  return self.state
end