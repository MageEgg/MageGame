library GameChallengeBase initializer InitGameChallengeFunc uses DamageCode

    int array       GameChallengPlayerInt[12][680]
    unit array      GameChallengPlayerUnit[12][680]
    bool array      GameChallengPlayerBool[12][680]

    unit array      GameChallengMapUnit

    #define GameChallengInt                 GameChallengPlayerInt[pid]
    #define GameChallengUnit                GameChallengPlayerUnit[pid]
    #define GameChallengBool                GameChallengPlayerBool[pid]

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

    function SetUnitAPOfBool(unit u,int boolid)
        int ap = 0
        for pid = 0,3
            if  GameChallengBool[boolid] == false
                if  Player(pid) == GetLocalPlayer()
                    ap = 255
                endif
            endif
        end
        SetUnitVertexColor(u,255,255,255,ap)
    endfunction

endlibrary







