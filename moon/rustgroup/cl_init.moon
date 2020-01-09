export rustgroup = {}

sh = file.Find "rustgroup/shared/*.lua", "LUA"
cl = file.Find "rustgroup/client/*.lua", "LUA"

-- load shared files
include "shared/#{fl}" for fl in *sh

-- load client files
include "config.lua"
include "client/#{fl}" for fl in *cl

print " [RUSTGROUP]: Client and Shared files loaded."
