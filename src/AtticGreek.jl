module AtticGreek

using Orthography, PolytonicGreek
using Documenter, DocStringExtensions

export AtticOrthography
export atticGreek, vowels, consonants
export tokenizeAtticGreek

include("ortho.jl")
include("simplecategories.jl")

end # module
