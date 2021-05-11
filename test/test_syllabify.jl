
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
    divided = PolytonicGreek.splitdiphthongvowel(dipvowel)
    @test divided == "κελευ ει"
end

@testset "Test splitting on diphthong+vowel" begin
    dipvowel = Unicode.normalize("κελεύει", :NFKC) |> rmaccents
    divided = AtticGreek.splitdiphthongvowel(dipvowel)
    @test divided == "κελευ ει"
end

@testset "Test splitting on vowel+diphthong" begin
    dipvowel = Unicode.normalize("οἰκίαις", :NFKC) |> rmaccents
    divided = AtticGreek.splitvoweldiphthong(dipvowel)
    @test divided == "οἰκι αις"
end


#=
@testset "Test splitting on short vowel followed by vowel" begin
    shortvowel = Unicode.normalize("δέομαι", :NFKC) |> rmaccents
    divided = PolytonicGreek.splitshortvowelvowel(shortvowel)
    @test divided == "δε ομαι"
end

@testset "Test splitting on long vowel followed by vowel" begin
    longvowel = Unicode.normalize("εἰσῄα", :NFKC) |> rmaccents
    divided = PolytonicGreek.splitlongvowelvowel(longvowel)
    @test divided == "εἰσῃ α"
end

=#

@testset "Test splitting on upsilon followed by vowel" begin
    upsilonvowel = Unicode.normalize("θύειν", :NFKC) |> rmaccents
    divided = AtticGreek.splitupsilonvowel(upsilonvowel)
    @test divided == "θυ ειν"
end

@testset "Test splitting on double consonant" begin
    doubled = Unicode.normalize("καταβάλλο", :NFKC) |> rmaccents
    divided = PolytonicGreek.splitdoubleconsonants(doubled)
    @test divided == "καταβαλ λο"
end


@testset "Test splitting on consonant clusters" begin
    cluster = Unicode.normalize("καταισχύνοσι", :NFKC) |> rmaccents
    divided = AtticGreek.splitconsonantcluster(cluster)
    @test divided == "καται σχυνοσι"
end


@testset "Test splitting VCV" begin
    vcv = Unicode.normalize("οδέποτε", :NFKC) |> rmaccents
    divided = AtticGreek.splitvcv(vcv)
    # This is OK:
    # we need a second pass to get full syllabification
    @test divided == "ο δεπο τε" 


    div2 = AtticGreek.splitvcv(divided)
    @test div2 == "ο δε πο τε"
end




@testset "Test syllabification" begin
    @test AtticGreek.syllabify("προΐστεμι", atticGreek())== ["προ","ϊ","στε","μι"]
    @test_broken AtticGreek.syllabify("ἀναμιμνεσκόμενος",atticGreek()) == ["ἀ","να","μι","μνε","σκο","με","νος"]

    @test AtticGreek.syllabify("ἄνδρασι", atticGreek()) == ["ἀν","δρα","σι"]
    @test AtticGreek.syllabify("κελεύει", atticGreek()) == ["κε","λευ","ει"]

    @test_broken AtticGreek.syllabify("οἰκίαις", atticGreek()) == ["οἰ","κι", "αις"]

    @test_broken AtticGreek.syllabify("δέομαι", atticGreek()) == ["δε","ο","μαι"]

    @test AtticGreek.syllabify("θύειν", atticGreek()) == ["θυ","ειν"]



    @test AtticGreek.syllabify("καταβάλλο", atticGreek()) == ["κα","τα","βαλ","λο"]

    @test AtticGreek.syllabify("ἔργμα", atticGreek()) == ["ἐρ", "γμα"]
    @test AtticGreek.syllabify("#γνόμεν", atticGreek()) == ["γνο", "μεν"]
    @test_broken AtticGreek.syllabify("δεδιέναι", atticGreek()) == ["δε","δι","ε","ναι"]


    @test AtticGreek.syllabify("ουδέποτε", atticGreek()) == ["ου","δε","πο","τε"]

    #=
    
    @test syllabify("ποιησαίμην") == ["ποι","η","σαι","μην"]
    
    @test syllabify("ποῖος") == ["ποι", "ος"]
    @test syllabify("αἴει") == ["αἰ"    ,"ει"]
    @test syllabify("ὀίω") == ["ὀι", "ω" ]
    
    
    @test syllabify("ὀΐω") == ["ὀ", "ϊ", "ω" ]
    @test syllabify("ἑωρακυῖα") == ["ἑ", "ω", "ρα", "κυι", "α"]
    =#
end