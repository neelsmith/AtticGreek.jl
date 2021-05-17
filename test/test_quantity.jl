

@testset "Test stripping explicit long mark" begin
    s = nfkc("γνόμα_ς")
    expected = nfkc("γνόμας")
    @test PolytonicGreek.stripquant(s) == expected
end


@testset "Test removing accents from long syllables" begin
    ag = atticGreek()
    @test rmaccents(nfkc("πᾶ_σι"), ag) == nfkc("πα_σι")
end



@testset "Test adding acute to long vowel" begin
    ag = atticGreek()
    @test AtticGreek.addacute("α_", ag) == nfkc("ά_")
end


@testset "Test adding circumflex to long vowel" begin
    ag = atticGreek()
    @test AtticGreek.addcircumflex("α_", ag) == nfkc("ᾶ_")
end


@testset "Test flipping barytone with long vowel" begin
    ag = atticGreek()
    @test AtticGreek.flipaccent(nfkc("ὰ_"), ag) == nfkc("ά_")
end



@testset "Test adding accents to syllables with long vowels" begin
    ag = atticGreek()
    @test AtticGreek.accentsyllable("τα_ν", :CIRCUMFLEX, ag) == "τᾶ_ν"
    @test AtticGreek.accentsyllable("τα_", :ACUTE, ag) == "τά_"
end


@testset "Test quantity of syllable" begin
    ag = atticGreek()
    @test AtticGreek.longsyllable("τά", ag) == false
    @test AtticGreek.longsyllable("μα_ς", ag)
    @test AtticGreek.longsyllable("λευ", ag)
end


@testset "Test recognizing final οι/αι as short" begin
    ag = atticGreek()
    @test AtticGreek.finallong("οι", ag) == false
    #@test accentword("ἀνθρωποι", :RECESSIVE) == nfkc("ἄνθρωποι")
    #@test accentword("γνωμα_ς", :PENULT) == nfkc("γνώμα_ς")
end

@testset "Test recognizing non-final οι/αι as long" begin
    ag = atticGreek()
    @test AtticGreek.finallong("οις", ag) 
end


@testset "Test circumflex on ascii base character" begin
    ag = atticGreek()
    @test AtticGreek.longsyllable("êς", ag)
    @test AtticGreek.longsyllable("ôν", ag)
end

@testset "Test explicitly marked long vowels" begin
    ag = atticGreek()
    @test AtticGreek.finallong("ο_ν", ag)
    @test AtticGreek.finallong("ε_ς", ag)
end