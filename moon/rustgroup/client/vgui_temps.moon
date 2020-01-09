anim_time = 0.2
theme =
    enabled: true,
    outline: Color( 0, 0, 0, 255 ),
    main: Color( 37, 37, 37, 255 ),
    background: Color( 30, 30, 30, 255 ),
    btn: Color( 25, 25, 25, 255 ),
    focused: Color( 51, 51, 51, 255 ),
    btndown: Color( 65, 65, 65, 255 ),
    text: Color( 173, 173, 173, 255 ),
    textSelected: Color( 201, 212, 201, 255 )

--[[-------------------------
--    Button
--]]-------------------------
button = {}

-- Desc: Button animation
button.OnCursorEntered = =>
    @ColorTo @.hovered_col, anim_time, 0
-- Desc: Button animtion
button.OnCursorExited = =>
    @ColorTo @.default_col, anim_time, 0

-- Args: Number dock, Table margin, Number size, String text, String font, Function callBack, Bool outline
-- Desc: Builds the button (dock/size)
button.Build = (dock, margin, size, text, font, callBack, outline=false) =>
    @Dock dock
    @DockMargin margin.l, margin.t, margin.r, margin.b -- left, top, right, bottom
    @InvalidateParent true
    if dock == LEFT or dock == RIGHT 
        @SetWide size 
    else
        @SetTall size
    @._text = text
    @._font = font
    @DoClick = callBack
    @._outline = outline

-- Args: Number w, Number h 
-- Desc: Button paint
button.Paint = (w, h) =>
    surface.SetDrawColor @GetColor!
    surface.DrawRect 0,0,w,h
    if @._outline
        surface.SetDrawColor 0, 0, 0 
        surface.DrawOutlinedRect 0,0,w,h
    draw.SimpleText @._text, @._font, w/2, h/2, Color(255,255,255,200), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER

-- Desc: Set button colors
button.Init = =>
    @._text = ""
    @._font = "DermaDefault"
    @SetText ""

vgui.Register "rustgroup_button", button, "DButton"
