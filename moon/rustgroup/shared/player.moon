PLAYER = FindMetaTable "Player"

-- Desc: Player method for joining a group
-- Args: Number index, Bool isLeader
PLAYER.JoinRustGroup = (i, isLeader) =>
    if SERVER
        @\SetNWInt "group_index", i
        @\SetNWBool "group_leader", isLeader

-- Desc: Checks if the player is in a group
-- Return: Bool inGroup
PLAYER.InRustGroup = =>
    return @\GetNWInt("group_index", -1) != -1  

-- Desc: Checks if the player is a leader of a group
-- Return: Bool isLeader
PLAYER.IsLeadingRustGroup = => return @\GetNWInt "group_leader", false
