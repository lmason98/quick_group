import insert, RemoveByValue from table

PLAYER = FindMetaTable "Player"

-- Args: Number group_id
-- Desc: Set/Get player's group id
-- Return: Number group_id
PLAYER.SetRustGroup = (g_id) => @\SetNWInt "group_id", g_id
PLAYER.GetRustGroup = () => return @\GetNWInt "group_id", -1

-- Args: Bool is_leader
-- Desc: Set/Get if the player is a group leader
-- Return: Bool is_leader
PLAYER.SetGroupLeader = (is_leader) => @\SetNWBool "group_leader", is_leader
PLAYER.IsGroupLeader = () => return @\GetNWBool "group_leader", false


-- Desc: Checks if the player is in a group
-- Return: Bool inGroup
PLAYER.InRustGroup = () =>
    return true if @\GetRustGroup! >= 0
    return false
