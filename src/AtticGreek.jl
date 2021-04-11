module AtticGreek

using Orthography
import Orthography: codepoints
import Orthography: tokentypes

using PolytonicGreek
import PolytonicGreek: vowels
import PolytonicGreek: consonants

using Documenter, DocStringExtensions

export AtticOrthography
export atticGreek, vowels, consonants
export tokenizeAtticGreek

include("ortho.jl")
include("simplecategories.jl")

end # module
