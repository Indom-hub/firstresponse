Job = {}
Job.__index = Job

function Job.New(data)
  local newJob = {}
  setmetatable(newJob, Job)

  newJob.data = data

  return newJob
end

function Job:Start(callback)
  callback()
end

function Job:Stop(callback)
  callback()
end