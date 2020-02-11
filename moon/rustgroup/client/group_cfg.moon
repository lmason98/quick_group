pad = 5
frame = {}
anim_time = 0.2

--[[-------------------------
--  Config frame for clients to change group display settings
--]]-------------------------

-- Desc: Docks a DForm
frame.Build = () =>
    form = vgui.Create "DForm", @
    form\Dock FILL
    for i = 1,10
        form\Button i, "blah", nil

    @GetParent!\SizeToContents!


-- Desc: Initializes the group display config frame
frame.Init = () =>
    @SetSize ScrW!/4, ScrH!/3
    @Center!
    @SetName "Group Display Config"
    @MakePopup!
    @Build!

vgui.Register "rustgroup_cfg_frame", frame, "DFrame"
