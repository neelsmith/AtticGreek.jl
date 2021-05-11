
const ATTIC_CONSONANTS =  "βγδζθκλμνπρστφχς"

#const ATTIC_SIMPLEVOWELS =  "αειου"
const ATTIC_SIMPLEVOWELS =  "α|α_|ε|ε_|ι|ι_|ο|ο_|υ|υ_"
const ATTIC_VOWELS = "$(ATTIC_SIMPLEVOWELS)$(PolytonicGreek.LG_DIAERESES)"
const ATTIC_DIPHTHONGS = "αι|ει|οι|υι|αυ|ευ|ου|υἰ|αἰ|εἰ|οἰ|αὐ|εὐ|οὐ|υἰ|αἱ|εἱ|οἱ|αὑ|εὑ|οὑ |υἱ"  



function longbynature(ortho::AtticOrthography) 
    macra = []
    for c in ATTIC_SIMPLEVOWELS
        push!(macra,string(c,"_"))
    end
    macra
end