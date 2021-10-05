var documenterSearchIndex = {"docs":
[{"location":"guide/#User's-guide","page":"User's guide","title":"User's guide","text":"","category":"section"},{"location":"guide/","page":"User's guide","title":"User's guide","text":"Create an AtticOrthography:","category":"page"},{"location":"guide/","page":"User's guide","title":"User's guide","text":"using AtticGreek, Orthography\nattic = atticGreek()\ntypeof(attic)","category":"page"},{"location":"guide/","page":"User's guide","title":"User's guide","text":"It inherits from OrthographicSystem:","category":"page"},{"location":"guide/","page":"User's guide","title":"User's guide","text":"typeof(attic) |> supertype","category":"page"},{"location":"guide/","page":"User's guide","title":"User's guide","text":"So we can validate strings:","category":"page"},{"location":"guide/","page":"User's guide","title":"User's guide","text":"s = nfkc(\"έδοχσεν τôι δέμοι\")\nvalidstring(attic, s)","category":"page"},{"location":"guide/","page":"User's guide","title":"User's guide","text":"validstring(attic, \"μῆνιν\")","category":"page"},{"location":"guide/","page":"User's guide","title":"User's guide","text":"And tokenize strings:","category":"page"},{"location":"guide/","page":"User's guide","title":"User's guide","text":"tokens = Orthography.tokenize(attic, s)\nlength(tokens)","category":"page"},{"location":"guide/","page":"User's guide","title":"User's guide","text":"tokens[1].tokencategory","category":"page"},{"location":"guide/","page":"User's guide","title":"User's guide","text":"tokens[1].text","category":"page"},{"location":"api/#API-documentation","page":"API documentation","title":"API documentation","text":"","category":"section"},{"location":"api/#Public-APIs","page":"API documentation","title":"Public APIs","text":"","category":"section"},{"location":"api/","page":"API documentation","title":"API documentation","text":"AtticOrthography\natticGreek\ntokenizeAtticGreek\nconsonants\nvowels\nrmaccents","category":"page"},{"location":"api/#AtticGreek.AtticOrthography","page":"API documentation","title":"AtticGreek.AtticOrthography","text":"An orthographic system for texts in the pre-Euclidean Attic alphabet.\n\n\n\n\n\n","category":"type"},{"location":"api/#AtticGreek.atticGreek","page":"API documentation","title":"AtticGreek.atticGreek","text":"Instantiate an AtticOrthography with correct code points and token types.\n\natticGreek()\n\n\n\n\n\n\n","category":"function"},{"location":"api/#AtticGreek.tokenizeAtticGreek","page":"API documentation","title":"AtticGreek.tokenizeAtticGreek","text":"Tokenize a string in the Attic Greek alphabet.\n\ntokenizeAtticGreek(s)\n\n\n\n\n\n\n","category":"function"},{"location":"api/#PolytonicGreek.consonants","page":"API documentation","title":"PolytonicGreek.consonants","text":"Identify code points representing consonants.\n\nconsonants(ortho)\n\n\n\n\n\n\nImplement consonants function of GreekOrthography interface.\n\nconsonants(ortho)\n\n\n\n\n\n\nImplement GreekOrthography's consonants function for AtticOrthography.\n\nconsonants(attic)\n\n\n\n\n\n\n","category":"function"},{"location":"api/#PolytonicGreek.vowels","page":"API documentation","title":"PolytonicGreek.vowels","text":"Identify code points representing simple vowels.\n\nThis does not include code points representing vowels combined  with accents. It does include any code points representing vowels plus breathing or vowels with subscript.\n\n\n\n\n\nImplement vowels function of GreekOrthography interface.\n\nvowels(ortho)\n\n\n\n\n\n\nImplement GreekOrthography's vowels function for AtticOrthography.\n\nvowels(attic)\n\n\n\n\n\n\n","category":"function"},{"location":"api/#PolytonicGreek.rmaccents","page":"API documentation","title":"PolytonicGreek.rmaccents","text":"Remove all accent characters from s.\n\nrmaccents(s, ortho)\n\n\nParameters\n\ns is a Greek string\northo is an implementation of GreekOrthography\n\n\n\n\n\nDefault to using literary Greek orthography.\n\nrmaccents(s)\n\n\n\n\n\n\nImplement GreekOrthography's rmaccents function for LiteraryGreekOrthography.\n\nrmaccents(s, ortho)\n\n\n\n\n\n\nImplement GreekOrthography's rmaccents function for LiteraryGreekOrthography.\n\nrmaccents(s, ortho)\n\n\n\n\n\n\n","category":"function"},{"location":"api/#AtticGreek-internals","page":"API documentation","title":"AtticGreek internals","text":"","category":"section"},{"location":"api/","page":"API documentation","title":"API documentation","text":"AtticGreek.accentstripdict\nAtticGreek.alphabetic\nAtticGreek.punctuation\nAtticGreek.isAlphabetic\nAtticGreek.isPunctuation\nAtticGreek.tokenforstring\nAtticGreek.splitPunctuation","category":"page"},{"location":"api/#AtticGreek.accentstripdict","page":"API documentation","title":"AtticGreek.accentstripdict","text":"Map accented vowels to unaccented forms, but keep smooth breathing\n\naccentstripdict()\n\n\n\n\n\n\n","category":"function"},{"location":"api/#AtticGreek.alphabetic","page":"API documentation","title":"AtticGreek.alphabetic","text":"Compose a string with all alphabetic characters.\n\nalphabetic()\n\n\n\n\n\n\n","category":"function"},{"location":"api/#AtticGreek.punctuation","page":"API documentation","title":"AtticGreek.punctuation","text":"Compose a string with all punctuation characters.\n\n\n\n\n\n","category":"function"},{"location":"api/#AtticGreek.isAlphabetic","page":"API documentation","title":"AtticGreek.isAlphabetic","text":"True if all characters in s are alphabetic.\n\nisAlphabetic(s)\n\n\n\n\n\n\n","category":"function"},{"location":"api/#AtticGreek.isPunctuation","page":"API documentation","title":"AtticGreek.isPunctuation","text":"True if all characters in s are puncutation.\n\nisPunctuation(s)\n\n\n\n\n\n\n","category":"function"},{"location":"api/#AtticGreek.tokenforstring","page":"API documentation","title":"AtticGreek.tokenforstring","text":"Create correct OrthographicToken for a given string.\n\ntokenforstring(s)\n\n\n\n\n\n\n","category":"function"},{"location":"api/#AtticGreek.splitPunctuation","page":"API documentation","title":"AtticGreek.splitPunctuation","text":"Split off any trailing punctuation and return an Array of leading string + trailing punctuation.\n\nsplitPunctuation(s)\n\n\n\n\n\n\n","category":"function"},{"location":"#AtticGreek","page":"Home","title":"AtticGreek","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"A rigorously defined orthography for texts in the archaic Attic alphabet.","category":"page"},{"location":"","page":"Home","title":"Home","text":"Highlights:","category":"page"},{"location":"","page":"Home","title":"Home","text":"implement the MID Orthography interface, with semantic tokenization of text in Attic Greek\nuses Unicode in form :NFKC whererever codepoints are defined\nmimics print publication practice insupplementing missing characters with the ASCII code point sumarized below.","category":"page"},{"location":"","page":"Home","title":"Home","text":"Code point Meaning\nh rough breathing\nê ε with circumflex\nô ο with circuflex","category":"page"},{"location":"","page":"Home","title":"Home","text":"note: Note\nIn the Attic alphabet, all iotas are adscript. There is no character for smooth breathing:  the aspirate (rough breathing) is explicitly marked, so that word-initial vowels are unaspirated by default.","category":"page"}]
}