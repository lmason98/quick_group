Rust Groups
===========

- [Description](#desc)
- [Console Commands](#console)
- [Player Methods](#player)

## Desc:
Adds rust like groups to gmod.

### Console Commands:
- "CreateRustGroup" - (SERVER), Creates a new rust group.
- "LeaveRustGroup" - (SERVER), Leaves a rust group.
- "PrintRustGroups" - (SERVER/ADMIN ONLY), Prints out the existing rust groups to the console.

### Player Methods:
- PLAYER:CreateRustGroup() - (SERVER), Creates a new rust group setting PLAYER as the leader.
- PLAYER:JoinRustGroup(groupIndex) - (SERVER), PLAYER joins a rust group with the given group index.
- PLAYER:LeaveRustGroup() - (SERVER), Leaves the rust group with PLAYER is in.
- PLAYER:GetRustGroup() - (SERVER), returns the current rust group the player is in.
- PLAYER:InRustGroup() - (SERVER), returns a bool whether or not the PLAYER is in a group.
- PLAYER:LeadingRustGroup() - (SERVER), returns a bool whether or not the PLAYER is leading a group.
