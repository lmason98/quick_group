import insert, remove, Copy, Count, RemoveByValue from table

rustgroup.groups = {}
MAX_MEMS = rustgroup.cfg.max_group_size -- maximum amount of members allowed in a group
GROUP =
    leader: nil -- Player
    members: {} -- table of Players
    id: -1 -- group id

-- Args: Player ply (optional)
-- Desc: Creates a new group and adds to global group table
-- Return: Number groupID or false for failure
rustgroup.NewGroup = (ply) ->
    if ply\InRustGroup!
        ply\ChatPrint "You're already in a group with id=#{ply\GetRustGroup!}"
        return false

    g = Copy GROUP

    g.id = insert rustgroup.groups, g -- index in global group table

    if ply
        g.leader = ply -- set leader as ply
        insert g.members, ply -- insert ply to group member table
        ply\SetRustGroup g.id
        ply\ChatPrint "You've created group=#{g.id}"

    return g.id

-- Args: Number groupID
-- Desc: Removes a group from the global group table
-- Return: Bool success
rustgroup.RemGroup = (gID) ->
    for i, g in pairs rustgroup.groups -- need to track index in global group table
        if g.id == gID
            -- print "remGroup: gID=#{gID} g.id=#{g.id} i=#{i}"
            remove rustgroup.groups, i -- should be proper group index
            print " [RUSTGROUP] group with id=#{g.id} disbanded."
            return true

    return false

-- Args: Number gID
-- Desc: Gets the group with the given gID
-- Return: Group table or false if not found
rustgroup.GetGroup = (gID) ->
    for g in *rustgroup.groups
        if g.id == gID
            return g

    return false

-- Args: Player ply, Number gID
-- Desc: Adds a player to the group with the given id
-- Return: Bool success
rustgroup.PlyJoinGroup = (ply, gID) ->
    g = rustgroup.GetGroup gID

    if g
        ply\SetRustGroup g.id
        ply\ChatPrint "You've joined group=#{g.id}"

        net.Start "rustgroup_member_join" -- add new member to exisiting member's cl member table
        net.WriteEntity ply
        net.Send g.members

        net.Start "rustgroup_join_group" -- set new member's cl member table to group member table
        net.WriteTable g.members
        net.Send ply

        insert g.members, ply
        return true

    return false

rustgroup.PlyLeaveGroup = (ply, gID) ->
    g = rustgroup.GetGroup gID

    if g and 1 < Count g.members -- still at least one player in group
        i = RemoveByValue g.members, ply
        ply\SetRustGroup -1
        if i >= 0 -- if actually left a group
            net.Start "rustgroup_member_leave" -- remove leaving member from other member's cl member table
            net.WriteEntity ply
            net.Send g.members

            print "sending leave_group!"
            net.Start "rustgroup_leave_group" -- clear leaving members's cl member table
            net.Send ply

            ply\ChatPrint "You've left group=#{g.id}"
    elseif g -- last player has left, remove group
        ply\SetRustGroup -1
        rustgroup.RemGroup g.id

        print "sending leave_group!"
        net.Start "rustgroup_leave_group" -- clear leaving members's cl member table
        net.Send ply

        ply\ChatPrint "You've disbanded group=#{g.id}"
    else
        ply\ChatPrint "You're not in a group!"
        ply\SetRustGroup -1

-- Desc: Prints the global group table
rustgroup.PrintGroups = () ->
    for g in *rustgroup.groups
        print "\n*------------------------------*"
        print "\t Leader: #{g.leader\GetName! or "NULL"}"
        mems = "\t Members: "
        mems ..= "[ply=#{ply\GetName!} id=#{ply\GetRustGroup!}] " for ply in *g.members
        print mems
        print "\t Id: #{g.id}"
        print "*------------------------------*\n"
