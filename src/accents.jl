"""Implement GreekOrthography's rmaccents function for LiteraryGreekOrthography.

    $(SIGNATURES)
    """
    function rmaccents(s::AbstractString, ortho::AtticOrthography)
        stripped = []
        dict = accentstripdict(ortho)
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

    """
    Add an acute accent to a single vowel or diphthong.
    
    $(SIGNATURES)
 
    """
    function addacute(vowel::AbstractString, ortho::AtticOrthography)
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

    """
    Add a circumflex accent to a single vowel or diphthong
    
    $(SIGNATURES)
    """
    function addcircumflex(vowel::AbstractString, ortho::AtticOrthography)
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




"""
Convert grave accent to acute.   

$(SIGNATURES)
"""
function flipaccent(s, ag::AtticOrthography)
    bare = PolytonicGreek.stripquant(s)
    dict = AtticGreek.flipdict(ag)
    modified = []
    for c in nfkc(bare)
        if string(c) in keys(dict)
            flipped = dict[string(c)]
            push!(modified, flipped)
        else
            push!(modified, string(c)) 
        end
    end
    accented = join(modified,"")
    if occursin("_", s)
        string(accented, "_")
    else
        accented
    end
end 



"""
Remove all consonants from `s`.

$(SIGNATURES)
```
"""
function vowelsonly(s::AbstractString, ag::AtticOrthography)
    re = Regex("[$ATTIC_CONSONANTS]")
    replace(s, re => "")
end


"""Counts number of accents in `s`.

$(SIGNATURES)
"""
function countaccents(s::AbstractString, ortho::AtticOrthography )
    normed = Unicode.normalize(s, :NFKC)
    accents = 0
    repertoire = allaccents(ortho)
    for c in normed
        if string(c) in repertoire
            accents = accents + 1
        end
    end
    accents
end



"""Remove any second accent due to enclisis from `s`.

$(SIGNATURES)
"""
function stripenclitic(s::AbstractString, ortho::AtticOrthography)
    normed = Unicode.normalize(s, :NFKC)
    dict = accentstripdict(ortho)
    seen = 0
    repertoire = allaccents(ortho)
    modified = []
    for c in normed
        if string(c) in repertoire
            seen = seen + 1
            if seen == 2
                push!(modified, dict[c])
            elseif seen > 2
                @warn("stripenclitic: too many accents in $s")
                return nothing
            else
                push!(modified, c)
            end
        else
            push!(modified, c)
        end
    end
    join(modified,"")
end

"""Normalize `s` to a standard form with no enclitics, and all barytone accent converted to oxytone.

$(SIGNATURES)
"""
function tokenform(s::AbstractString, ortho::AtticOrthography)
    stripped = stripenclitic(s, ortho) 
    flipaccent(stripped, ortho)
end



"""
Add specified accent to a single syllable.  

$(SIGNATURES)

# Parameters

- `syll` is a string value for a single syllable.
- `accent` is either `:ACUTE` or `:CIRCUMFLEX`.  The function returns `nothing` for any other symbol for accent.

"""
function accentsyllable(syll::AbstractString, accent::Symbol, ortho::AtticOrthography)
    # Check that syll is only one syllable
    sylls = syllabify(syll, ortho)
    if length(sylls) > 1
        @warn("accentsyllable: string $syll is more than one syllable.")
        nothing
    else
        vowels = vowelsonly(syll, ortho)
        barevowels = PolytonicGreek.stripquant(vowels)

        if accent == :ACUTE
            accentedvowel = addacute(barevowels, ortho)
            if occursin("_", vowels)
                rplcmnt = string(accentedvowel,"_")
                replace(syll, string(barevowels,"_") => rplcmnt)
            else 
                replace(syll, barevowels => accentedvowel)
            end

            # modify this to allow for long vowel marked with macron as first
            # vowel of a diphthong (including iota "subscript")
        elseif accent == :CIRCUMFLEX
            if vowels == "ε_ι"
                replace(syll,    "ε_ι" =>    "ê_ι")
            elseif vowels == "ο_ι"
                replace(syll, "ο_ι" =>  "ô_ι")
            else
                accentedvowel = addcircumflex(barevowels, ortho)
                if occursin("_", vowels)
                    rplcmnt = string(accentedvowel,"_")
                    replace(syll, string(barevowels,"_") => rplcmnt)
                else 
                    replace(syll, barevowels => accentedvowel)
                end
            end

        else
            @warn("accentsyllable: value of accent was neither :ACUTE nor :CIRCUMFLEX.")
        end
    end
end

