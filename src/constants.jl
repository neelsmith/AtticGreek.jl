
const ATTIC_CONSONANTS =  "βγδζθκλμνπρστφχς"

#const ATTIC_SIMPLEVOWELS =  "αειου"
const ATTIC_SIMPLEVOWELS =  "α|α_|ε|ε_|ι|ι_|ο|ο_|υ|υ_"
const ATTIC_VOWELS = "$(ATTIC_SIMPLEVOWELS)$(PolytonicGreek.LG_DIAERESES)"
const ATTIC_DIPHTHONGS = "αι|ει|οι|υι|αυ|ευ|ου|α_ι|ε_ι|ο_ι|ε_υ"


function longbynature(ortho::AtticOrthography) 
    macra = []
    for c in ATTIC_SIMPLEVOWELS
        push!(macra,string(c,"_"))
    end
    macra
end