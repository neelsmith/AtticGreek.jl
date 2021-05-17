
const ATTIC_CONSONANTS =  "βγδζθκλμνπρστφχς"
const ATTIC_SIMPLEVOWELS =  "αειου"


function longbynature(ortho::AtticOrthography) 
    macra = ["ê","ô"]
    for c in ATTIC_SIMPLEVOWELS
        push!(macra,string(c,"_"))
    end
    macra
end



#const ATTIC_SIMPLEVOWELS =  "α|α_|ε|ε_|ι|ι_|ο|ο_|υ|υ_"
const ATTIC_VOWELS = "$(ATTIC_SIMPLEVOWELS)$(PolytonicGreek.LG_DIAERESES)$(longbynature(atticGreek()))"
const ATTIC_DIPHTHONGS = "αι|ει|οι|υι|αυ|ευ|ου|α_ι|ε_ι|ο_ι|ε_υ"
const ATTIC_CIRCUMFLEXES = [nfkc("ᾶ"), nfkc("ê"), nfkc("ῖ"), nfkc("ô"), nfkc("ῦ"), nfkc("ῗ"),  nfkc("ῧ")]

function vowels_re()
    simple = join(split(ATTIC_SIMPLEVOWELS, ""), "|")
    diaereses = join(split(PolytonicGreek.LG_DIAERESES, ""), "|")
    longs = join(longbynature(atticGreek()), "|")
    join([simple, diaereses, longs], "|")
end
