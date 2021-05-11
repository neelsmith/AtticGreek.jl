function splitdiphthongvowel(s)
    re = Regex("($ATTIC_DIPHTHONGS)([$ATTIC_VOWELS])")
    replace(s, re => s"\1 \2")
end


"""
"""
function syllabify(s, ortho::AtticOrthography)
    nfkc(s) |>
    AtticGreek.rmaccents  |>
    PolytonicGreek.splitmorphemeboundary |>
    PolytonicGreek.splitdiaeresis |> 
    PolytonicGreek.splitmunu  |> 
    PolytonicGreek.splitliqcons |> 
    splitdiphthongvowel |> 
    #=splitvoweldiphthong |>  
    splitshortvowelvowel |> 
    splitlongvowelvowel |> 
    splitupsilonvowel |> 
    splitdoubleconsonants |> 
    splitconsonantcluster |>
    splitvcv |>   splitvcv |> # catch overlap
    =#
    split
end