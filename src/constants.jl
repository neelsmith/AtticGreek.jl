const ATTIC_CONSONANTS =  "βγδζθκλμνπρστφχς"
const ATTIC_SIMPLEVOWELS =  "αειου"
const ATTIC_CIRCUMFLEXES = [PolytonicGreek.nfkc("ᾶ"), PolytonicGreek.nfkc("ê"), PolytonicGreek.nfkc("ῖ"), 
PolytonicGreek.nfkc("ô"), PolytonicGreek.nfkc("ῦ"), PolytonicGreek.nfkc("ῗ"),  PolytonicGreek.nfkc("ῧ")]


function longbynature(ortho::AtticOrthography) 
    naturallylong = ATTIC_CIRCUMFLEXES
    for c in ATTIC_SIMPLEVOWELS
        push!(naturallylong,string(c,"_"))
    end
    naturallylong
end

function longbynature_str(ortho::AtticOrthography) 
    lbn = longbynature(ortho)
    join(lbn, "")
end


const ATTIC_VOWELS = "$(ATTIC_SIMPLEVOWELS)$(PolytonicGreek.LG_DIAERESES)$(longbynature_str(atticGreek()))"
const ATTIC_DIPHTHONGS = "αι|ει|οι|υι|αυ|ευ|ου|α_ι|ε_ι|ο_ι|ε_υ"


#const ATTIC_SIMPLEVOWELS =  "α|α_|ε|ε_|ι|ι_|ο|ο_|υ|υ_"
function vowels_re()
    simple = join(split(ATTIC_SIMPLEVOWELS, ""), "|")
    diaereses = join(split(PolytonicGreek.LG_DIAERESES, ""), "|")
    ag = atticGreek()
    longs = join(longbynature(ag), "|")
    join([simple, diaereses, longs], "|")
end
