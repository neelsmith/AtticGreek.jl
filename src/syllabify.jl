function splitdiphthongvowel(s)
    re = Regex("($ATTIC_DIPHTHONGS)([$ATTIC_VOWELS])")
    replace(s, re => s"\1 \2")
end

function splitvoweldiphthong(s)
    re = Regex("([$ATTIC_VOWELS])($ATTIC_DIPHTHONGS)")
    replace(s, re => s"\1 \2")
    
end



"""Split between upsilon and a following vowel other than iota.

$(SIGNATURES)

θύειν splits as "θυ ειν"
"""
function splitupsilonvowel(s)
    upsilonbreakers = "αεου"
    re = Regex("υ([$upsilonbreakers])")
    replace(s, re => s"υ \1")
end




function splitconsonantcluster(s)
    re = Regex("([$ATTIC_VOWELS])([βγδζθκπστφχ][μνβγδζθκλπρστφχ])")
    replace(s, re => s"\1 \2")
end

"""Consonant between two vowels goes with second vowel."""
function splitvcv(s)
    re = Regex("([$ATTIC_VOWELS])([$ATTIC_CONSONANTS])([$ATTIC_VOWELS])")
    replace(s, re => s"\1 \2\3")
end


function splitvowelcluster(s)
    re = Regex("([ει])([αοε])")
    replace(s, re => s"\1 \2")
end


"""
"""
function syllabify(s, ortho::AtticOrthography)
    morpheme_v =nfkc(s) |>
    rmaccents |>
    PolytonicGreek.splitmorphemes 
    @debug("syllabify: morpheme_v is $(morpheme_v)")
    map(morpheme_v) do s
        AtticGreek.rmaccents(s, atticGreek())  |>
        PolytonicGreek.splitdiaeresis |> 
        PolytonicGreek.splitmunu  |> 
        PolytonicGreek.splitliqcons |> 
        splitdiphthongvowel |> 
        splitvoweldiphthong |> 
        splitvowelcluster |> 
        splitupsilonvowel |> 
        PolytonicGreek.splitdoubleconsonants |> 
        splitconsonantcluster |>
        splitvcv |>   splitvcv |> # catch overlap
        split
    end  |> Iterators.flatten |> collect
    
    
end