library GameChallenge1 uses GameChallengeBase



    

    function InitGameChallenge_1()
        
        GameChalleng_1_YZZ = CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE),'np09',-6240,1280,270)
        SetUnitVertexColor(GameChalleng_1_YZZ,255,255,255,0)

        SetUnitVertexColor(GameChalleng_1_LZZ,255,255,255,0)
        GameChalleng_1_LZZ = CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE),'e001',GetRectMinX(gg_rct_ChallengeRct_1_4),GetRectCenterY(gg_rct_ChallengeRct_1_4),0)
        
        
    endfunction

endlibrary
