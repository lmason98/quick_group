local dbg = EASYGROUP.dbug
local PLAYER = FindMetaTable("Player")

--[[
    Realm: Shared
    Desc: Server - Creates a new group object and inserts to global group_table.
          Client - 
    Return: Server - Group object | Client - 
]]
function PLAYER:CreateGroup()
    if SERVER then
        local Group = EASYGROUP.Group(self)
        table.insert(EASYGROUP.group_table, Group) -- insert new group to global group table
        dbg(" PLAYER:CreateGroup - inserted new group to group_table count(group_table)=" + #EASYGROUP.group_table)
    elseif CLIENT then
    end
end

--[[
    Realm: Shared
]]
function PLAYER:JoinGroup()
end
