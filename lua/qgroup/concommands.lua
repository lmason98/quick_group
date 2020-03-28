if SERVER then

concommand.Add("CreateQGroup", function(ply)
    ply:CreateQGroup()
    _DBUG("concommand CreateQGroup - ".. ply:Nick() .." created new group with id=" )--ply:GetQGroupID())
end)

elseif CLIENT then



end
