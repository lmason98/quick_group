--[[-------------------------
--    Console Variables
--]]-------------------------

CreateClientConVar "rustgroup_hud_pos_x", ScrW! / 8, true, false, "Hud X Pos", 0, ScrW!
CreateClientConVar "rustgroup_hud_pos_y", ScrH! - (ScrH! / 8), true, false, "Hud Y Pos", 0, ScrH!
CreateClientConVar "rustgroup_hud_text_bold", 0, true, false, "Should hud text be bold", 0, 1
CreateClientConVar "rustgroup_hud_text_size", 20, true, false, "Hud text size", 10, 30
CreateClientConVar "rustgroup_hud_widget_size", 16, true, false, "Hud widget size", 10, 30

cvars.AddChangeCallback "rustgroup_hud_pos_x", () -> rustgroup.UpdateCVarVals!
cvars.AddChangeCallback "rustgroup_hud_pos_y", () -> rustgroup.UpdateCVarVals!
cvars.AddChangeCallback "rustgroup_hud_text_bold", () -> rustgroup.UpdateCVarVals!
cvars.AddChangeCallback "rustgroup_hud_text_size", () -> rustgroup.UpdateCVarVals!
cvars.AddChangeCallback "rustgroup_hud_widget_size", () -> rustgroup.UpdateCVarVals!

--[[-------------------------
--    Hooks
--]]-------------------------

-- Desc: Shows the create group menu button if a player isn't in a group
hook.Add "OnContextMenuOpen", "rustgroup_show_creategroup_frame", ->
    if not LocalPlayer!\InRustGroup!
        rustgroup.creategroup_frame = vgui.Create "rustgroup_creategroup_frame", g_ContextMenu
        rustgroup.creategroup_frame\MoveToFront!

-- Desc: Hides the group create menu 
hook.Add "OnContextMenuClose", "rustgroup_show_creategroup_frame", ->
    if rustgroup.creategroup_frame\IsValid!
        rustgroup.creategroup_frame\Remove!

-- Desc: Draws the LocalPlayer's group if they're in one
hook.Add "HUDPaint", "rustgroup_draw_group", ->
    if LocalPlayer!\InRustGroup!
        rustgroup.DrawGroup!

--[[-------------------------
--   Network Receives 
--]]-------------------------
net.Receive "rustgroup_add_member", (len) -> LocalPlayer!\AddGroupMember net.ReadEntity!
net.Receive "rustgroup_remove_member", (len) -> LocalPlayer!\RemoveGroupMember net.ReadEntity!
net.Receive "rustgroup_group_disbanded", (len) -> LocalPlayer!\RustGroupDisbanded!
