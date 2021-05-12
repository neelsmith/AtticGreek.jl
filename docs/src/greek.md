# The `GreekOrthography` interface

`AtticGreek` also implements the features of the abstract `GreekOrthography` interface.

## Sorting strings

- sort strings (`sortWords`)


## Syllabification

- syllabification (`syllabify`)


## Accentuation

Remove accents from a string:

```@example greek
using AtticGreek
rmaccents("βολêς", atticGreek())
```   
```@example greek
rmaccents("άνθροπος", atticGreek())
```

Add accents to a word:

- accentuation (add `accentword`)

