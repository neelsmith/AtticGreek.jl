module AtticGreek

using Orthography
import Orthography: codepoints
import Orthography: tokentypes

using PolytonicGreek
import PolytonicGreek: vowels
import PolytonicGreek: consonants
import PolytonicGreek: rmaccents

using Documenter, DocStringExtensions

export AtticOrthography
export atticGreek, vowels, consonants
export tokenizeAtticGreek

export rmaccents
export syllabify

include("constants.jl")
include("ortho.jl")
include("dictionaries.jl")
include("accents.jl")
include("syllabify.jl")
include("simplecategories.jl")

end # module
