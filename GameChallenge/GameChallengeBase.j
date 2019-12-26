library GameChallengeBase initializer InitGameChallenge uses DamageCode
    int array       GameChallengPlayerInt[12][680]
    unit array      GameChallengPlayerUnit[12][680]
    bool array      GameChallengPlayerBool[12][680]

    unit array      GameChallengUnit

    #define GameChalleng_1_YZZ GameChallengUnit[0]
    #define GameChalleng_1_LZZ GameChallengUnit[1]

    function InitGameChallengeFunc()
        ExecuteFunc("InitGameChallenge_1")
        ExecuteFunc("InitGameChallenge_2")
        ExecuteFunc("InitGameChallenge_3")
        ExecuteFunc("InitGameChallenge_4")
        ExecuteFunc("InitGameChallenge_5")
        ExecuteFunc("InitGameChallenge_6")
        ExecuteFunc("InitGameChallenge_7")
        ExecuteFunc("InitGameChallenge_8")
        DestroyTrigger(GetTriggeringTrigger())
    endfunction

    function InitGameChallenge()
        trigger trg = CreateTrigger()
        TriggerRegisterTimerEventSingle(trg,0 )
        TriggerAddAction(trg, function InitGameChallengeFunc)
    endfunction
endlibrary







