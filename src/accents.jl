"""Implement GreekOrthography's rmaccents function for LiteraryGreekOrthography.

    $(SIGNATURES)
    """
    function rmaccents(s::AbstractString, ortho::AtticOrthography)
        stripped = []
        dict = accentstripdict()
        for c in nfkc(s)
            if c in keys(dict)
                push!(stripped, dict[c])
            else
                push!(stripped,c)
            end
        end
        join(stripped,"")
    end