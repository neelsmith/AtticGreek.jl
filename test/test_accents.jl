@testset "Test removing accents" begin
    @test rmaccents("βολêς", atticGreek()) == nfkc("βολες")
    @test rmaccents("τôι", atticGreek()) == nfkc("τοι")
    @test rmaccents("δέμοι", atticGreek()) == nfkc("δεμοι")
end

@testset "Test adding acute accents to vowels" begin
    @test AtticGreek.addacute("α", atticGreek()) == "ά"
    @test AtticGreek.addacute("αυ", atticGreek()) == "αύ"
    @test AtticGreek.addacute("ϊ", atticGreek()) == "ΐ"
end


@testset "Test adding circumflex accents to vowels" begin
    @test AtticGreek.addcircumflex("α", atticGreek()) == "ᾶ"
    @test AtticGreek.addcircumflex("αυ", atticGreek()) == "αῦ"
    @test AtticGreek.addcircumflex("ϊ", atticGreek()) == "ῗ"
end



@testset "Test extracting syllables from words" begin
    @test AtticGreek.antepenult("άνθροπος", atticGreek()) == "αν"
    @test AtticGreek.penult("άνθροπος", atticGreek()) ==  "θρο"
end



@testset "Test flipping grave to acute" begin
    @test AtticGreek.flipaccent("τὰ", atticGreek()) == nfkc("τά")
    @test AtticGreek.flipaccent("τôν", atticGreek()) == nfkc("τôν")
    @test AtticGreek.flipaccent("τά", atticGreek()) == nfkc("τά")
end


@testset "Test stripping consonants" begin
    @test AtticGreek.vowelsonly("τôν", atticGreek()) == "ô"
end


@testset "Test counting accents" begin
    @test AtticGreek.countaccents("ό", atticGreek()) == 1
    @test AtticGreek.countaccents("άνθροπός", atticGreek()) == 2
end


#=

@testset "Test normalizing word string to morphologically normal form" begin
    @test AtticGreek.tokenform("άνθροπός") == nfkc("άνθροπος")
    @test AtticGreek.tokenform("hοδὸν") == nfkc("hοδόν")
end
=#