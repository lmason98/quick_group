-- Args: String name, Number scale, Bool bold
-- Desc: Creates a new font
createFont = (name, scale, bold) ->
    weight = 500
    name ..= '_' .. tostring scale

    if bold
        weight = 800
        name ..= 'b'

    surface.CreateFont name,
        font: "Roboto"
        size: scale
        weight: weight
        antialias: true

for i = 10, 30
    createFont "rustgroup", i, true
    createFont "rustgroup", i, false

createFont "rustgroup", 35, true
createFont "rustgroup", 35, false
