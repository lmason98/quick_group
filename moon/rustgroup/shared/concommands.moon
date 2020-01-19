import insert, IsEmpty from table

if SERVER
    -- Desc: Console command for creating a new rust group
    -- Args: Player ply, String cmd, Table conArgs
    concommand.Add "CreateRustGroup", (ply, cmd, conArgs) -> ply\CreateRustGroup! if SERVER
    
    -- Desc: Leaves a group
    concommand.Add "LeaveRustGroup", (ply) ->
        if SERVER
            ply\LeaveRustGroup! 
    
    -- Desc: Prints the rustgroups (DEV)
    -- Args: Player ply
    concommand.Add "PrintRustGroups", (ply) ->
        if SERVER and ply\IsSuperAdmin! and rustgroup.groups
            group\Print! for group in *rustgroup.groups

-- Desc: Prints the rustgroups (DEV)
-- Args: Player ply
concommand.Add "ResetCreategroupFrame", (ply) ->
    rustgroup.creategroup_frame = vgui.Create "rustgroup_creategroup_frame", g_ContextMenu
