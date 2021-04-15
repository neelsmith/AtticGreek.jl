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

include("ortho.jl")
include("dictionaries.jl")
include("accents.jl")
include("simplecategories.jl")

end # module
