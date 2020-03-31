local vars = {}
vars.x = cvars.Number("qgroup_hud_pos_x", 0)
vars.y = cvars.Number("qgroup_hud_pos_y", 0)
vars.btext = cvars.Number("qgroup_hud_text_bold", 0)
vars.stext = cvars.Number("qgroup_hud_text_size", 0)
vars.hp_h = cvars.Number("qgroup_hud_hp_h", 0)
vars.hp_w = cvars.Number("qgroup_hud_hp_w", 0)

--[[
    Args: String var, String cvar
    Desc: Updates the global vars here so effects take instantly when a console var is changed
]]
function Qgroup.UpdateCVar(var, cvar)
    vars[var] = cvars.Number(cvar, 0) end

--[[
]]
local function drawMember(name, x, y, font)
    draw.SimpleText(name, font, x + Qgroup.config.theme.pad*2, y, Color(255,255,255,255))

    draw.RoundedBox(vars.hp_h/2, x, vars.y + vars.stext, vars.hp_w, vars.hp_h, Color(120, 255, 120, 255))
end

--[[
    Args: Number x, y, num_cols
    Desc: 
]]
function Qgroup.DrawGroup()
    local font = "qgroup_".. vars.stext
    if (vars.btext) then
        font = font ..'b' end

    for i, ply in pairs(Qgroup.members) do
        drawMember(ply:Nick(), vars.x, vars.y, font)
    end
end
