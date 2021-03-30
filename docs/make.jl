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
       
        "API documentation" => "api.md"
    ]
)


# Add deploy later.
# When ready to deploy, add TagBot and Documentation gh actions
# to .github/workflows