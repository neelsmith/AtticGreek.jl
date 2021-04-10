
@testset "Test creating AtticGreek structure" begin
    
end

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
    tokens = AtticGreek.tokenizeAtticGreek("hο δêμος:")
    @test length(tokens) == 3
    @test tokens[1].text == "hο"
    @test tokens[end].text == ":"
end

@testset "Test simple classification functions" begin
    attic = atticGreek()
    @test occursin("α", attic.vowels())
    @test occursin(nfkc("ἀ"), attic.vowels())
    @test occursin("β", attic.vowels()) == false

    @test occursin("β", attic.consonants())
    @test occursin("α", attic.consonants()) == false

end