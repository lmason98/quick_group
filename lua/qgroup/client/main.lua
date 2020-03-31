Qgroup.cmenu_creategroup_btn = nil
Qgroup.cmenu_leavegroup_btn = nil
Qgroup.cmenu_kickmember_btn = nil

Qgroup.members = {} -- This is a member table identical to the player's group member table.
                    -- I maintain this clientside so I have a table ready for looping in QGroup.DrawGroup().

local x,y = 0, ScrH() * 5/8 -- pos vars for the cmenu buttons
local w,h = ScrW()/12, ScrH()/20 -- size vars for the cmenu buttons

-- ******************** CVars ******************** -- 

CreateClientConVar("qgroup_hud_pos_x", 10, true, false, "Group hud x pos", 0, ScrW()-(ScrW()/10))
CreateClientConVar("qgroup_hud_pos_y", ScrH()/2, true, false, "Group hud y pos", 0, ScrH()-(ScrH()/8))
CreateClientConVar("qgroup_hud_text_bold", 0, true, false, "Should group hud text be bold?", 0, 1)
CreateClientConVar("qgroup_hud_text_size", 15, true, false, "Group hud text size", 10, 30)
CreateClientConVar("qgroup_hud_hp_h", 4, true, false, "Group hud hp bar width", 2, 30)
CreateClientConVar("qgroup_hud_hp_w", 125, true, false, "Group hud hp bar width", 10, 30)

cvars.AddChangeCallback("qgroup_hud_pos_x", function() Qgroup.UpdateCVar('x', "qgroup_hud_pos_x") end)
cvars.AddChangeCallback("qgroup_hud_pos_y", function() Qgroup.UpdateCVar('y', "qgroup_hud_pos_y") end)
cvars.AddChangeCallback("qgroup_hud_text_bold", function() Qgroup.UpdateCVar("btext", "qgroup_hud_text_bold") end)
cvars.AddChangeCallback("qgroup_hud_text_size", function() Qgroup.UpdateCVar("stext", "qgroup_hud_text_size") end)
cvars.AddChangeCallback("qgroup_hud_hp_w", function() Qgroup.UpdateCVar("hp_w", "qgroup_hud_hp_w") end)
cvars.AddChangeCallback("qgroup_hud_hp_h", function() Qgroup.UpdateCVar("hp_h", "qgroup_hud_hp_h") end)

-- ******************** Network ******************** -- 
--
--[[
    Desc: Adds a player to the clientside member table
]]
net.Receive("qgroup_create_group", function(len)
    table.insert(Qgroup.members, LocalPlayer())
    _DBUG("qgroup_create_group - Qgroup.members=")
    PrintTable(Qgroup.members)
end)

--[[
    Desc: Adds a player to the clientside member table
]]
net.Receive("qgroup_add_member", function(len)
    local ply = net.ReadEntity()
    table.insert(Qgroup.members, ply)
    _DBUG("qgroup_add_member - Qgroup.members=")
    PrintTable(Qgroup.members)
end)

--[[
    Desc: Removes a player from the clientside member table
]]
net.Receive("qgroup_remove_member", function(len)
    local ply = net.ReadEntity()
    for i, member in pairs(Qgroup.members) do
        if (member == ply) then
            table.remove(Qgroup.members, i) end
    end
    _DBUG("qgroup_remove_member - Qgroup.members=")
    PrintTable(Qgroup.members)
end)

--[[
    Desc: Clears the clientside members table
]]
net.Receive("qgroup_leave_group", function(len)
    Qgroup.members = {} 
    _DBUG("qgroup_leave_group - Qgroup.members=")
    PrintTable(Qgroup.members) end)

-- ******************** Hooks ******************** -- 

--[[
    Desc: Paints the group on the player's hud
]]
hook.Add("HUDPaint", "qgroup_group_draw", function()
    if (LocalPlayer():GetQGroupID() >= 0) then
        Qgroup.DrawGroup()
    end
end)

--[[
    Desc: Manages the cmenu addon buttons (create/leave group and kickmember)
]]
hook.Add("OnContextMenuOpen", "qgroup_show_group_vgui", function()
    if (LocalPlayer():GetQGroupID() == -1) then
        if not (IsValid(Qgroup.cmenu_creategroup_btn)) then -- create group button
            Qgroup.cmenu_creategroup(x, y, w, h)
        else
            Qgroup.cmenu_creategroup_btn:Show()
        end
    elseif (LocalPlayer():GetQGroupID() >= 0) then
        if not (IsValid(Qgroup.cmenu_leavegroup_btn)) then -- leave group button
            Qgroup.cmenu_leavegroup(x, y, w, h)
        else
            Qgroup.cmenu_leavegroup_btn:Show()
        end

        if (not IsValid(Qgroup.cmenu_kickmember_btn) and LocalPlayer():GetQGroupLeader()) then -- kick member button
            y = y + h + Qgroup.config.theme.pad
            Qgroup.cmenu_kickmember(x, y, w, h)
        elseif (LocalPlayer():GetQGroupLeader()) then
            Qgroup.cmenu_kickmember_btn:Show()
        end
    end
end)
hook.Add("OnContextMenuClose", "qgroup_hide_group_vgui", function()
    if (IsValid(Qgroup.cmenu_creategroup_btn)) then
        Qgroup.cmenu_creategroup_btn:Hide() end
    if (IsValid(Qgroup.cmenu_leavegroup_btn)) then
        Qgroup.cmenu_leavegroup_btn:Hide() end
    if (IsValid(Qgroup.cmenu_kickmember_btn)) then
        Qgroup.cmenu_kickmember_btn:Hide() end
end)
