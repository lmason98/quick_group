import insert, IsEmpty from table

if SERVER
    -- Desc: Console command for creating a new rust group
    -- Args: Player ply, String cmd, Table conArgs
    concommand.Add "CreateRustGroup", (ply, cmd, conArgs) ->
        if SERVER
            if rustgroup.groups and not ply\InRustGroup!
                RustGroup\New ply
    
                ply\ChatPrint "You have created a group."
            elseif ply\InRustGroup!
                ply\ChatPrint "You are already in a group."
    
    -- Desc: Leaves a group
    concommand.Add "LeaveRustGroup", (ply) ->
        if SERVER
            if ply\GetRustGroup!\IsValid!
                ply\LeaveRustGroup!
    
                ply\ChatPrint "You have left the group."
            else
                ply\ChatPrint "You are not in a group."
    
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
