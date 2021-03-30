
@testset "Test creating AtticGreek structure" begin
    
end

@testset "Test generating alphabetic characters" begin
    alphas = PolytonicGreek.alphabetic()
    #expectedcount = 267
    #@test length(alphas) == expectedcount
end

@testset "Test generating puncutation characters" begin
    puncts = PolytonicGreek.punctuation()
    @test puncts == ".,;:"
end

@testset "Test recognizing alphabetic tokens" begin
    @test PolytonicGreek.isAlphabetic("hο δêμος")
end

@testset "Test recognizing punctuation tokens" begin
    @test PolytonicGreek.isPunctuation(":")
end

@testset "Test creating token from string value" begin
    t = PolytonicGreek.tokenforstring("μῆνιν")
    typeof(t.tokencategory) == Orthography.LexicalToken
    t.text == "μῆνιν"
end

@testset "Test splitting punctuation from alphabetic" begin
    split = PolytonicGreek.splitPunctuation("ἄειδε,")
    @test length(split) == 2
    @test split[1] == "ἄειδε"
    @test split[2] == ","
end

@testset "Test tokenizing Attic Greek" begin
    tokens = PolytonicGreek.tokenizeLiteraryGreek("μῆνιν ἄειδε,")
    @test length(tokens) == 3
    @test tokens[end].text == ","
end
