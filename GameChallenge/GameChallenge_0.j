library GameChallenge0 uses GameChallengeBase



    

    function InitGameChallenge_0()
        
        GameBiaoJI[0] = CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE),'e007',GetUnitX(gg_unit_np07_0001),GetUnitY(gg_unit_np07_0001),0)
        
        GameBiaoJI[1] = CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE),'e009',GetUnitX(gg_unit_e009_0020),GetUnitY(gg_unit_e009_0020),GetUnitFacing(gg_unit_e009_0020))
        RemoveUnit(gg_unit_e009_0020)
        GameBiaoJI[2] = CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE),'e009',GetUnitX(gg_unit_e009_0021),GetUnitY(gg_unit_e009_0021),GetUnitFacing(gg_unit_e009_0021))
        RemoveUnit(gg_unit_e009_0021)
        GameBiaoJI[3] = CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE),'e009',GetUnitX(gg_unit_e009_0018),GetUnitY(gg_unit_e009_0018),GetUnitFacing(gg_unit_e009_0018))
        RemoveUnit(gg_unit_e009_0018)

        

        GameBiaoJI[4] = CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE),'e009',GetUnitX(gg_unit_e009_0022),GetUnitY(gg_unit_e009_0022),GetUnitFacing(gg_unit_e009_0022))
        RemoveUnit(gg_unit_e009_0022)
        GameBiaoJI[5] = CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE),'e009',GetUnitX(gg_unit_e009_0023),GetUnitY(gg_unit_e009_0023),GetUnitFacing(gg_unit_e009_0023))
        RemoveUnit(gg_unit_e009_0023)

        for num = 1,5
            SetUnitVertexColor(GameBiaoJI[num],255,255,255,0)
        end
        BJDebugMsg("InitGameChallenge_0")
    endfunction

endlibrary
