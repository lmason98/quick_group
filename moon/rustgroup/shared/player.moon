import insert, RemoveByValue from table

PLAYER = FindMetaTable "Player"

-- Args: Number groupID
-- Desc: Set/Get player's group id
-- Return: Number groupID
PLAYER.SetGroupI = (gID) => self._gID = i
PLAYER.GetGroupI = () => return self._gID or -1

-- Desc: Checks if the player is in a group
-- Return: Bool inGroup
PLAYER.IsInGroup = () =>
    if self\GetGroupI! >= 0
        return true
    return false

-- Args: Number gID
-- Desc: Adds a player to the group with the given gID
-- Return: Bool success
PLAYER.JoinGroup = (gID) =>
    g = rustgroup.getGroup gID
