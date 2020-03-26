local dbg = EASYGROUP.dbug
local Group = {}

Group.leader     = nil
Group.members     = {}
Group.member_count = 0
Group.id           = 0

--[[
    Realm: Server
    Args: Player leader
    Desc: EasyGroup constructor, sets the Group leader, adds it to the member table and increments member count.
    Return: Bool success
]]
function EASYGROUP.Group(leader)
    local grp = table.Copy(Group)

    if SERVER then return false end
    if (leader and IsValid(leader) and leader:IsPlayer()) then -- make sure player is valid
        dbg(" Group:Init - leader not valid.") return false end

    grp.leader = leader
    table.insert(grp.members, leader)
    grp.member_count = self.member_count + 1

    return grp
end

--[[
]]
