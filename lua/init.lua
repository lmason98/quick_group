EASYGROUP = EASYGROUP or {}
EASYGROUP.debug = true

function _DBUG(text)
    if EASYGROUP.debug then
        print(" [+] DEBUG : [" .. text .. "]") end
end

local sv_prfx = "rustgroup/server/"
local sh_prfx = "rustgroup/"
local cl_prfx = "rustgroup/client/"

local sv = file.Find("rustgroup/server/*.lua", "LUA")
local sh = file.Find("rustgroup/*.lua", "LUA")
local cl = file.Find("rustgroup/client/*.lua", "LUA")
local cfg = "cfg.lua"

if SERVER then
    include(cfg)
    AddCSLuaFile(cfg)
    _DBUG("sv included and sent to cl to download - cfg")

    for i, fl in pairs(sh) do -- Include shared files
        _DBUG("sv including sh and sending to cl to download=" .. sh_prfx .. fl)
        if (fl ~= "init.lua") then
            include(sh_prfx .. fl)
            AddCSLuaFile(sh_prfx .. fl)
        end
    end
    for i, fl in pairs(sv) do -- Include server side files
        _DBUG("sv including=" .. sv_prfx .. fl)
        include(sv_prfx .. fl) end
    for i, fl in pairs(cl) do -- Include shared files
        _DBUG("sv sending to cl to download=" .. cl_prfx .. fl)
        AddCSLuaFile(cl_prfx .. fl) end
elseif CLIENT then
    include(cfg)
    _DBUG("cl included cfg")

    for i, fl in pairs(sh) do -- Include server side files
        _DBUG("cl including sh=" .. sh_prfx .. fl)
        if (fl ~= "init.lua") then
            include(sh_prfx .. fl) end
    end
    for i, fl in pairs(cl) do -- Include shared files
        _DBUG("cl including=" .. cl_prfx .. fl)
        include(cl_prfx .. fl) end
end
