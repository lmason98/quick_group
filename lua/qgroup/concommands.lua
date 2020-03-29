if SERVER then

concommand.Add("CreateQGroup", function(ply)
    ply:CreateQGroup()
    _DBUG("concommand CreateQGroup - ".. ply:Nick() .." created new group with id=".. ply:GetQGroupID()) end)

concommand.Add("LeaveQGroup", function(ply)
    local id = ply:GetQGroupID()
    ply:LeaveQGroup()
    
    _DBUG("concommand LeaveQGroup - ".. ply:Nick() .." left group with id=".. id)
end)

concommand.Add("PrintQGroups", function(ply)
    Qgroup.PrintGroups()
end)

elseif CLIENT then



end
