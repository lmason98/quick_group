Qgroup.cmenu_frame = nil

-- ******************** Hooks ******************** -- 

hook.Add("OnContextMenuOpen", "qgroup_show_group_vgui", function()
    if not (IsValid(Qgroup.cmenu_frame)) then
        Qgroup.cmenu_frame = vgui.Create("QGroup_cmenu_frame", g_ContextMenu)
        Qgroup.cmenu_frame:MoveToFront()
    end
end)
--hook.Add("OnContextMenuClose", "qgroup_hide_group_vgui", function()
--end)
