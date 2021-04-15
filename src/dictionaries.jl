"""Map accented vowels to unaccented forms, but keep smooth breathing

$(SIGNATURES)
"""
function accentstripdict() 
    Dict(
       'ά'  => 'α',
       'ὰ' => 'α',
       'ᾶ' => 'α',
       'ἄ' => 'ἀ',
       'ἂ' => 'ἀ',
       'ἆ' => 'ἀ',
        # epsilon

       'έ' => 'ε',
       'ὲ' => 'ε',
       'ἔ' => 'ἐ',
       'ἒ' => 'ἐ',       
        # "eta"
       'ê' => 'ε',
        
       #= iota  =#
       'ί' => 'ι',
       'ὶ' => 'ι',
       'ῖ' => 'ι',
       'ἴ' => 'ἰ',
       'ἲ' => 'ἰ',
       'ἶ' => 'ἱ',
       
       #= upsilon  =#
       'ύ' => 'υ',
       'ὺ' => 'υ',
       'ῦ' => 'υ',
       'ὔ' => 'ὐ',
       'ὒ' => 'ὐ',
       'ὖ' => 'ὐ',
      
        # omicron
       'ό' => 'ο',
       'ὸ' => 'ο',
       'ὄ' => 'ὀ',
       'ὂ' => 'ὀ',
       # "omega"
       'ô' => 'ο'
   )
end