Qgroup.cmenu_creategroup_btn = nil

-- ******************** Hooks ******************** -- 

hook.Add("OnContextMenuOpen", "qgroup_show_group_vgui", function()
    if not (IsValid(Qgroup.cmenu_creategroup_btn)) then
        local creategrp_btn = vgui.Create("QGroup_button", g_ContextMenu)
        creategrp_btn:Build(0, ScrH() * 5/8, ScrW()/12, ScrH()/20,
            "Create Group", "qgroup_25b", true)
        creategrp_btn:MoveToFront()

        Qgroup.cmenu_creategroup_btn = creategrp_btn
    end
end)
--hook.Add("OnContextMenuClose", "qgroup_hide_group_vgui", function()
--end)
