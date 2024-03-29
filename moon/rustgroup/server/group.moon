import insert, IsEmpty, Count, remove, RemoveByValue from table

rustgroup.GetGroup = (i) ->

export class RustGroup
    -- Desc: Inits the RustGroup object
    -- Args: Player leader
    -- Return: Number index, RustGroup object 
    New: (leader) =>
        @members = {}
        @index = -1

        if leader\IsValid!
            @leader = leader 
            @index = insert rustgroup.groups, @
            @\Add leader
            @\Print!

        return @index, @

    Remove: =>
        remove rustgroup.groups, @index
        net.Start "rustgroup_group_disbanded"
        net.Send @members

    -- Desc: Determines if the current group Is Valid
    -- Return: Bool isValid
    IsValid: => return @leader\IsValid! and 0 < Count @members

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
    -- Args: Player newPly
    Add: (newPly) =>
        insert @members, newPly 

        -- send new ply to existing members
        net.Start "rustgroup_add_member"
        net.WriteEntity newPly 
        net.Send @members

    -- Desc: Kicks a player from the group
    -- Args: Player toKick
    Kick: (toKick) =>
        if 1 == Count @members
            @\Remove! 
            toKick\ChatPrint "Your group has been disbanded."
        elseif 1 < Count @members
            RemoveByValue @members, toKick
            net.Start "rustgroup_remove_member"
            net.WriteEntity toKick 
            net.Send @members

            -- assign new leader
            if toKick == @leader
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
