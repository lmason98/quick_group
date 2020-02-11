import insert, IsEmpty from table

if SERVER
    -- Args: Player ply
    -- Desc: Creates a new rust group
    concommand.Add "CreateRustGroup", (ply) ->
        gID = rustgroup.NewGroup ply
        print " [RUSTGROUP] new group created with id=#{gID}" if gID

    -- Args: Player ply
    -- Desc: Leaves a rust group 
    concommand.Add "LeaveRustGroup", (ply) ->
        rustgroup.PlyLeaveGroup ply, ply\GetRustGroup!
    
    -- Args: Player ply
    -- Desc: Prints rust groups to the server console
    concommand.Add "PrintRustGroups", (ply) ->
        if ply\IsSuperAdmin! and rustgroup.groups
            rustgroup.PrintGroups!

else
    -- Desc: Opens a group display config frame
    concommand.Add "RustGroupConfig", () ->
        vgui.Create "rustgroup_cfg_frame"

-- Desc: Prints the rustgroups (DEV)
-- Args: Player ply
concommand.Add "ResetCreategroupFrame", (ply) ->
    rustgroup.creategroup_frame = vgui.Create "rustgroup_creategroup_frame", g_ContextMenu
