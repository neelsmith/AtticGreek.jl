
@testset "Test splitting on morpheme boundary" begin
    morph = nfkc("εισ#έια") |> rmaccents
    divided = PolytonicGreek.splitmorphemeboundary(morph)
    @test divided == "εισ εια"
end

@testset "Test splitting on diaeresis" begin
    diaeresis = Unicode.normalize("προΐστεμι", :NFKC) |> rmaccents
    divided = PolytonicGreek.splitdiaeresis(diaeresis)
    @test divided == "προ ϊστεμι"
end

@testset "Test splitting on mu+nu" begin
    munu = Unicode.normalize("ἀναμιμνεσκόμενος", :NFKC) |> rmaccents
    divided = PolytonicGreek.splitmunu(munu)
    @test divided == "ἀναμι μνεσκομενος"
end

@testset "Test splitting on liquid+consonant" begin
    liqcons = Unicode.normalize("ἄνδρασι", :NFKC) |> rmaccents
    divided = PolytonicGreek.splitliqcons(liqcons)
    @test divided == "ἀν δρασι"
end



@testset "Test splitting on diphthong+vowel" begin
    dipvowel = Unicode.normalize("κελεύει", :NFKC) |> rmaccents
    divided = AtticGreek.splitdiphthongvowel(dipvowel)
    @test divided == "κελευ ει"
end