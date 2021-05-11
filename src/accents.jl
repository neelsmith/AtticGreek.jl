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



function vowelsonly(s::AbstractString, ag::AtticOrthography)
    re = Regex("[$ATTIC_CONSONANTS]")
    replace(s, re => "")
end



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


function tokenform(s::AbstractString, ortho::AtticOrthography)
    stripped = stripenclitic(s, ortho) 
    flipaccent(stripped, ortho)
end







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

        elseif accent == :CIRCUMFLEX
            accentedvowel = addcircumflex(barevowels, ortho)
            if occursin("_", vowels)
                rplcmnt = string(accentedvowel,"_")
                replace(syll, string(barevowels,"_") => rplcmnt)
            else 
                replace(syll, barevowels => accentedvowel)
            end

        else
            @warn("accentsyllable: value of accent was neither :ACUTE nor :CIRCUMFLEX.")
        end
    end
end


function longsyllable(syll::AbstractString, ortho::AtticOrthography)
    # Sanity check:
    sylls = syllabify(syll, ortho)
    
    if (length(sylls) > 1)
        @warn("longsyllable: string $syll includes more than syllable.")
        nothing
    else
        noaccs = rmaccents(syll, ortho) 
        vowels = vowelsonly(noaccs, ortho)
        diphlist = split(ATTIC_DIPHTHONGS, "|") 
        vowels in diphlist || vowels in longbynature(ortho)
    end
end


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


function finalshort(syll::AbstractString, ortho::AtticOrthography)
    ! finallong(syll, ortho)
end


function accentpenult(wrd::AbstractString, accent::Symbol, ortho::AtticOrthography)
    sylls = syllabify(wrd, ortho)
    if length(sylls) < 2
        @warn("accentpenult: can't accent word with fewer than two syllables $wrd")
        nothing
    else
        sylls[end - 1] = accentsyllable(penult(wrd), accent, ortho)
        join(sylls,"")
    end
end


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

            elseif finallong(ult)
                accentpenult(wrd, :ACUTE, ortho)

            else
                accentantepenult(wrd, ortho)
            end
        end
     
    else
        @warn("accentword: value of placement was neither :PENULT nor :RECESSIVE.")
    end
end
