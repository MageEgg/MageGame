library GameChallengeBase uses DamageCode
    int array       GameChallengPlayerInt[12][680]
    unit array      GameChallengPlayerUnit[12][680]
    bool array      GameChallengPlayerBool[12][680]

    unit array      GameChallengMapUnit

    #define GameBiaoJI         GameChallengUnit

    #define GameBiaoJI                      GameChallengMapUnit


    #define GameChalleng_0_JZY              GameChallengMapUnit[500]

    #define GameChalleng_1_YZZ              GameChallengMapUnit[510]
    #define GameChalleng_1_LZZ              GameChallengMapUnit[511]

    function InitGameChallengeFunc()
        ExecuteFunc("InitGameChallenge_0")
        ExecuteFunc("InitGameChallenge_1")
        ExecuteFunc("InitGameChallenge_2")
        ExecuteFunc("InitGameChallenge_3")
        ExecuteFunc("InitGameChallenge_4")
        ExecuteFunc("InitGameChallenge_5")
        ExecuteFunc("InitGameChallenge_6")
        ExecuteFunc("InitGameChallenge_7")
        ExecuteFunc("InitGameChallenge_8")
    endfunction

endlibrary







