@testset "Test removing accents" begin
    @test rmaccents("βολêς", atticGreek()) == nfkc("βολες")
    @test rmaccents("τôι", atticGreek()) == nfkc("τοι")
    @test rmaccents("δέμοι", atticGreek()) == nfkc("δεμοι")
end