pad = 5
pos_x = cvars.Number "rustgroup_hud_pos_x", 0
pos_y = cvars.Number "rustgroup_hud_pos_y", 0
textSize = cvars.Number "rustgroup_hud_text_size", 10
widgetSize = cvars.Number "rustgroup_hud_widget_size", 16
bold = cvars.Bool "rustgroup_hud_text_bold", false

interact_dist = 10000

cvars.AddChangeCallback "rustgroup_hud_pos_x", () -> pos_x = cvars.Number "rustgroup_hud_pos_x", 0
cvars.AddChangeCallback "rustgroup_hud_pos_y", () -> pos_y = cvars.Number "rustgroup_hud_pos_y", 0
cvars.AddChangeCallback "rustgroup_hud_text_size", () -> textSize = cvars.Number "rustgroup_hud_text_size", 10
cvars.AddChangeCallback "rustgroup_hud_widget_size", () -> widgetSize = cvars.Number "rustgroup_hud_widget_size", 16
cvars.AddChangeCallback "rustgroup_hud_text_bold", () -> bold = cvars.Bool "rustgroup_hud_text_bold", false

-- Args: Number x, Number y, String name
-- Desc: Draws a name for the DrawGroup function
drawName = (x, y, name) ->
    font = "rustgroup_#{textSize}"
    font ..= 'b' if bold

    surface.SetDrawColor 255, 255, 255, 255
    surface.DrawRect x, y, widgetSize, widgetSize
    surface.SetDrawColor 0, 0, 0, 255
    surface.DrawOutlinedRect x-1, y-1, widgetSize+2, widgetSize+2
    draw.SimpleTextOutlined name, font, x + widgetSize + pad, y + widgetSize/2, Color(255,255,255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER, 1, Color 0,0,0

-- Desc: Draws a Rust Group
rustgroup.DrawGroup = () ->
    x, y = pos_x, pos_y -- don't want to update upper declarations

    drawName x, y, LocalPlayer!\GetName!

    for mem in *rustgroup.members
        y += textSize + pad
        drawName x, y, mem\GetName!

-- Args: Player ply, Number distance
-- Desc: Draws the invite prompt on passed ply, uses passed distance to
--       determine alpha of the color
rustgroup.DrawInvitePrompt = (ply, dist) ->
    alpha = 255 - ((255/interact_dist) * dist)
    alpha = math.Clamp alpha, 0, 255
    col = Color 255, 255, 255, alpha
    outline_col = Color 0, 0, 0, alpha

    cam.Start3D!
    pos_data = ply\GetPos!\ToScreen!
    x, y = pos_data.x, pos_data.y
    cam.End3D!

    y -= ScreenScale 200 -- place the prompt a little higher (not at feet)
    draw.SimpleTextOutlined "Press [ALT + e] to invite", "rustgroup_30b", x, y, col, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, outline_col

