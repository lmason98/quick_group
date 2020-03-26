if SERVER then
    AddCSLuaFile("init.lua")
    include("init.lua")
elseif CLIENT then
    include("init.lua")
end
