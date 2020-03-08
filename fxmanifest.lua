--[[ SCRIPTED BY: Xander1998 ]]--

fx_version "adamant"

game "gta5"

dependencies {
  "externalsql"
}

shared_scripts {
  "./shared/*.lua",
  "./shared/enums/*.lua",
  "./shared/models/*.lua",
  "./shared/globals/*.lua",
  "./shared/configs/*.lua",
  "./shared/locales/*.lua"
}

server_scripts {
  --[[ Needed Files ]]--
  "./server/enums/*.lua",
  "./server/globals/*.lua",
  "./server/models/*.lua",
  "./server/locales/*.lua",
  "./server/configs/*.lua",

  --[[ Base Files ]]--
  "./server/*.lua",
  "./server/managers/*.lua"
}

client_scripts {
  --[[ Needed Files ]]--
  "./client/enums/*.lua",
  "./client/globals/*.lua",
  "./client/models/*.lua",
  "./client/locales/*.lua",
  "./client/configs/*.lua",

  --[[ Base Files ]]--
  "./client/*.lua",
  "./client/managers/*.lua"
}