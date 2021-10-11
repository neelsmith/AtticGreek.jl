# API documentation


## Public API for MID Orthography model


```@docs
AtticOrthography
atticGreek
sortWords
```

## Phonology and syllabification

Exported:

```@docs
consonants
vowels
syllabify
```

Internal:

```@docs
AtticGreek.alphabetic
AtticGreek.punctuation
AtticGreek.isAlphabetic
AtticGreek.isPunctuation
AtticGreek.tokenforstring
AtticGreek.splitPunctuation
AtticGreek.ultima
AtticGreek.penult
AtticGreek.antepenult
AtticGreek.vowelsonly
AtticGreek.longsyllable
AtticGreek.finallong
AtticGreek.finalshort
```

## Accentuation 

Exported:

```@docs
rmaccents
countaccents
accentword
accentultima
accentpenult
accentantepenult
```


Internal:

```@docs
AtticGreek.stripenclitic
AtticGreek.addacute
AtticGreek.addcircumflex
AtticGreek.accentstripdict
AtticGreek.flipaccent
AtticGreek.tokenform
AtticGreek.accentsyllable
```




