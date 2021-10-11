
@testset "Test interface of OrthographicSystem" begin
    attic = atticGreek()
    @test typeof(attic) == AtticOrthography
    inherited = typeof(attic) |> supertype
    @test inherited == PolytonicGreek.GreekOrthography
    
    s = nfkc("έδοχσεν τôι δέμοι")
    @test validstring(s, attic)

    tokens = tokenize(s, attic)
    @test length(tokens) == 3
    @test tokens[1].tokencategory == LexicalToken()
    @test tokens[1].text == nfkc("έδοχσεν")

end