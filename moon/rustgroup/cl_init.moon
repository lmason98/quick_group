export rustgroup = {}

sh = file.Find "neatf4/shared/*.lua", "LUA"
cl = file.Find "neatf4/client/*.lua", "LUA"

-- load shared files
include "shared/" .. fl for i, fl in pairs sh

-- load client files
include "config.lua"
include "client/" .. fl for i, fl in pairs cl

print " [RUSTGROUP]: Client and Shared files loaded."
