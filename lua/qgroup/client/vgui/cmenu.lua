local FRAME = {}
local scrw, scrh = ScrW(), ScrH()

function FRAME:OnCursorEntered()
    self:SizeTo(self.w, self:GetTall(), 0.2)
end

function FRAME:OnCursorExited()
    self:SizeTo(20, self:GetTall(), 0.2)
end

--[[
]]
function FRAME:Build()
        -- collapse button --
    --local btn_w = 20
    --local btn = vgui.Create("DButton", self)
    --btn:Dock(RIGHT)
    --btn:SetWide(btn_w)
    --btn:SetText('>')
    --btn.collpased = true

    --btn.DoClick = function(self)
    --    if (self.collpased) then
    --        self:GetParent():SizeTo(self:GetParent().w, h, 0.2)
    --        self:SetText('>')
    --        self.collpased = false
    --    else
    --        self:GetParent():SizeTo(btn_w, h, 0.2)
    --        self:SetText('<')
    --        self.collpased = true
    --    end
    --end

    self.btn = btn
end

--[[
]]
function FRAME:Init()
    self:SetSize(ScrW()/8, ScrH()/6)
    self:SetPos(0, scrh * 3/4)
    self:Build()

    self.w = self:GetWide()

    self:SetWide(20)
    self.collpased = true
end

vgui.Register("QGroup_cmenu_frame", FRAME, "DFrame")
