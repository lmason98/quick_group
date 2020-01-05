import insert, IsEmpty from table

-- Desc: Console command for creating a new rust group
-- Args: Player ply, String cmd, Table conArgs
concommand.Add "CreateRustGroup", (ply, cmd, conArgs) ->
    if SERVER
        print "ply in rust group: #{ply\InRustGroup!}"
        if rustgroup.groups and not ply\InRustGroup!
            i = insert rustgroup.groups, RustGroup\New conArgs[1], ply
            rustgroup.groups[i]\SetIndex i
            rustgroup.groups[i]\Add ply 

            ply\ChatPrint "You've created the group: #{conArgs[1]}"
        elseif IsEmpty conArgs
            ply\ChatPrint "You must enter a group name!"
        elseif ply\InRustGroup!
            ply\ChatPrint "You're already in a group!"
        else print "FUCK"

-- Desc: Prints the rustgroups (DEV)
-- Args: Player ply
concommand.Add "PrintRustGroups", (ply) ->
    if SERVER and ply\IsSuperAdmin! and rustgroup.groups
        group\Print! for group in *rustgroup.groups
    elseif SERVER and not IsValid rustgroup.groups
        print " FUCK"
