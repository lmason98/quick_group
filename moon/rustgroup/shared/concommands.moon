import insert, IsEmpty from table

-- Desc: Console command for creating a new rust group
-- Args: Player ply, String cmd, Table conArgs
if SERVER
    concommand.Add "CreateRustGroup", (ply) ->
        gID = rustgroup.NewGroup ply
        print " [RUSTGROUP] new group created with id=#{gID}" if gID

    concommand.Add "LeaveRustGroup", (ply) ->
        gID = ply\GetRustGroup!

        if gID >= 0 -- if ply in group
            rustgroup.PlyLeaveGroup ply, gID
        else
            ply\ChatPrint "You're not in a group!"

    concommand.Add "PrintRustGroups", (ply) ->
        if ply\IsSuperAdmin! and rustgroup.groups
            rustgroup.PrintGroups!

-- Desc: Prints the rustgroups (DEV)
-- Args: Player ply
concommand.Add "ResetCreategroupFrame", (ply) ->
    rustgroup.creategroup_frame = vgui.Create "rustgroup_creategroup_frame", g_ContextMenu
