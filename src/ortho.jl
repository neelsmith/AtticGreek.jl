"An orthographic system for texts in the pre-Euclidean Attic alphabet."
struct AtticOrthography <: OrthographicSystem
    codepoints
    tokencategories
    tokenizer
end


"""
Instantiate an AtticOrthography with correct code points and token types.

$(SIGNATURES)
"""
function atticGreek()
    cps = alphabetic() * " \t\n"
    ttypes = [
        Orthography.LexicalToken,
        Orthography.PunctuationToken
    ]
    AtticOrthography(cps, ttypes, tokenizeAtticGreek)
end

"""Tokenize a string in the Attic Greek alphabet.

$(SIGNATURES)
"""
function tokenizeAtticGreek(s::AbstractString)
end


"""Compose a string with all alphabetic characters.


$(SIGNATURES)
"""
function alphabetic()
    "LISTEMHERE"
end

"""Compose a string with all alphabetic characters.

"""
function punctuation()
    ".,;:"
end



"""
True if all characters in s are alphabetic.

$(SIGNATURES)    
"""
function isAlphabetic(s::AbstractString)
    chlist = split(s,"")
    alphas = alphabetic()
    tfs = []
    for i in collect(eachindex(s)) 
        push!(tfs, occursin(s[i], alphas))
    end
    tfs = map(c -> occursin(c, alphas), chlist)
    nogood = false in tfs
   
    !nogood
end

"""
True if all characters in s are puncutation.
   
$(SIGNATURES)      
"""
function isPunctuation(s::AbstractString)
    chlist = split(s,"")
    puncts = punctuation()
    tfs = map(c -> occursin(c, puncts), chlist)
    nogood = false in tfs
   
    !nogood
end

