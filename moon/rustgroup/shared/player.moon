import insert, RemoveByValue from table

PLAYER = FindMetaTable "Player"

-- Args: Number groupID
-- Desc: Set/Get player's group id
-- Return: Number groupID
PLAYER.SetRustGroup = (gID) => @\SetNWInt "group_id", gID
PLAYER.GetRustGroup = () => return @\GetNWInt "group_id", -1

-- Desc: Checks if the player is in a group
-- Return: Bool inGroup
PLAYER.InRustGroup = () =>
    if @\GetRustGroup! >= 0
        return true
    return false
