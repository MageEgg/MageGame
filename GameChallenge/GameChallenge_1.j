library GameChallenge_1 initializer InitGameChallenge_1 uses DamageCode,GameChallengBase



    function InitGameChallenge_1()
        unit u = null
        SetUnitVertexColor(gg_unit_np09_0098,255,255,255,0)
        u = CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE),'e001',GetRectMinX(gg_rct_ChallengeRct_1_4),GetRectCenterY(gg_rct_ChallengeRct_1_4))
        SetUnitVertexColor(gg_unit_np09_0098,255,255,255,u)
        u = null
    endfunction

endlibrary