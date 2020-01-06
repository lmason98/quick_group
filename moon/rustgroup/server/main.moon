interact_dist = 10000

rustgroup.groups = {}

-- Desc: Handles manual group invites
-- Args: Player ply, Number key
hook.Add "KeyPress", "rustgroup_invite_ply", (ply, key) ->
    -- have to be slow walking prior to e press
    if key == IN_USE and ply\KeyDown IN_WALK 
        trace = ply\GetEyeTrace!
        if trace.Entity\IsValid! and trace.Entity\IsPlayer! 
            if interact_dist > ply\GetPos!\DistToSqr trace.HitPos
                ply\ChatPrint "Hit!"
