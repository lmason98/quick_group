local anim_time = 0.2

-- ******************** Button ******************** -- 

local button = {}
local col_btn_w = ScreenScale(10)

--[[
    Desc: Collapse/Expand animation
]]
function button:OnCursorEntered()
    if (self.do_collapse and self.collapsed) then
        self.collapsed = false
        self.text = self.text_cpy
        self:SizeTo(self.w, self:GetTall(), anim_time)
    end
end
function button:OnCursorExited()
    if (self.do_collapse and not self.collapsed) then
        self.collapsed = true
        self.text = ""
        self:SizeTo(col_btn_w, self:GetTall(), anim_time)
    end
end

--[[
    Args: Number x, y, w, h, String text, font, Bool collapse
    Desc: Builds the button
]]
function button:Build(x, y, w, h, text, font, collapse)
    self.w = w
    self:SetPos(x, y)
    self:SetSize(w, h)

    self.text_cpy = text
    self.text = ''
    self.font = font
    self.do_collapse = collapse

    if (self.do_collapse) then
        self.collapsed = true
        self:SetSize(col_btn_w, h)
    else
        self.collapsed = false end
end

--[[
    Args: Number w, Number h
    Desc: Paints the button using theme in config file 
]]
function button:Paint(w, h)
    local col = Qgroup.config.theme.btn_col

    if (self:IsHovered()) then
        col = Qgroup.config.theme.focused_col
    elseif (self:IsDown()) then
        col = Qgroup.config.theme.btndown_col
    end

    draw.RoundedBoxEx(h/2, 0, 0, w, h, col, false, true, false, true)

    draw.SimpleText(self.text, self.font, w/2, h/2, Qgroup.config.theme.text_col,
        TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    _DBUG("button paint - draw text=".. self.text)
end


--[[
    Desc: Inits the button
]]
function button:Init()
    self:SetText('')
end

vgui.Register("QGroup_button", button, "DButton")
