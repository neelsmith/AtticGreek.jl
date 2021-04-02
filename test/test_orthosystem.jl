
@testset "Test interface of OrthographicSystem" begin
    attic = atticGreek()
    @test typeof(attic) == AtticOrthography
    inherited = typeof(attic) |> supertype
    @test inherited == Orthography.OrthographicSystem
    
    s = nfkc("έδοχσεν τôι δέμοι")
    @test validstring(attic, s)

    tokens = Orthography.tokenize(attic, s)
    @test length(tokens) == 3
    @test tokens[1].tokencategory == LexicalToken()
    @test tokens[1].text == nfkc("έδοχσεν")

end