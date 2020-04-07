Citizen.CreateThread(function()
  InsertDatabaseTables()
  InsertDatabaseData()
end)

-- CREATE DATABASE TABLES
function InsertDatabaseTables()
  local p = promise.new()
  local resource = GetCurrentResourceName()
  local dir = GetResourcePath(resource) .. "/sql/"
  local files = Directory.Scan(dir)

  for a = 1, #files do
    local fileData = File.Load(dir, files[a])
    exports.externalsql:AsyncQuery({ query = fileData })
  end

  p:resolve()
end

-- INSERT DEFAULT DATABASE DATA
function InsertDatabaseData()
  local p = promise.new()

  -- INSERT JOBS IF THEY DONT EXIST
  -- INSERT JOB ROLES IF THEY DONT EXIST
  -- INSERT JOB CERTS IF THEY DONT EXIST
  local cfg = Configs.Get("jobs"):GetAll()
  for k1, v1 in pairs(cfg) do
    
    local jobResult = exports.externalsql:AsyncQuery({
      query = [[ INSERT INTO `jobs` (`key`, `name`) VALUES (:key, :name) ]],
      data = {
        key = k1,
        name = v1.label
      }
    })

    if jobResult.status then
      for k2, v2 in pairs(v1.roles) do
        exports.externalsql:AsyncQuery({
          query = [[ INSERT INTO `job_roles` (`key`, `label`, `perm`, `job_id`) VALUES (:key, :label, :perm, :job_id)  ]],
          data = {
            key = k2,
            label = v2.label,
            perm = v2.perm,
            job_id = jobResult.data.insertId
          }
        })
      end
  
      for k3, v3 in pairs(v1.certs) do
        exports.externalsql:AsyncQuery({
          query = [[ INSERT INTO `job_certs` (`key`, `label`, `job_id`) VALUES (:key, :label, :job_id)  ]],
          data = {
            key = k3,
            label = v3.label,
            job_id = jobResult.data.insertId
          }
        })
      end
    end
    
  end

  p:resolve()
end