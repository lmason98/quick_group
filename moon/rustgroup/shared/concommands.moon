import insert, IsEmpty from table

-- Desc: Console command for creating a new rust group
-- Args: Player ply, String cmd, Table conArgs
concommand.Add "CreateRustGroup", (ply) ->
    if SERVER
        if ply\GetGroupI! <= 0 -- if ply not in group
            gID = rustgroup.newGroup ply
            ply\SetGroupI gID
            ply\ChatPrint "You've joined group=#{gID}"
        else
            ply\ChatPrint "You're already in a group!"

if SERVER
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
