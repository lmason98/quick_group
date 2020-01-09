--[[-------------------------
--    Console Variables
--]]-------------------------

--[[-------------------------
--    Hooks
--]]-------------------------

-- Desc: Shows the create group menu button if a player isn't in a group
hook.Add "OnContextMenuOpen", "rustgroup_show_creategroup_frame", ->
    print " OPENED!"
    if not rustgroup.creategroup_frame or not rustgroup.creategroup_frame\IsValid!
        rustgroup.creategroup_frame = vgui.Create "rustgroup_creategroup_frame", g_ContextMenu

    if not rustgroup.creategroup_frame\IsVisible! and not LocalPlayer()\InRustGroup!
        rustgroup.creategroup_frame\Show!
        rustgroup.creategroup_frame\MoveToFront!

-- Desc: Hides the group create menu 
hook.Add "OnContextMenuClose", "rustgroup_show_creategroup_frame", ->
    print " CLOSED!"
    if not rustgroup.creategroup_frame or not rustgroup.creategroup_frame\IsValid!
        rustgroup.creategroup_frame = vgui.Create "rustgroup_creategroup_frame"

    if rustgroup.creategroup_frame\IsVisible!
        rustgroup.creategroup_frame\Hide!
