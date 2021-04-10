# functions for simple characters wtihout breathings.
# Used by Kanones parser.

"""Consonants in `AtticOrthography`.

$(SIGNATURES)
"""
function atticconsonants()
    "βγδζθκλμνπρστφχς"
end


"""Simple vowels in `AtticOrthography`.

$(SIGNATURES)

This does not include codepoints for vowels combined with accents.
It does include codepoints for vowels combined with smooth breathing.        
"""
function atticvowels()
    nfkc("αἀεἐιἰοὀυὐ")
end
