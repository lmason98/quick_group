pad = 5

x = cvars.Number "rustgroup_hud_pos_x", 0
y = cvars.Number "rustgroup_hud_pos_y", 0
textSize = cvars.Number "rustgroup_hud_text_size", 10
widgetSize = cvars.Number "rustgroup_hud_widget_size", 16
bold = cvars.Bool "rustgroup_hud_text_bold", false

rustgroup.UpdateCVarVals = ->
    print " UpdateCVarVals Called!"
    x = cvars.Number "rustgroup_hud_pos_x", 0
    y = cvars.Number "rustgroup_hud_pos_y", 0
    textSize = cvars.Number "rustgroup_hud_text_size", 10
    widgetSize = cvars.Number "rustgroup_hud_widget_size", 16
    bold = cvars.Bool "rustgroup_hud_text_bold", false

-- Desc: Draws a Rust Group
rustgroup.DrawGroup = ->
    font = "rustgroup_#{textSize}"
    font ..= 'b' if bold

    surface.SetDrawColor 255, 255, 255, 255
    surface.DrawRect x, y, widgetSize, widgetSize
    surface.SetDrawColor 0, 0, 0, 255
    surface.DrawOutlinedRect x-1, y-1, (widgetSize)+2, (widgetSize)+2
    draw.SimpleTextOutlined LocalPlayer!\GetName!, font, x + widgetSize + pad, y + widgetSize/2, Color(255,255,255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER, 1, Color 0,0,0

