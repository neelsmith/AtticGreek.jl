
@testset "Test splitting on morpheme boundary" begin
    morph = nfkc("εισ#έια") |> rmaccents
    divided = PolytonicGreek.splitmorphemes(morph)
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
    #@test AtticGreek.syllabify("προΐστεμι", atticGreek())== ["προ","ϊ","στε","μι"]
    @test AtticGreek.syllabify("αναμιμνεσκόμενος",atticGreek()) == ["α","να","μι","μνε","σκο","με","νος"]

    @test AtticGreek.syllabify("ἄνδρασι", atticGreek()) == ["ἀν","δρα","σι"]
    @test AtticGreek.syllabify("κελεύει", atticGreek()) == ["κε","λευ","ει"]

    @test AtticGreek.syllabify("οικίαις", atticGreek()) == ["οι","κι", "αις"]

    @test AtticGreek.syllabify("δέομαι", atticGreek()) == ["δε","ο","μαι"]

    @test AtticGreek.syllabify("θύειν", atticGreek()) == ["θυ","ειν"]



    @test AtticGreek.syllabify("καταβάλλο", atticGreek()) == ["κα","τα","βαλ","λο"]

    @test AtticGreek.syllabify("ἔργμα", atticGreek()) == ["ἐρ", "γμα"]
    @test AtticGreek.syllabify("#γνόμεν", atticGreek()) == ["γνο", "μεν"]
    @test AtticGreek.syllabify("δεδιέναι", atticGreek()) == ["δε","δι","ε","ναι"]


    

end



@testset "Test syllabification of words in Kleinias decreee" begin
    ag = atticGreek()
    kleinias = " θεοί: έδοχσεν τêι βολêι καὶ τô δέμοι: οινεὶς επρυτάνευε, σπουδίας εγραμμάτευε επεστάτε, κλενίας εῖπε: τὲμ βολὲν καὶ τὸς ἄρχοντας εν τêσι πόλεσι καὶ τὸς επισκόπος επιμέλεσθαι hόπος ὰν χσυλλέγεται hο φόρος κατὰ τὸ έτος hέκαστον καὶ απάγεται αθέναζε: χσύμβολα δὲ ποιέσασθαι πρὸς τὰς πόλες, hόπος ὰμ μὲ εχσêι αδικêν τοῖς απάγοσι τὸμ φόρον: γράφσασα δὲ hε πόλις ες γραμματεῖον τὸμ φόρον, hόντιν' ὰν αποπέμπει, σεμεναμένε τôι συμβόλοι αποπεμπέτο αθέναζε: "
    nopunct = replace(kleinias, r"[,:]" => "")
    wordlist = split(nopunct)
    results = []
    for wd in wordlist
        sylls = AtticGreek.syllabify(wd,ag)
        push!(results, join(sylls, "-"))
    end
    expected = "θε-οι ε-δο-χσεν τει βο-λει και το δε-μοι οι-νεις ε-πρυ-τα-νευ-ε σπου-δι-ας ε-γραμ-μα-τευ-ε ε-πε-στα-τε κλε-νι-ας ει-πε τεμ βο-λεν και τος ἀρ-χον-τας εν τε-σι πο-λε-σι και τος ε-πι-σκο-πος ε-πι-με-λε-σθαι hο-πος αν χσυλ-λε-γε-ται hο φο-ρος κα-τα το ε-τος hε-κα-στον και α-πα-γε-ται α-θε-να-ζε χσυμ-βο-λα δε ποι-ε-σα-σθαι προς τας πο-λες hο-πος αμ με ε-χσει α-δι-κεν τοις α-πα-γο-σι τομ φο-ρον γρα-φσα-σα δε hε πο-λις ες γραμ-μα-τει-ον τομ φο-ρον hον-τιν' αν α-πο-πεμ-πει σε-με-να-με-νε τοι συμ-βο-λοι α-πο-πεμ-πε-το α-θε-να-ζε"
    @test join(results," ") == expected
    
end

@testset "Test syllabificatoin of tokens including metacharacters" begin
    @test AtticGreek.syllabify("ο_δέποτε", atticGreek()) == ["ο_","δε","πο","τε"]
end