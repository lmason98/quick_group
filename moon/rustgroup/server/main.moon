import insert from table

interact_dist = 10000

util.AddNetworkString "rustgroup_creategroup_pressed"

rustgroup.groups = {}

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

--[[-------------------------
--   Network Receives 
--]]-------------------------
net.Receive "rustgroup_creategroup_pressed", (len, ply) ->
    print " RECEIVED!"
    if rustgroup.groups and not ply\InRustGroup!
        i = insert rustgroup.groups, RustGroup\New ply
        rustgroup.groups[i]\SetIndex i
        rustgroup.groups[i]\Add ply 

        ply\ChatPrint "You've created a group"
