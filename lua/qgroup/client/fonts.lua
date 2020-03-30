local function create_font(size, bold)
    local name = "qgroup_".. size
    local weight = 500

    if (bold) then
        weight = 800
        name = name ..'b'
    end

    surface.CreateFont(name, {
        font = "Roboto",
        size = size,
        weight = weight,
        antialias = true
    })
end

create_font(30, true)
create_font(25, true)
create_font(25, false)
create_font(18, true)
create_font(18, false)
