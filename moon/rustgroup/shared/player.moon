PLAYER = FindMetaTable "Player"

-- Desc: Player method for creating a group
PLAYER.CreateRustGroup = =>
    if SERVER
        if not @\InRustGroup!
            i = RustGroup\New @ 
            @\SetNWInt "group_index", i
            @\SetNWBool "group_leader", true
    
            @\ChatPrint "You have created a group."
        elseif @\InRustGroup!
            @\ChatPrint "You are already in a group."

-- Desc: Player method for joining a group
-- Args: Number groupIndex
PLAYER.JoinRustGroup = (i) =>
    if SERVER
        if rustgroup.groups[i]\IsValid! and not @\InRustGroup!
            rustgroup.groups[i]\Add @ 
            @\SetNWInt "group_index", i
            @\SetNWBool "group_leader", false

            @\ChatPrint "You have joined a group."
        elseif @\InRustGroup!
            @\ChatPrint "You are already in a group."

-- Desc: Player method for leaving a group
PLAYER.LeaveRustGroup = =>
    if SERVER and -1 != @\GetNWInt "group_index", -1
        i = @\GetNWInt "group_index", -1
        
        rustgroup.groups[i]\Kick @ if rustgroup.groups[i]\IsValid!

        @\SetNWInt "group_index", -1
        @\SetNWBool "group_leader", false

        @\ChatPrint "You have left the group."
    elseif -1 == @\GetNWInt "group_index", -1
        @\ChatPrint "You are already in a group."

PLAYER.GetRustGroup = => return rustgroup.groups[tonumber util.GetPData @\SteamID!, "group_index", "-1"]

-- Desc: Checks if the player is in a group
-- Return: Bool inGroup
PLAYER.InRustGroup = => return @\GetNWInt("group_index", -1) != -1  

-- Desc: Checks if the player is a leader of a group
-- Return: Bool isLeader
PLAYER.IsLeadingRustGroup = => return @\GetNWInt "group_leader", false
