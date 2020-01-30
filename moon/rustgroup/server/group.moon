import insert, remove, Copy, Count from table

rustgroup.groups = {}

MAX_MEMS = rustgroup.cfg.max_group_size -- maximum amount of members allowed in a group
GROUP =
    leader: nil -- Player
    members: {} -- table of Players
    id: -1 -- group id

-- Args: Player ply (optional)
-- Desc: Creates a new group and adds to global group table
-- Return: Number groupID
rustgroup.newGroup = (ply) ->
    g = Copy GROUP

    if ply
        g.leader = ply -- set leader as ply
        ply\SetGroupI insert g.members, ply -- insert ply

    g.id = insert rustgroup.groups, g -- index in global group table

    return g.id

-- Args: Number groupID
-- Desc: Removes a group from the global group table
-- Return: Bool success
rustgroup.remGroup = (gID) ->
    for i, g in pairs rustgroup.groups -- need to track index in global group table
        if g.id == gID
            -- print "remGroup: gID=#{gID} g.id=#{g.id} i=#{i}"
            remove rustgroup.groups, i -- should be proper group index
            return true

    return false

-- Args: Number gID
-- Desc: Gets the group with the given gID
-- Return: Group table or false if not found
rustgroup.getGroup = (gID) ->
    for g in *rustgroup.groups
        if g.id == gID
            return g

    return false

-- Desc: Prints the global group table
rustgroup.printGroups = ->
    for g in *rustgroup.groups
        print "\n*------------------------------*"
        print "\t Leader: #{g.leader\GetName! or "NULL"}"
        mems = "\t Members: "
        mems ..= "[ply=#{ply\GetName!} id=#{ply\GetGroupI!}]->" for ply in *g.members
        print mems
        print "\t Id: #{g.id}"
        print "*------------------------------*\n"
