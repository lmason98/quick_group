Qgroup.cmenu_creategroup_btn = nil
Qgroup.cmenu_leavegroup_btn = nil
Qgroup.cmenu_kickmember_btn = nil

-- ******************** Hooks ******************** -- 

--[[
    Desc: Manages the cmenu addon buttons (create/leave group)
]]
hook.Add("OnContextMenuOpen", "qgroup_show_group_vgui", function()
    local x,y = 0, ScrH() * 5/8
    local w,h = ScrW()/12, ScrH()/20
    if (LocalPlayer():GetQGroupID() == -1) then
        if not (IsValid(Qgroup.cmenu_creategroup_btn)) then -- create group button
            local creategrp_btn = vgui.Create("QGroup_button", g_ContextMenu)
            creategrp_btn:Build(x, y, w, h, "Create Group", "qgroup_25b", true)
            creategrp_btn:MoveToFront()

            Qgroup.cmenu_creategroup_btn = creategrp_btn
        else
            Qgroup.cmenu_creategroup_btn:Show()
        end
    elseif (LocalPlayer():GetQGroupID() >= 0) then
        if not (IsValid(Qgroup.cmenu_leavegroup_btn)) then -- leave group button
            y = y + h + Qgroup.config.theme.pad
            local leavegroup_btn = vgui.Create("QGroup_button", g_ContextMenu)
            leavegroup_btn:Build(0, y, ScrW()/12, ScrH()/20, "Leave Group", "qgroup_25b", true)
            leavegroup_btn:MoveToFront()

            Qgroup.cmenu_leavegroup_btn = leavegroup_btn
        else
            Qgroup.cmenu_leavegroup_btn:Show()
        end

        if not (IsValid(Qgroup.cmenu_kickmember_btn) and LocalPlayer():GetQGroupLeader()) then -- kick member button
            y = y + h + Qgroup.config.theme.pad
            local kickmember_btn = vgui.Create("QGroup_button", g_ContextMenu)
            kickmember_btn:Build(0, y, ScrW()/12, ScrH()/20, "Kick Member", "qgroup_25b", true)
            kickmember_btn:MoveToFront()

            Qgroup.cmenu_kickmember_btn = kickmember_btn
        elseif (LocalPlayer():GetQGroupLeader()) then
            Qgroup.cmenu_kickmember_btn:Show()
        end
    end
end)
hook.Add("OnContextMenuClose", "qgroup_hide_group_vgui", function()
    if (LocalPlayer():GetQGroupID() == -1) then
        if (IsValid(Qgroup.cmenu_creategroup_btn)) then
            Qgroup.cmenu_creategroup_btn:Hide() end
    elseif (LocalPlayer():GetQGroupID() >= 0) then
        if (IsValid(Qgroup.cmenu_leavegroup_btn)) then
            Qgroup.cmenu_leavegroup_btn:Hide() end
        if (IsValid(Qgroup.cmenu_kickmember_btn) and LocalPlayer():GetQGroupLeader()) then
            Qgroup.cmenu_kickmember_btn:Hide() end
    end
end)
