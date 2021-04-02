# Run this from repository root, e.g. with
# 
#    julia --project=docs/ docs/make.jl
#
using Pkg
Pkg.activate(".")
Pkg.instantiate()

using Documenter, DocStringExtensions
using AtticGreek

makedocs(
    sitename = "AtticGreek.jl",
    pages = [
        "Home" => "index.md",
        "User's guide" => "guide.md",
        "API documentation" => "api.md"
    ]
)

deploydocs(
    repo = "github.com/neelsmith/AtticGreek.jl.git",
) 