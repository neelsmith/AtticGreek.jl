@testset "Test removing accents" begin
    @test rmaccents("βολêς", atticGreek()) == nfkc("βολες")
    @test rmaccents("τôι", atticGreek()) == nfkc("τοι")
    @test rmaccents("δέμοι", atticGreek()) == nfkc("δεμοι")
end

@testset "Test adding acute accents to vowels" begin
    @test PolytonicGreek.addacute("α") == "ά"
    @test PolytonicGreek.addacute("αυ") == "αύ"
    @test PolytonicGreek.addacute("ϊ") == "ΐ"
end


@testset "Test adding circumflex accents to vowels" begin
    @test PolytonicGreek.addcircumflex("α") == "ᾶ"
    @test PolytonicGreek.addcircumflex("αυ") == "αῦ"
    @test PolytonicGreek.addcircumflex("ϊ") == "ῗ"
end



@testset "Test extracting syllables from words" begin
    @test PolytonicGreek.antepenult("άνθροπος") == "αν"
    @test PolytonicGreek.penult("άνθροπος") ==  "θρο"
end