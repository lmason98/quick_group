EASYGROUP.group_table = {}

local Group = EASYGROUP.Group()
EASYGROUP._DBUG("Group =")
PrintTable(Group)
local id = table.insert(EASYGROUP.group_table, Group)
Group.id = id
EASYGROUP._DBUG("EASYGROUP.group_table[1].id = ".. EASYGROUP.group_table[1].id)

print(" [+] Hello from server main.lua!")
