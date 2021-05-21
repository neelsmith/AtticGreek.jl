
function augmentdiphthong(s)
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
    augmented = s
    for k in keys(dict)
        re = Regex("^$(k)")
        augmented = replace(augmented, re => dict[k])
    end
    augmented
end

function augmentvowel(s)
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
    
    if startswith(s, "ἱ_") || startswith(s, "ἰ_") || startswith(s, "ὑ_") || startswith(s, "ὐ_")
        s
        
    else 
        augmented = s
        for k in keys(augmentdict)
            re = Regex("^$(k)")
            augmented = replace(augmented, re => augmentdict[k])
        end
        augmented
    end
end

function augment(ortho::AtticOrthography; s = nothing)
    if isnothing(s)
        nfkc("ε")

    else
        normalized = nfkc(s) |> rmaccents
        diphthongs = augmentdiphthong(normalized)
        if diphthongs != normalized
            #@info "Normalized diphthong changed to $normalized"
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