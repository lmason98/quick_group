import insert, RemoveByValue from table

PLAYER = FindMetaTable "Player"

-- Desc: Checks if the player is in a group
-- Return: Bool inGroup
PLAYER.InRustGroup = => return @\GetNWInt("group_index", -1) != -1  

-- Desc: Checks if the player is leading a group
-- Return: Bool isLeader
PLAYER.LeadingRustGroup = => return @\GetNWInt "group_leader", false

--[[-------------------------
--   Server 
--]]-------------------------

-- Desc: Player method for creating a group
PLAYER.CreateRustGroup = =>
    if SERVER
        if not @\InRustGroup!
            i = RustGroup\New @ 

            print " New rust group index: #{i}"

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
        
        rustgroup.groups[i]\Kick @ if rustgroup.groups[i]

        @\SetNWInt "group_index", -1
        @\SetNWBool "group_leader", false

        @\ChatPrint "You have left the group."
    elseif -1 == @\GetNWInt "group_index", -1
        @\ChatPrint "You are not in a group."

-- Desc: Returns the player's rust group
PLAYER.GetRustGroup = => return rustgroup.groups[tonumber util.GetPData @\SteamID!, "group_index", "-1"] if SERVER

--[[-------------------------
--   Client 
--]]-------------------------

-- Desc: Adds a member to the local player's group table
-- Args: Player ply
PLAYER.AddGroupMember = (ply) =>
    if CLIENT and @.members
        insert @.members, ply

        print " #{@\GetName!} members: "
        PrintTable @.members
    elseif CLIENT and not @.members
        @.members = {}
        insert @.members, ply

-- Desc: Removes a member from the local player's group table
-- Args: Player ply
PLAYER.RemoveGroupMember = (ply) =>
    RemoveByValue @.members ply if CLIENT and @.members
    print " #{@\GetName!} members: "
    PrintTable @.members

-- Desc: Removes all of the members from the local player's group table
PLAYER.RustGroupDisbanded = => @.members = {} if CLIENT
