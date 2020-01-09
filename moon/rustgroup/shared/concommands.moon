import insert, IsEmpty from table

-- Desc: Console command for creating a new rust group
-- Args: Player ply, String cmd, Table conArgs
concommand.Add "CreateRustGroup", (ply, cmd, conArgs) ->
    if SERVER
        print "rustgroup.groups: #{rustgroup.groups}"
        if rustgroup.groups and not ply\InRustGroup!
            i = insert rustgroup.groups, RustGroup\New ply
            rustgroup.groups[i]\SetIndex i
            rustgroup.groups[i]\Add ply 

            ply\ChatPrint "You've created a group"
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

-- Desc: Prints the rustgroups (DEV)
-- Args: Player ply
concommand.Add "ResetCreategroupFrame", (ply) ->
    rustgroup.creategroup_frame = vgui.Create "rustgroup_creategroup_frame", g_ContextMenu
