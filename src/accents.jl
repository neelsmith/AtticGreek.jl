"""Implement GreekOrthography's rmaccents function for LiteraryGreekOrthography.

    $(SIGNATURES)
    """
    function rmaccents(s::AbstractString, ortho::AtticOrthography)
        stripped = []
        dict = accentstripdict()
        for c in nfkc(s)
            #@warn "Looking at $c"
            if c in keys(dict)
                #@warn "Pushing stripped form $dict[c]"
                push!(stripped, dict[c])
            else
                #@warn "Pushing stripped form $dict[c]"
                push!(stripped,c)
            end
        end
        join(stripped,"")
    end