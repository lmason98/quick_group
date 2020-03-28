local Group = {}

Group.leader     = nil
Group.members     = {}
Group.member_count = 0
Group.id           = 0

if SERVER then

--[[
    Realm: Server
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
    Realm: Server
    Args: Player ply
    Desc: Adds a player to the group
    Return: index at which the ply was inserted in the group member table
]]
function Group:AddMember(ply)
    if not (ply and ply:IsPlayer()) then -- make sure player is valid
        _DBUG(" Group:AddMember - ply not valid or not player.") return false end

    i = table.insert(group.members, ply)
    group.member_count = group.member_count + 1
end

elseif CLIENT then

end
