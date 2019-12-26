library GameChallenge1 initializer InitGameChallenge_1 uses GameChallengeBase



    function InitGameChallenge_1()
        SetUnitVertexColor(gg_unit_np09_0098,255,255,255,0)
        GameChalleng_1_LZZ = CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE),'e001',GetRectMinX(gg_rct_ChallengeRct_1_4),GetRectCenterY(gg_rct_ChallengeRct_1_4),0)
        SetUnitVertexColor(GameChalleng_1_LZZ,255,255,255,0)
        BJDebugMsg("InitGameChallenge_1")
    endfunction

endlibrary
