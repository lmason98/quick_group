Qgroup = Qgroup or {}
Qgroup.debug = true

function _DBUG(text)
    if Qgroup.debug then
        print(" [+] DEBUG : [" .. text .. "]") end
end

local sv_prfx = "qgroup/server/"
local sh_prfx = "qgroup/"
local cl_prfx = "qgroup/client/"
local vgui_prfx = "qgroup/client/vgui/"

local sv = file.Find(sv_prfx .."*.lua", "LUA")
local sh = file.Find(sh_prfx .."*.lua", "LUA")
local cl = file.Find(cl_prfx .."*.lua", "LUA")
local vgui = file.Find(vgui_prfx .."*.lua", "LUA")
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
    for i, fl in pairs(cl) do -- Send client files to client for download
        _DBUG("sv sending to cl to download=" .. cl_prfx .. fl)
        AddCSLuaFile(cl_prfx .. fl) end
    for i, fl in pairs(vgui) do -- Send vgui files to client for download
        _DBUG("sv sending vgui to cl to download=" .. vgui_prfx .. fl)
        AddCSLuaFile(vgui_prfx .. fl) end
elseif CLIENT then
    include(cfg)
    _DBUG("cl included cfg")

    for i, fl in pairs(sh) do -- Include shared side files
        _DBUG("cl including sh=" .. sh_prfx .. fl)
        if (fl ~= "init.lua") then
            include(sh_prfx .. fl) end
    end
    for i, fl in pairs(cl) do -- Include client files
        _DBUG("cl including=" .. cl_prfx .. fl)
        include(cl_prfx .. fl) end
    for i, fl in pairs(vgui) do -- Include vgui files
        _DBUG("cl including vgui=" .. vgui_prfx .. fl)
        include(vgui_prfx .. fl) end
end
