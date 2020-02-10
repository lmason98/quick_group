util.AddNetworkString "rustgroup_creategroup_pressed"
util.AddNetworkString "rustgroup_leavegroup_pressed"
util.AddNetworkString "rustgroup_invite_ply"
util.AddNetworkString "rustgroup_member_join"
util.AddNetworkString "rustgroup_member_leave"
util.AddNetworkString "rustgroup_join_group"
util.AddNetworkString "rustgroup_leave_group"

interact_dist = 10000

--[[-------------------------
--    Hooks
--]]-------------------------

-- Desc: Handles manual group invites
-- Args: Player ply, Number key
hook.Add "KeyPress", "rustgroup_invite_ply", (ply, key) ->
    if key == IN_USE and ply\KeyDown IN_WALK -- have to be slow walking prior to e press
        trace = ply\GetEyeTrace!
        if trace.Entity\IsValid! and (trace.Entity\IsPlayer! or trace.Entity\IsBot!)
            if interact_dist > ply\GetPos!\DistToSqr trace.HitPos
                if trace.Entity\IsBot! -- remove later
                    rustgroup.PlyJoinGroup trace.Entity, ply\GetRustGroup!
                    ply\ChatPrint "Hit!"
                else
                    net.Start "rustgroup_invite_ply"
                    net.WriteEntity trace.Entity
                    net.Send
                    ply\ChatPrint "Hit!"

--[[-------------------------
--    Network Recieves
--]]-------------------------

-- Sent from cl -> sv when player presses the create group button
net.Receive "rustgroup_creategroup_pressed", (len, ply) ->
    gID = rustgroup.NewGroup ply
    print " [RUSTGROUP] new group created with id=#{gID}" if gID

-- Sent from cl -> sv when player presses the leave group button
net.Receive "rustgroup_leavegroup_pressed", (len, ply) ->
    gID = rustgroup.PlyLeaveGroup ply, ply\GetRustGroup!

--net.Receive "rustgroup_invite_ply", (len, ply) ->
--    invitedPly = net.ReadEntity!
--    rustgroup.PlyJoinGroup invitedPly, ply\GetRustGroup!
