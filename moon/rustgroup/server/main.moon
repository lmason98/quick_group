import insert from table

interact_dist = 10000
rustgroup.groups = {}

util.AddNetworkString "rustgroup_creategroup_pressed"


--[[-------------------------
--    Functions 
--]]-------------------------


--[[-------------------------
--    Hooks
--]]-------------------------

-- Desc: Handles manual group invites
-- Args: Player ply, Number key
hook.Add "KeyPress", "rustgroup_invite_ply", (ply, key) ->
    -- have to be slow walking prior to e press
    if key == IN_USE and ply\KeyDown IN_WALK 
        trace = ply\GetEyeTrace!
        if trace.Entity\IsValid! and trace.Entity\IsPlayer! 
            if interact_dist > ply\GetPos!\DistToSqr trace.HitPos
                ply\ChatPrint "Hit!"

-- Desc: Removes the player from a group when they disconnect
-- Args: Player ply
hook.Add "PlayerDisconnected", "rustgroup_ply_disconnect", (ply) -> ply\LeaveRustGroup! if ply\InRustGroup!


--[[-------------------------
--   Network Receives 
--]]-------------------------

-- Desc: Creates a group when a player presses the create group c-menu button
-- Args: Number len, Player sender 
net.Receive "rustgroup_creategroup_pressed", (len, sender) ->
    if rustgroup.groups and not sender\InRustGroup!
        RustGroup\New sender

        sender\ChatPrint "You have created a group."
    elseif sender\InRustGroup!
        sender\ChatPrint "You are already in a group."
