module AtticGreek

using Unicode 

using Orthography
import Orthography: codepoints
import Orthography: tokentypes

using PolytonicGreek
import PolytonicGreek: syllabify
import PolytonicGreek: accentword
import PolytonicGreek: accentultima
import PolytonicGreek: accentpenult
import PolytonicGreek: accentantepenult
import PolytonicGreek: sortWords
import PolytonicGreek: vowels
import PolytonicGreek: consonants
import PolytonicGreek: rmaccents
import PolytonicGreek: countaccents
import PolytonicGreek: augment

using Documenter, DocStringExtensions

export AtticOrthography
export atticGreek, vowels, consonants
export tokenizeAtticGreek
export sortWords


export rmaccents, countaccents
export accentword, accentultima, accentpenult, accentantepenult

export syllabify


include("ortho.jl")
include("constants.jl")
include("dictionaries.jl")
include("accents.jl")
include("syllabify.jl")
include("augment.jl")
include("simplecategories.jl")

end # module
