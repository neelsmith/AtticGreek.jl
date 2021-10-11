
@testset "Test generating alphabetic characters" begin
    alphas = AtticGreek.alphabetic()
    expected = nfkc("αβγδεζθικλμνοπρστυφχςάέίόύὰὲὶὸὺᾶêῖôῦh")
    @test alphas == expected
end

@testset "Test generating puncutation characters" begin
    puncts = AtticGreek.punctuation()
    @test puncts == ".,;:"
end

@testset "Test recognizing alphabetic tokens" begin
    @test AtticGreek.isAlphabetic("hο")
    @test AtticGreek.isAlphabetic("δêμος")
end

@testset "Test recognizing punctuation tokens" begin
    @test AtticGreek.isPunctuation(":")
end

@testset "Test creating token from string value" begin
    t = AtticGreek.tokenforstring("δêμος")
    @test typeof(t.tokencategory) == Orthography.LexicalToken
    @test t.text == "δêμος"
    
end


@testset "Test splitting punctuation from alphabetic" begin
    split = AtticGreek.splitPunctuation("δêμος:")
    @test length(split) == 2
    @test split[1] == "δêμος"
    @test split[2] == ":"
end


@testset "Test tokenizing Attic Greek" begin
    tokens = AtticGreek.tokenize("hο δêμος:", atticGreek())
    @test length(tokens) == 3
    @test tokens[1].text == "hο"
    @test tokens[end].text == ":"
end

@testset "Test simple classification functions" begin
    attic = atticGreek()
    @test occursin("α", vowels(attic))
    @test occursin(nfkc("ἀ"), vowels(attic))
    @test occursin("β", vowels(attic)) == false

    @test occursin("β", consonants(attic))
    @test occursin("α", consonants(attic)) == false
end

@testset "Test sorting words" begin
    ag = atticGreek()
    kleinias = " θεοί: έδοχσεν τêι βολêι καὶ τô δέμοι: οινεὶς επρυτάνευε, σπουδίας εγραμμάτευε επεστάτε, κλενίας εῖπε: τὲμ βολὲν καὶ τὸς άρχοντας εν τêσι πόλεσι καὶ τὸς επισκόπος επιμέλεσθαι hόπος ὰν χσυλλέγεται hο φόρος κατὰ τὸ έτος hέκαστον καὶ απάγεται αθέναζε: χσύμβολα δὲ ποιέσασθαι πρὸς τὰς πόλες, hόπος ὰμ μὲ εχσêι αδικêν τοῖς απάγοσι τὸμ φόρον: γράφσασα δὲ hε πόλις ες γραμματεῖον τὸμ φόρον, hόντιν' ὰν αποπέμπει, σεμεναμένε τôι συμβόλοι αποπεμπέτο αθέναζε: "
    nopunct = replace(kleinias, r"[,:]" => "")
    wordlist = split(nopunct) |> unique
    expected = ["αδικêν", "αθέναζε", "ὰμ", "ὰν", "απάγεται", "απάγοσι", "αποπέμπει", "αποπεμπέτο", "άρχοντας", "βολêι", "βολὲν", "γραμματεῖον", "γράφσασα", "δὲ", "δέμοι", "hε", "εγραμμάτευε", "έδοχσεν", "εῖπε", "hέκαστον", "εν", "επεστάτε", "επιμέλεσθαι", "επισκόπος", "επρυτάνευε", "ες", "έτος", "εχσêι", "θεοί", "καὶ", "κατὰ", "κλενίας", "μὲ", "hο", "οινεὶς", "hόντιν'", "hόπος", "ποιέσασθαι", "πόλες", "πόλεσι", "πόλις", "πρὸς", "σεμεναμένε", "σπουδίας", "συμβόλοι", "τὰς", "τêι", "τὲμ", "τêσι", "τô", "τὸ", "τôι", "τοῖς", "τὸμ", "τὸς", "φόρον", "φόρος", "χσυλλέγεται", "χσύμβολα"]
    @test AtticGreek.sortWords(wordlist, ag) == expected
    println(AtticGreek.sortWords(wordlist,ag))
end