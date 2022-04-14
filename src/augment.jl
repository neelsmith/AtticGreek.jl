
"""Add temporal augment to diphthong `d`.
$(SIGNATURES)
"""
function augmentdiphthong(d)
    dict = Dict(
        nfkc("ει") => nfkc("ε_ι"),
        nfkc("hει") => nfkc("hε_ι"),

        nfkc("οι") => nfkc("ο_ι"),
        nfkc("hοι") => nfkc("hο_ι"),

        nfkc("αι") => nfkc("ε_ι"),
        nfkc("hαι") => nfkc("hε_ι"),

        nfkc("αυ") => nfkc("ε_υ"),
        nfkc("hαυ") => nfkc("hε_υ"),

        nfkc("ευ") => nfkc("ε_υ"),
        nfkc("hευ") => nfkc("hε_υ"),

        "ρ" => "ερρ"
    )
    augmented = d
    for k in keys(dict)
        re = Regex("^$(k)")
        augmented = replace(augmented, re => dict[k])
    end
    augmented
end


"""Add temporal augment to vowel `v`.
$(SIGNATURES)
"""
function augmentvowel(v)
    augmentdict = Dict(
        nfkc("α") => nfkc("ε_"),
        nfkc("hα") => nfkc("hε_"),

        nfkc("ε") => nfkc("ε_"),
        nfkc("hε") => nfkc("hε_"),
     
        nfkc("ο") => nfkc("ο_"),
        nfkc("hο") => nfkc("hο_"),

        nfkc("ι") => nfkc("ι_"),
        nfkc("hι") => nfkc("hι_"),

        nfkc("υ") => nfkc("υ_"),
        nfkc("hυ") => nfkc("hυ_"),

    )
    
    if startswith(v, "hι_") || startswith(v, "ι_") || startswith(v, "hυ_") || startswith(v, "υ_")
        s
        
    else 
        augmented = v
        for k in keys(augmentdict)
            re = Regex("^$(k)")
            augmented = replace(augmented, re => augmentdict[k])
        end
        augmented
    end
end


"""Implementatiοn of GreekOrthography's `augment` function for literary Greek.

$(SIGNATURES)    

NB: `augment` removes all accents  from the resulting string.


# Parameters

- `ortho` An instance of an `AtticOrthography`
- `s` An optional string to augment.  If is not included, the function returns
a default augment string for syllabic augment (i.e., a string that can be applied to verb forms starting with a consonant).
"""
function augment(ortho::AtticOrthography; s = nothing)
    if isnothing(s)
        nfkc("ε")

    else
        normalized = nfkc(s) |> rmaccents
        diphthongs = augmentdiphthong(normalized)
        if diphthongs != normalized
            @debug "Normalized diphthong changed to $normalized"
            normalized = diphthongs

        else  # not a diphthong, try vowel/breathing:
            #@info "$normalized not a diphthong"
            augmentedvowel = augmentvowel(normalized)   
            if augmentedvowel != normalized
                #@info "Normalized vowel changed to $augmentedvowel"
                normalized = augmentedvowel

            elseif normalized[1] in AtticGreek.ATTIC_CONSONANTS
                 # consonant
                codepts =  graphemes(normalized) |> collect
                normalized =  string("ε", join(codepts, "")) |> nfkc            
            end
        end
        normalized
    end
end



"""Identify string to use for syllabic augment in word-initial position.
$(SIGNATURES)
"""
function augment_initial(ortho::AtticOrthography)
    "ε"
end

"""Identify string to use for syllabic augment in compound verb.
$(SIGNATURES)
"""
function augment_medial(ortho::AtticOrthography)
    "ε"
end
