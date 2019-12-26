library GameChallenge_1 initializer InitGameChallenge_1 uses DamageCode,GameChallengBase



    function InitGameChallenge_1()
        SetUnitVertexColor(gg_unit_np09_0098,255,255,255,0)
        GameChalleng = CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE),'e001',GetRectMinX(gg_rct_ChallengeRct_1_4),GetRectCenterY(gg_rct_ChallengeRct_1_4))
        SetUnitVertexColor(gg_unit_np09_0098,255,255,255,GameChalleng)
    endfunction

endlibrary