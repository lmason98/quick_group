local Group = {}

if SERVER then

Group.leader     = nil
Group.members     = {}
Group.member_count = 0
Group.id           = 0

--[[
    Args: Player leader
    Desc: Group constructor, sets the Group leader, adds it to the member table and increments member count.
    Return: Bool success
]]
function Qgroup.Group(leader)
    local group = table.Copy(Group)

    if not (leader and leader:IsPlayer()) then -- make sure player is valid
        _DBUG(" Qgroup.group - leader not valid or not player.") return false end

    group.leader = leader
    table.insert(group.members, leader)
    group.member_count = group.member_count + 1

    group.id = table.insert(Qgroup.group_table, group) -- insert new group to global group table
    
    
    _DBUG("Qgroup.Group - new group created =".. tostring(group))

    return group
end

--[[
    Args: Number id
    Desc: Gets the group with the specified id
    Return: Group or nil
]]
function Qgroup.GetGroup(id)
    for i, group in pairs(Qgroup.group_table) do
        if (group.id == id) then
            return group end
    end
end

--[[
    Args: Number id
    Desc: Gets the group with the specified id
    Return: Group or nil
]]
function Qgroup.RemoveGroup(id)
    for i, group in pairs(Qgroup.group_table) do
        if (group.id == id) then
            _DBUG("Qgroup RemoveGroup - removed group with id=".. id)
            table.remove(Qgroup.group_table, i) end
    end
end

--[[
    Args: Number id
    Desc: Prints the group table 
]]
function Qgroup.PrintGroups()
    for i, group in pairs(Qgroup.group_table) do
        local mem_str = ""
        for i, member in pairs(group.members) do
            mem_str = mem_str.. "[".. member:Nick() .."] " end

        print("===================================")
        print(" Leader : ".. group.leader:Nick())
        print(" Member count : ".. group.member_count)
        print(" Members : ".. mem_str)
        print(" Id : ".. group.id)
        print("===================================")
    end
end

-- ******************** Group object ******************** --

--[[
    Args: Player ply
    Desc: Adds a player to the group
    Return: Number index (at which the ply was inserted in the group member table)
]]
function Group:AddMember(ply)
    if not (ply and ply:IsPlayer()) then -- make sure player is valid
        _DBUG(" Group:AddMember - ply not valid or not player.") return false end

    i = table.insert(group.members, ply)
    group.member_count = group.member_count + 1
end

--[[
    Args: Player ply
    Desc: Kicks the player from the group, deletes the group if the last player leaves
]]
function Group:KickMember(ply)
    for i, member in pairs(self.members) do
        if (member:SteamID() == ply:SteamID()) then
            _DBUG("group kickMember - remove ply from self.members")
            table.remove(self.members, i) end
    end

    self.member_count = self.member_count - 1

    if (ply:SteamID() == self.leader:SteamID() and self.member_count > 1) then
        for i, ply in pairs(self.members) do
            _DBUG("group kickMember - ply is leader and more than 1 member, assign new leader")
            self.leader = ply break end
    elseif (ply:SteamID() ~= self.leader:SteamID() and self.members_count > 1) then
        _DBUG("group kickMember - ply is not leader and more than 1 member, do nothing")
        -- dont care about this case?
    else
        for i, group in pairs(Qgroup.group_table) do
            if (group.id == self.id) then
                _DBUG("group kickMember - ply is leader and last member, remove group")
                table.remove(Qgroup.group_table, i) break end
        end
    end
end

elseif CLIENT then

end
