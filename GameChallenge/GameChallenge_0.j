library GameChallenge0 uses GameChallengeBase



    

    function InitGameChallenge_0()
        
        GameChalleng_0_JZY = CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE),'np07',-4704,-4064,180)
        GameBiaoJI[0] = CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE),'e007',-4704,-4064,0)

        GameBiaoJI[1] = CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE),'e009',-5889.750,-4103.000,112.537)
        GameBiaoJI[2] = CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE),'e009',-5996.500,-3829.000,112.537)
        GameBiaoJI[3] = CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE),'e009',-6119.000,-3517.000,112.537)
        GameBiaoJI[4] = CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE),'e009',-5674.000,-2726.250,48.455)
        GameBiaoJI[5] = CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE),'e009',-5462.750,-2476.000,48.455)

        for num = 1,5
            SetUnitVertexColor(GameBiaoJI[num],255,255,255,0)
        end
        BJDebugMsg("InitGameChallenge_0")
    endfunction

endlibrary
