local vars = {}
vars.x = cvars.Number("qgroup_hud_pos_x", 0)
vars.y = cvars.Number("qgroup_hud_pos_y", 0)
vars.btext = cvars.Number("qgroup_hud_text_bold", 0)
vars.stext = cvars.Number("qgroup_hud_text_size", 0)
vars.hp_w = cvars.Number("qgroup_hud_text_size", 0)

--[[
    Args: String var, String cvar
    Desc: Updates the global vars here so effects take instantly when a console var is changed
]]
function Qgroup.UpdateCVar(var, cvar)
    vars[var] = cvars.Number(cvar, 0) end

--[[
]]
local function drawMember()
end

--[[
    Args: Number x, y, num_cols
    Desc: 
]]
function Qgroup.DrawGroup()
    surface.SetDrawColor(Color(0,0,0,255))
    surface.DrawRect(vars.x, vars.y, 500, 500)
end