"""True if `syll` is a long syllable in Attic Greek orthography.

$(SIGNATURES)

# Arguments

- `syll` is a single syllable
- `ortho` an instance of `AtticOrthography`
"""
function longsyllable(syll::AbstractString, ortho::AtticOrthography)
    # Sanity check:
    sylls = syllabify(syll, ortho)
    
    if (length(sylls) > 1)
        @warn("longsyllable: string $syll includes more than syllable.")
        nothing
    else
        if vowelsonly(syll, ortho) in  ATTIC_CIRCUMFLEXES
            true
        else
            noaccs = rmaccents(syll, ortho) 
            vowels = vowelsonly(noaccs, ortho)
            diphlist = split(ATTIC_DIPHTHONGS, "|") 
            vowels in diphlist || vowels in longbynature(ortho) 
        end
    end
end

"""True if `syll` counts as long for accent in ultima.

$(SIGNATURES)
"""
function finallong(syll::AbstractString, ortho::AtticOrthography)
    # Sanity check:
    sylls = syllabify(syll, ortho)
    
    if (length(sylls) > 1)
        @warn("finallong: string $syll includes more than syllable.")
        nothing

    elseif endswith(syll, "οι") || endswith(syll, "αι")
        false
    else
        vowels = vowelsonly(syll, ortho)
        diphlist = split(ATTIC_DIPHTHONGS, "|") 
        vowels in diphlist || vowels in longbynature(ortho)
    end
end


"""
True if `syll` counts as short for accent in ultima.

$(SIGNATURES)
"""
function finalshort(syll::AbstractString, ortho::AtticOrthography)
    ! finallong(syll, ortho)
end

"""Place specified accent on penult of `wrd`.

$(SIGNATURES)

`accent` is one of either `:ACUTE` or `:CIRCUMFLEX`.  The function returns `nothing` for any other symbol for accent.
"""
function accentpenult(wrd::AbstractString, accent::Symbol, ortho::AtticOrthography)
    sylls = syllabify(wrd, ortho)
    if length(sylls) < 2
        @warn("accentpenult: can't accent word with fewer than two syllables $wrd")
        nothing
    else
        sylls[end - 1] = accentsyllable(penult(wrd, ortho), accent, ortho)
        join(sylls,"")
    end
end


"""Place specified accent on final syllable of `wrd`.

$(SIGNATURES)

`accent` is one of either `:ACUTE` or `:CIRCUMFLEX`.  The function returns `nothing` for any other symbol for accent.
"""
function accentultima(wrd::AbstractString, accent::Symbol, ortho::AtticOrthography)
    sylls = syllabify(wrd, ortho)
    sylls[end] = accentsyllable(ultima(wrd, ortho), accent, ortho)
    join(sylls,"")
end


"""Accent `wrd` proparoxytone.

$(SIGNATURES)
"""
function accentantepenult(wrd::AbstractString, ortho::AtticOrthography)
    sylls = syllabify(wrd, ortho)
    if length(sylls) < 3
        @warn("accentantepenult: can't accent word with fewer than three syllables $wrd")
        nothing
    else
        sylls[end - 2] =  accentsyllable(antepenult(wrd, ortho), :ACUTE, ortho)
        join(sylls,"")
    end
end


"""
Accent word according to specified system of accent placement.

$(SIGNATURES)

# Parameters

- `wrd` is a string value representing a single lexical token.
- `placement` is one of `:RECESSIVE` for recessive accent 
or `:PENULT` for persistent accent on the penultimate syllable.

Note that it is not possible to accent the ultima correctly without
additional morphological information beyond the string value of the token.
"""
function  accentword(wrd::AbstractString, placement::Symbol, ortho::AtticOrthography)
    sylls = syllabify(wrd, ortho)
    ult = ultima(wrd, ortho)
    if placement == :PENULT    
        if length(sylls) < 2
            @warn("accentword: cannot accent $wrd on penult since it does not have two syllables.")
            nothing
        else
            pnlt = penult(wrd, ortho)
            if longsyllable(pnlt, ortho) && finalshort(ult, ortho)
                accentpenult(wrd, :CIRCUMFLEX, ortho)
            else
                accentpenult(wrd, :ACUTE, ortho)
            end
        end
         
    elseif placement == :RECESSIVE
        if length(sylls) < 2
            @warn("accentword: string $wrd has fewer than 2 syllables.")
            nothing
        else
            if length(sylls) == 2
                accentword(wrd, :PENULT, ortho)

            elseif finallong(ult, ortho)
                accentpenult(wrd, :ACUTE, ortho)

            else
                accentantepenult(wrd, ortho)
            end
        end
     
    else
        @warn("accentword: value of placement was neither :PENULT nor :RECESSIVE.")
    end
end
