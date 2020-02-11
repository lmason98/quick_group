pad = 5
frame = {}
anim_time = 0.2

--[[-------------------------
--  Context menu button for creating/leaving a group  
--]]-------------------------

-- Args: Bool inGroup
-- Desc: Docks either a create or leave group button
frame.Build = (inGroup) =>
    btn_text = "CREATE GROUP"
    net_msg = "rustgroup_creategroup_pressed"

    if inGroup
        btn_text = "LEAVE GROUP"
        net_msg = "rustgroup_leavegroup_pressed"

    @.btn = vgui.Create "rustgroup_button", @
    @.btn\Build FILL, {l: 0, t: 0, r: 0, b: 0}, 0, btn_text, "rustgroup_30b", ->
        net.Start net_msg
        net.SendToServer!

    @.btn.default_col = rustgroup.cfg.creategroup_default_col
    @.btn.hovered_col = rustgroup.cfg.creategroup_hovered_col
    @.btn\SetColor @.btn.default_col

-- make frame invisible
frame.Paint = () =>

-- Desc: Initializes the cmenu button frame
frame.Init = =>
    x, y = (GetConVar "rustgroup_hud_pos_x")\GetInt!, (GetConVar "rustgroup_hud_pos_y")\GetInt!

    @DockPadding 0,0,0,0
    @SetSize ScrW!/9, ScrH!/18
    @SetPos x, y - @GetTall! - pad
    @ShowCloseButton false
    @SetTitle ""
    @Build LocalPlayer!\InRustGroup! -- if player is in group it will show leave group button
                                       -- otherwise it will show create group button 

vgui.Register "rustgroup_buttons_frame", frame, "DFrame"

