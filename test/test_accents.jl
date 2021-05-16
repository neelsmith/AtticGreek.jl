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
    @test_broken AtticGreek.antepenult("άνθροπος", atticGreek()) == "αν"
    @test_broken AtticGreek.penult("άνθροπος", atticGreek()) ==  "θρο"
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


@testset "Test stripping enclitic" begin
    ag = atticGreek()
    @test AtticGreek.stripenclitic("άνθροπός", ag) == nfkc("άνθροπος")
end


@testset "Test normalizing word string to morphologically normal form" begin
    ag = atticGreek()
    @test AtticGreek.tokenform("άνθροπός", ag) == nfkc("άνθροπος")
    @test AtticGreek.tokenform("hοδὸν", ag) == nfkc("hοδόν")
end




@testset "Test adding accents to words" begin
    ag = atticGreek()
    @test AtticGreek.accentword("ανθρο_πος", :RECESSIVE, ag) == nfkc("άνθρο_πος")
    @test AtticGreek.accentword("ανθρο_πο_ς", :RECESSIVE, ag) == nfkc("ανθρό_πο_ς")
    @test AtticGreek.accentword("ανθρο_ποι", :RECESSIVE, ag) == nfkc("άνθρο_ποι")
    @test AtticGreek.accentword("θεραπαιναι", :RECESSIVE, ag) == nfkc("θεράπαιναι")
    @test AtticGreek.accentword("δο_ρον", :PENULT, ag) == nfkc("δô_ρον")
    @test AtticGreek.accentword("δο_ρο_ι", :PENULT, ag) == nfkc("δό_ρο_ι")
end





@testset "Test adding accent to specified syllable of word" begin
    ag = atticGreek()
    @test AtticGreek.accentpenult("γνο_με_", :ACUTE, ag) == nfkc("γνό_με_")
    @test AtticGreek.accentultima("γνο_μο_ν", :CIRCUMFLEX, ag) == nfkc("γνο_μô_ν")
    @test AtticGreek.accentantepenult("εκελευον", ag) == "εκέλευον"
end
