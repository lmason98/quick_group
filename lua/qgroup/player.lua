local PLAYER = FindMetaTable("Player")

--[[
    Realm: Shared
    Args: Bool isLeader
    Desc: Server - Sets if the player is group leader (client cannot set)
          Client - Gets if the player is group leader (server can call get as well)
    Return: Bool isLeader
]]
function PLAYER:SetQGroupLeader(bool)
    self:SetNWBool("qgroup_isleader", bool) end
function PLAYER:GetQGroupLeader()
    self:GetNWBool("qgroup_isleader", false) end

--[[
    Realm: Shared
    Args: Number group_id
    Desc: Server - Sets the player's group id (client cannot set)
          Client - Gets the player's group id (server can call get as well)
    Return: Number group_id
]]
function PLAYER:SetQGroupID(group_id)
    self:SetNWBool("qgroup_id", group_id) end
function PLAYER:GetQGroupID()
    self:GetNWBool("qgroup_id", -1) end

if SERVER then

--[[
    Realm: Server
    Desc: Server - Creates a new group object and inserts to global group_table.
    Return: Server - Group object
]]
function PLAYER:CreateQGroup()
    _DBUG("PLAYER:CreateQGroup - self=".. tostring(self))
    local Group = Qgroup.Group(self) -- pass self as the group leader
    _DBUG("PLAYER:CreateQGroup - Group=".. tostring(Group))
    self:SetQGroupLeader(true)
    self:SetQGroupID(Group.id)

    return Group
end

elseif CLIENT then

end
