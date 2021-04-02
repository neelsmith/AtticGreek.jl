# User's guide

Create an `AtticOrthography`:
```@example attic
using AtticGreek, Orthography
attic = atticGreek()
typeof(attic)
```

It inherits from `OrthographicSystem`:

```@example attic
typeof(attic) |> supertype
```

So we can validate strings:

```@example attic
s = nfkc("έδοχσεν τôι δέμοι")
validstring(attic, s)
```
```@example attic
validstring(attic, "μῆνιν")
```
And tokenize strings:
```@example attic
tokens = Orthography.tokenize(attic, s)
length(tokens)
```
```@example attic
tokens[1].tokencategory
```
```@example attic
tokens[1].text
```



