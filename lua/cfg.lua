Qgroup.config = {}

-- interaction distance (max distance at which a player could invite another into a group)
Qgroup.config.interact_dist = 20000 -- This is a large number which allows me to use a more effecient
                                    -- function call (rather than a small number requiring to use a
                                    -- less effecient function)

-- client vgui theme
Qgroup.config.theme = {}
Qgroup.config.theme.enabled          = true
Qgroup.config.theme.outline_col      = Color(0,0,0,255)
Qgroup.config.theme.background_col   = Color(30,30,30,255)
Qgroup.config.theme.main_col         = Color(37,37,37,255)
Qgroup.config.theme.btn_col          = Color(25,25,25,255)
Qgroup.config.theme.btndown_col      = Color(65,65,65,255)
Qgroup.config.theme.focused_col      = Color(51,51,51,255)
Qgroup.config.theme.text_col         = Color(173,173,173,255)
Qgroup.config.theme.textselected_col = Color(201,212,201,255)
