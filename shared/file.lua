File = {}

function File.Load(directory, file)
  local f = io.open(directory .. file, "r")
  local fData = f:read("*a")
  f:close()
  return fData or nil
end