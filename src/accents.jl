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


    function addacute(vowel::AbstractString; ortho::AtticOrthography)
        bare = PolytonicGreek.stripquant(vowel)
        dict = acutedict(ortho)
        if bare in keys(dict)
            accented = dict[bare]
            if occursin("_", vowel)
                string(accented,"_")
            else
                accented
            end
        else
            @warn("addacute: can't add acute accent to string $vowel")
            nothing
        end
    end


    function addcircumflex(vowel::AbstractString; ortho::AtticOrthography)
        bare = PolytonicGreek.stripquant(vowel)
        dict = circumflexdict(ortho) 
        if bare in keys(dict)
            accented = dict[bare]
            if occursin("_", vowel)
                string(accented,"_")
            else
                accented
            end
        else
            @warn("addcircumflex: can't add circumflex accent to string $vowel")
            nothing
        end
    end





"""Return ultima.

$(SIGNATURES)
"""
function ultima(s, ag::AtticOrthography)
    
    sylls = syllabify(s, ag)
    if isempty(sylls)
        @warn("ultima: no syllables in string $s")
        nothing
    else
        sylls[end]
    end
end


"""Return penult.

$(SIGNATURES)
"""
function penult(s, ag::AtticOrthography)
    sylls = syllabify(s, ag)
    if length(sylls) < 2
        @warn("penult: cannot extract penult from word with < 2 syllables: $s")
        nothing
    else
        sylls[end - 1]
    end
end

"""Return antepenult.

$(SIGNATURES)

NB: Rms accent since they're not relevant to syllables.
"""
function antepenult(s, ag::AtticOrthography)
    sylls = syllabify(s, ag)
    if length(sylls) < 3
        @warn("penult: cannot extract antepenult from word with < 3 syllables: $s")
        nothing
    else
        sylls[end - 2]
    end
end

