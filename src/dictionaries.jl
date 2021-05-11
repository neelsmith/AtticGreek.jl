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


function acutedict(ortho::AtticOrthography) 
    Dict(
        [
            "α" => "ά",
            "ε" => "έ",
            "ι" => "ί",
            "ο" => "ό",
            "υ" => "ύ",
       
            # diaereses
            "ϊ" => "ΐ",
            "ϋ" => "ΰ",
    
            # diphthongs
            "αι" => "αί",
            "ει" => "εί",
            "οι" => "οί",
            "υι" => "υί",
            "αυ" => "αύ",
            "ευ" => "εύ",
            "ου" => "ού",
        ]
    )
end


function circumflexdict(ortho::AtticOrthography)
    Dict(
        [
            "α" => "ᾶ",
            "ε" => "ê",
            "ο" => "ô",
            "ι" => "ῖ",
            "υ" => "ῦ",
    
            # diaereses
            "ϊ" => "ῗ",
            "ϋ" => "ῧ",
    
            # diphthongs
            "αι" => "αῖ",
            "ει" => "εῖ",
            "οι" => "οῖ",
            "υι" => "υῖ",
            "αυ" => "αῦ",
            "ευ" => "εῦ",
            "ου" => "οῦ",
    
        ]
    )
end


function flipdict(ortho::AtticOrthography)
    Dict(
        [
            "ὰ" => "ά" ,
            "ὲ" => "έ" ,
            "ὶ" => "ί" ,
            "ὸ" => "ό" ,
            "ὺ" => "ύ" ,
 
            
            
            # diaereses
            "ῒ" => "ΐ" ,
            "ῢ" => "ΰ" ,
        ]
    )
end



function allaccents(ortho::AtticOrthography)
    acutes = acutedict(ortho) |> values |> collect
    circumflexes = circumflexdict(ortho) |> values |> collect
    graves = flipdict(ortho) |> values |> collect
    vcat(acutes, circumflexes, graves)
end