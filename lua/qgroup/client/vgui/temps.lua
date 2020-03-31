local anim_time = 0.2

-- ******************** Button ******************** -- 

local button = {}
local col_btn_w = ScreenScale(15) -- collapsed button width

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
    local outline_col = Qgroup.config.theme.btn_outline_col
    local text_col = Qgroup.config.theme.text_col

    if (self:IsDown()) then
        col = Qgroup.config.theme.btndown_col
        text_col = Qgroup.config.theme.textselected_col
    elseif (self:IsHovered()) then
        col = Qgroup.config.theme.focused_col
    end

    local rad = 0
    if (w < h) then
        rad = w/2
    else
        rad = h/2 end

    --draw.RoundedBoxEx(rad-2, 0, 0, w, h, outline_col, false, true, false, true) -- outline
    draw.RoundedBoxEx(rad, 0, 0, w, h, col, false, true, false, true) -- inside

    draw.SimpleText(self.text, self.font, ScreenScale(3), h/2, text_col,
        TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
end


--[[
    Desc: Inits the button
]]
function button:Init()
    self:SetText('')
    self:SetAlpha(Qgroup.config.theme.btn_alpha)
end

vgui.Register("QGroup_button", button, "DButton")
