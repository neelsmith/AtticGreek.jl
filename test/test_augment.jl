
@testset "Test augment" begin
    ag = atticGreek()

    @test  augment(ag) == "ε"

    @test augment(ag; s = "κελευε") == nfkc("εκελευε")
    @test augment(ag; s = "ρυε") == nfkc("ερρυε")


    @test augment(ag; s = "ελπιζε") == nfkc("ε_λπιζε")
    @test augment(ag; s = "hοριζε") == nfkc("hο_ριζε")

    @test augment(ag; s = "hαιρει") == nfkc("hε_ιρει")

    @test augment(ag; s = "hικετευε") == nfkc("hι_κετευε")

    @test augment(ag; s = "ακουσε") == nfkc("ε_κουσε")

    @test augment_initial(ag) == augment_medial(ag) == "ε"
    #=
    
    @test augment(ag; s = "εἰκαζε") == nfkc("ᾐκαζε")
    @test augment(ag; s = "οἰκει") == nfkc("ᾠκει")
    @test augment(ag; s = "αὐλησε") == nfkc("ηὐλησε")
    @test augment(ag; s = "εὐχετο") == nfkc("ηὐχετο")

    
   
    
    @test augment(ag; s = "ὑβριζε") == nfkc("ὑ_βριζε")
   =#
    
end
