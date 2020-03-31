--[[
    Args: Number x, y, w, h
    Desc: Builds the create group cmenu button and adds it to the global Qgroup table
]]
function Qgroup.cmenu_creategroup(x, y, w, h)
    local creategrp_btn = vgui.Create("QGroup_button", g_ContextMenu)
    creategrp_btn:Build(x, y, w, h, "Create Group", "qgroup_25b", true)
    creategrp_btn:MoveToFront()

    creategrp_btn.DoClick = function()
        LocalPlayer():ConCommand("CreateQGroup")
    end

    Qgroup.cmenu_creategroup_btn = creategrp_btn
end

--[[
    Args: Number x, y, w, h
    Desc: Builds the leave group cmenu button and adds it to the global Qgroup table
]]
function Qgroup.cmenu_leavegroup(x, y, w, h)
    local leavegroup_btn = vgui.Create("QGroup_button", g_ContextMenu)
    leavegroup_btn:Build(0, y, ScrW()/12, ScrH()/20, "Leave Group", "qgroup_25b", true)
    leavegroup_btn:MoveToFront()

    leavegroup_btn.DoClick = function()
        LocalPlayer():ConCommand("LeaveQGroup")
    end

    Qgroup.cmenu_leavegroup_btn = leavegroup_btn
end

--[[
    Args: Number x, y, w, h
    Desc: Builds the kick member cmenu button and adds it to the global Qgroup table
]]
function Qgroup.cmenu_kickmember(x, y, w, h)
    local kickmember_btn = vgui.Create("QGroup_button", g_ContextMenu)
    kickmember_btn:Build(0, y, ScrW()/12, ScrH()/20, "Kick Member", "qgroup_25b", true)
    kickmember_btn:MoveToFront()

    kickmember_btn.DoClick = function()
        -- open another vgui here showing members to kick
    end

    Qgroup.cmenu_kickmember_btn = kickmember_btn
end
