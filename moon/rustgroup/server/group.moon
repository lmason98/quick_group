import insert, IsEmpty, Count, remove from table

rustgroup.GetGroup = (i) ->

export class RustGroup
    -- Desc: Inits the RustGroup object
    -- Args: Player leader
    -- Return: RustGroup object 
    New: (leader) =>
        @members = {}
        @index = -1

        if leader\IsValid!
            @leader = leader 
            @index = insert rustgroup.groups, @
            @\Add leader
            @\Print!

        return @

    Remove: => remove rustgroup.groups @index

    -- Desc: Determines if the current group Is Valid
    -- Return: Bool isValid
    IsValid: => return leader\IsValid! and Count @members > 0

    -- Desc: Checks if the passed player is the leader of this group
    -- Args: Player ply
    -- Return Bool isLeader
    IsLeader: (ply) => return @leader == ply

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
    -- Args: Player toKick
    Kick: (toKick) =>
        if Count @members == 1
            @\Remove! 
        -- pass leader
        elseif Count @members > 1
            for i, ply in pairs @members
                if ply == toKick
                    remove @members, i 
                    break
            for ply in *@members    
                @leader = ply
                break

    -- Desc: Pretty prints to the console for debug purposes
    Print: =>
        print " Leader: #{@leader\GetName!}"
        print " Index: #{@index}"
        if not IsEmpty @members
            print " Members:"
            print "\t[#{i}]: #{ply\GetName!}" for i, ply in pairs @members
