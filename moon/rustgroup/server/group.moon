import insert, IsEmpty from table

export class RustGroup
    -- Desc: Inits the RustGroup object
    -- Args: Player leader
    -- Return: RustGroup object 
    New: (leader) =>
        @leader = leader 
        @members = {}
        @index = -1

        return @

    -- Desc: Checks if the passed player is the leader of this group
    -- Args: Player ply
    IsLeader: (ply) =>
        return @leader == ply

    -- Desc: Get/Set the group index
    -- Args: Number index 
    -- Return: Number index 
    SetIndex: (i) => @index = i
    GetIndex: => return @index

    -- Desc: Adds a player to the group
    -- Args: Player ply
    Add: (ply) =>
        insert @members, ply
        ply\JoinRustGroup @index, @\IsLeader ply

    -- Desc: Kicks a player from the group
    -- Args: Player kicker, Player kicked
    Kick: (kicker, kicked) =>
        -- pass

    -- Desc: Pretty prints to the console for debug purposes
    Print: =>
        print " Leader: #{@leader\GetName!}"
        print " Index: #{@index}"
        if not IsEmpty @members
            print " Members:"
            print "\t[#{i}]: #{ply\GetName!}" for i, ply in pairs @members
