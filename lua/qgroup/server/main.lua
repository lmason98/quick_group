Qgroup.group_table = {}

-- ******************** Hooks ******************** -- 

--[[
    Hook: KeyPress
    Args: Player ply, Number key
    Desc: ply press alt+e will invite a player if looking at said player within interact_dist
          specified in config
]]
hook.Add("KeyPress", "qgroup_invite_ply", function(ply, key)
    if (key == IN_USE) and (ply:KeyDown(IN_WALK)) then
        trace = ply:GetEyeTrace()
        -- remove bot or player later
        if (IsValid(trace.Entity)) and (trace.Entity:IsBot() or trace.Entity:IsPlayer()) then
            if (Qgroup.config.interact_dist > ply:GetPos():DistToSqr(trace.HitPos)) then
                ply:ChatPrint("inviting!")
            end
        end
    end
end)
