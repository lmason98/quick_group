frame = {} -- creategroup frame
anim_time = 0.2

--[[-------------------------
--  Context menu button for creating a group  
--]]-------------------------

frame.Build = =>
    @.btn = vgui.Create "rustgroup_button", @
    @.btn\Build FILL,
        {l: 0, t: 0, r: 0, b: 0},
        0,
        "CREATE GROUP",
        "rustgroup_35b",
        -> 
            net.Start "rustgroup_creategroup_pressed"
            net.SendToServer!

    @.btn.default_col = rustgroup.cfg.creategroup_default_col
    @.btn.hovered_col = rustgroup.cfg.creategroup_hovered_col
    @.btn\SetColor @.btn.default_col

frame.Paint = (w,h) =>

frame.Init = =>
    @DockPadding 0,0,0,0
    @SetSize ScrW!/8, ScrH!/12
    @SetPos @GetWide!, ScrH! - @GetTall!*2
    @ShowCloseButton false
    @SetTitle ""
    @Build!
    @Hide!

vgui.Register "rustgroup_creategroup_frame", frame, "DFrame"
