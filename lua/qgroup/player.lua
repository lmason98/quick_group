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
    return self:GetNWBool("qgroup_isleader", false) end

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
    return self:GetNWBool("qgroup_id", -1) end

if SERVER then

--[[
    Desc: Creates a new group object and inserts to global group_table.
    Return: Group object
]]
function PLAYER:CreateQGroup()
    if (self:GetQGroupID() == -1) then
        _DBUG("PLAYER:CreateQGroup - self=".. tostring(self))
        local Group = Qgroup.Group(self) -- pass self as the group leader
        _DBUG("PLAYER:CreateQGroup - Group=".. tostring(Group))
        self:SetQGroupLeader(true)
        self:SetQGroupID(Group.id)
    else
        self:ChatPrint("You're already in a group!")
    end

    return Group
end

--[[
    Desc: Has player leave the group
    Return: Bool success
]]
function PLAYER:LeaveQGroup()
    if (self:GetQGroupID() ~= -1) then
        local Group = Qgroup.GetGroup(self:GetQGroupID())
        Group:KickMember(self) 
        self:SetQGroupID(-1)
        self:SetQGroupLeader(false)
    else
        self:ChatPrint("You're not in a group!")
    end
end

elseif CLIENT then

end
