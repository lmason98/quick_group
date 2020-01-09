export rustgroup = {}

sv = file.Find "rustgroup/server/*.lua", "LUA"
sh = file.Find "rustgroup/shared/*.lua", "LUA"
cl = file.Find "rustgroup/client/*.lua", "LUA"

-- load server files
include "config.lua"
include "server/#{fl}" for fl in *sv

-- mark shared files for download/load shared files
for fl in *sh
    AddCSLuaFile "shared/#{fl}"
    include "shared/#{fl}"

-- mark client files for download
AddCSLuaFile "cl_init.lua"
AddCSLuaFile "config.lua"
AddCSLuaFile "client/#{fl}" for fl in *cl

print " [RUSTGROUP]: Server files loaded, Client and Shared files marked for download."
